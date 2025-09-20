-- lua/plugins/nvim-tree.lua
-- (your header left as-is)

return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, but nice to have
  config = function()
    -- Remove background color from the NvimTree Window
    vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])

    -- ✅ Add the keymap for <leader>e
    -- Make sure vim.g.mapleader = " " is set at the very top of your init.lua
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { silent = true, noremap = true, desc = "File Explorer" })

    require("nvim-tree").setup({
      filters = {
        dotfiles = false, -- Show hidden files (dotfiles)
      },
      view = {
        adaptive_size = true,
      },
    })
  end,
}

