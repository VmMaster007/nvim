 -- lua/plugins/dashboard.lua
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Header (you can swap this ASCII later)
dashboard.section.header.val = {
  "███████╗ █████╗ ██╗   ██╗██╗   ██╗██╗   ██╗███████╗██████╗ ███████╗███╗   ██╗",
  "██╔════╝██╔══██╗██║   ██║██║   ██║╚██╗ ██╔╝██╔════╝██╔══██╗██╔════╝████╗  ██║",
  "███████╗███████║██║   ██║██║   ██║ ╚████╔╝ ███████╗██████╔╝█████╗  ██╔██╗ ██║",
  "╚════██║██╔══██║╚██╗ ██╔╝╚██╗ ██╔╝  ╚██╔╝  ╚════██║██╔═══╝ ██╔══╝  ██║╚██╗██║",
  "███████║██║  ██║ ╚████╔╝  ╚████╔╝    ██║   ███████║██║     ███████╗██║ ╚████║",
  "╚══════╝╚═╝  ╚═╝  ╚═══╝    ╚═══╝     ╚═╝   ╚══════╝╚═╝     ╚══════╝╚═╝  ╚═══╝",
  "                                                                             ",
}
    -- Buttons (same layout as the screenshot)
    local b = dashboard.button
    dashboard.section.buttons.val = {
      b("f", "  Find file",        ":Telescope find_files<CR>"),
      b("n", "  New file",         ":ene | startinsert<CR>"),
      b("r", "  Recent files",     ":Telescope oldfiles<CR>"),
      b("g", "  Find text",        ":Telescope live_grep<CR>"),
      b("c", "  Config",           ":e $MYVIMRC<CR>"),
      b("s", "  Restore Session",  ":lua require('persistence').load()<CR>"),
      b("l", "󰒲  Lazy",             ":Lazy<CR>"),
      b("q", "  Quit",             ":qa<CR>"),
    }

    -- Footer with Lazy stats (plugins + startup time)
    local function footer()
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      return "  Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
    end
    dashboard.section.footer.val = footer()

    -- Style tweaks
    dashboard.opts.layout[1].val = 2
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    alpha.setup(dashboard.opts)

    -- Update footer after Lazy finishes (fresh installs)
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function() dashboard.section.footer.val = footer(); pcall(vim.cmd.AlphaRedraw) end,
    })
  end,
}

