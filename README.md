# nvim-yui

Persistent floating terminal toggle for [yui](https://github.com/tilaktilak/yui) inside Neovim.

- `<leader>yui` opens yui in a floating terminal
- `<Esc>` hides the window without killing the process
- Reopening restores the same session

## Install

### lazy.nvim / LazyVim

```lua
{
  "tilaktilak/nvim-yui",
  keys = {
    { "<leader>yui", function() require("yui").toggle() end, desc = "Toggle Yui" },
  },
}
```

Or with `setup()` for a custom keymap:

```lua
{
  "tilaktilak/nvim-yui",
  config = function()
    require("yui").setup({ keymap = "<leader>yui" })
  end,
}
```
