Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180819213026.28429-1-inga.stotland@intel.com>
References: <20180819213026.28429-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Aug 2018 11:01:46 +0300
Message-ID: <CABBYNZKZii3sQv-mv-xyiko9t=KaV7iQ2v8Arat5sR5NbNM-sA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/meshctl: Fix default directory for JSON files
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Mon, Aug 20, 2018 at 12:30 AM, Inga Stotland <inga.stotland@intel.com> wrote:
> This fixes the name of default directory that contains sample JSON files.

Just a note regarding modifying/using files on the tree, as we
experience here it is a bad idea since once we move or it is changed
this code would have to be changed as well. Also I remember commenting
that if the configuration is changed by meshctl your tree will then
contain changes that shall not be applied, so instead of changing the
file in place Id make a default location something like
~/.config/meshctl/ and copy over the .json files there if they don't
exist, that way we avoid having to carry changes in the tree.

> ---
>  tools/meshctl.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/tools/meshctl.c b/tools/meshctl.c
> index 3e1484f61..a8468b716 100644
> --- a/tools/meshctl.c
> +++ b/tools/meshctl.c
> @@ -1913,21 +1913,20 @@ int main(int argc, char *argv[])
>         bt_shell_set_prompt(PROMPT_OFF);
>
>         if (!mesh_config_dir) {
> -               bt_shell_printf("Local config directory not provided.\n");
> -               mesh_config_dir = "";
> -       } else {
> -               bt_shell_printf("Reading prov_db.json and local_node.json from"
> -                               " %s\n", mesh_config_dir);
> +               printf("Local config directory not provided.\n");
> +               mesh_config_dir = "mesh";
>         }
>
> +       printf("Reading prov_db.json and local_node.json from"
> +                               " %s directory\n", mesh_config_dir);
> +
>         len = strlen(mesh_config_dir);
> -       if (len && mesh_config_dir[len - 1] != '/') {
> +
> +       if (len && mesh_config_dir[len - 1] != '/')
>                 extra = 1;
> -               bt_shell_printf("mesh_config_dir[%d] %s\n", len,
> -                                               &mesh_config_dir[len - 1]);
> -       } else {
> +       else
>                 extra = 0;
> -       }
> +
>         mesh_local_config_filename = g_malloc(len + strlen("local_node.json")
>                                                                         + 2);
>         if (!mesh_local_config_filename)
> @@ -1956,6 +1955,7 @@ int main(int argc, char *argv[])
>
>         sprintf(mesh_prov_db_filename, "%s", mesh_config_dir);
>         len = strlen(mesh_config_dir);
> +
>         if (extra)
>                 sprintf(mesh_prov_db_filename + len , "%c", '/');
>
> --
> 2.14.4
>



-- 
Luiz Augusto von Dentz
