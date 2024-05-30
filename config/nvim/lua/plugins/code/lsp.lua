return {
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "SmiteshP/nvim-navbuddy", -- breadcrumbs
    lazy = true,
    dependencies = {
      "SmiteshP/nvim-navic",
      "MunifTanjim/nui.nvim",
    },
    opts = { lsp = { auto_attach = true } },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "SmiteshP/nvim-navbuddy",
      "b0o/schemastore.nvim",
    },
    config = function()
      -- import lspconfig plugin
      local lspconfig = require("lspconfig")

      -- import cmp-nvim-lsp plugin
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs =
        { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- configure html server
      lspconfig["html"].setup({
        capabilities = capabilities,
      })

      -- configure tailwindcss server
      lspconfig["tailwindcss"].setup({
        capabilities = capabilities,
      })

      -- configure typescript server
      lspconfig["vtsls"].setup({
        capabilities = capabilities,
      })

      -- configure eslint server
      lspconfig["eslint"].setup({
        capabilities = capabilities,
        settings = {
          -- TODO: wait till using flat config then can remove the bottom line
          experimental = { useFlatConfig = false },
        },
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      })

      -- configure python server
      lspconfig["basedpyright"].setup({
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
            },
          },
        },
      })

      -- configure ruff server
      lspconfig["ruff"].setup({
        capabilities = capabilities,
      })

      -- configure json server
      lspconfig["jsonls"].setup({
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- configure toml server
      lspconfig["taplo"].setup({
        capabilities = capabilities,
      })

      -- configure yaml server
      lspconfig["yamlls"].setup({
        capabilities = capabilities,
      })

      -- configure markdown server
      lspconfig["marksman"].setup({
        capabilities = capabilities,
      })

      -- configure bash server
      lspconfig["bashls"].setup({
        capabilities = capabilities,
      })

      -- configure lua server (with special settings)
      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        settings = { -- custom settings for lua
          Lua = {
            -- make the language server recognize "vim" global
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- make language server aware of runtime files
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
    end,
  },
}
