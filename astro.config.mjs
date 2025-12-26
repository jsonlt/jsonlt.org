// @ts-check

import cloudflare from "@astrojs/cloudflare";
import starlight from "@astrojs/starlight";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig } from "astro/config";

// https://astro.build/config
export default defineConfig({
  integrations: [
    starlight({
      title: "JSONLT",
      customCss: ["./src/styles/starlight.css"],
      social: [
        {
          icon: "github",
          label: "GitHub",
          href: "https://github.com/jsonlt",
        },
      ],
      logo: {
        src: "./src/assets/icon.svg",
      },
      sidebar: [
        {
          label: "Specification",
          link: "/specification/",
          attrs: { target: "_self" },
          badge: { text: "↗", variant: "tip" },
        },
        {
          label: "Home",
          link: "/docs/",
        },
        {
          label: "Introduction",
          items: [
            { slug: "docs/introduction" },
            { slug: "docs/conventions" },
            { slug: "docs/roadmap" },
            { slug: "docs/support" },
            { slug: "docs/acknowledgements" },
          ],
        },
        { slug: "docs/install" },
        {
          label: "Tutorials",
          items: [{ slug: "docs/tutorials" }],
        },
        {
          label: "Guides",
          items: [{ slug: "docs/guides" }],
        },
        {
          label: "Explanation",
          items: [{ slug: "docs/explanation" }],
        },
        {
          label: "Reference",
          items: [{ slug: "docs/reference" }, { slug: "docs/reference/glossary" }],
        },
      ],
      disable404Route: true,
    }),
  ],

  adapter: cloudflare({ imageService: "compile" }),

  vite: {
    plugins: [tailwindcss()],
  },
});
