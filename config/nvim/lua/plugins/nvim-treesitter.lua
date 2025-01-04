return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
  opts = {
    ensure_installed = {
      "rust",
      "markdown",
      "markdown_inline",
      "json5",
      "javascript",
      "typescript",
      "yaml",
      "html",
      "css",
      "scss",
      "bash",
      "lua",
      "dockerfile",
      "python",
      "toml",
      "regex",
      "vim",
      "vimdoc",
      "query",
      "c",
      "sql",
      "tsx",
      "c_sharp",
      "java",
      "go",
      "gomod",
      "gosum",
      "http",
    },
    auto_install = false,
    highlight = {
      enable = true,
      disable = { "dockerfile" },
    },
  },
}
