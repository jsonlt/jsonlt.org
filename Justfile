set shell := ['uv', 'run', '--frozen', 'bash', '-euxo', 'pipefail', '-c']
set unstable
set positional-arguments

project := "jsonlt-org"
pnpm := "pnpm exec"

# List available recipes
default:
  @just --list

# Build the site
build:
  pnpm build

# Clean build artifacts
clean:
  rm -rf dist .astro

# Deploy to production
deploy:
  {{pnpm}} wrangler deploy

# Deploy to preview environment
deploy-preview pr_number:
  {{pnpm}} wrangler deploy --env preview --name jsonlt-website-preview-pr-{{pr_number}}

# Start development server
dev:
  pnpm dev

# Format code
format:
  {{pnpm}} biome format --write .

# Fix code issues
fix:
  {{pnpm}} biome check --write .

# Install all dependencies (Python + Node.js)
install: install-node install-python

# Install only Node.js dependencies
install-node:
  #!/usr/bin/env bash
  pnpm install --frozen-lockfile

# Install pre-commit hooks
install-prek:
  prek install

# Install only Python dependencies
install-python:
  #!/usr/bin/env bash
  uv sync --frozen

# Run all linters
lint: lint-markdown lint-prose lint-web

# Lint Markdown files
lint-markdown:
  {{pnpm}} markdownlint-cli2 "**/*.md"

# Lint prose in documentation
lint-prose:
  vale src/**/*.md

# Lint web files (CSS, HTML, JS, JSON)
lint-web:
  {{pnpm}} biome check .

# Run pre-commit hooks on changed files
prek:
  prek

# Run pre-commit hooks on all files
prek-all:
  prek run --all-files

# Preview the built site locally
preview:
  pnpm preview

# Sync Vale styles and dictionaries
vale-sync:
  vale sync
