local M = {}

local state = { buf = nil, win = nil }

local function open_float(buf)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.85)
  return vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })
end

function M.toggle()
  -- Hide if currently visible
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_hide(state.win)
    state.win = nil
    return
  end

  -- Create buffer + terminal if first time (or yui exited)
  if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
    state.buf = vim.api.nvim_create_buf(false, true)
    state.win = open_float(state.buf)
    vim.fn.termopen("yui", {
      on_exit = function()
        state.buf = nil
        state.win = nil
      end,
    })
    -- <Esc> hides the window instead of closing the terminal
    vim.keymap.set("t", "<Esc>", function()
      vim.api.nvim_win_hide(state.win)
      state.win = nil
    end, { buffer = state.buf })
  else
    -- Reopen the existing running terminal
    state.win = open_float(state.buf)
  end

  vim.cmd("startinsert")
end

function M.setup(opts)
  opts = opts or {}
  local key = opts.keymap or "<leader>yui"

  vim.keymap.set("n", key, M.toggle, { desc = "Toggle Yui" })
end

return M
