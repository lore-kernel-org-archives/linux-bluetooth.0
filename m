Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180907232544.23821-1-inga.stotland@intel.com>
References: <20180907232544.23821-1-inga.stotland@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 11 Sep 2018 11:47:13 +0300
Message-ID: <CABBYNZLLV2odxyJj_3RdT_0dDKgFQViJQVeGynrszre339Go0g@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Add clean up on start up failure
To: Inga Stotland <inga.stotland@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Sat, Sep 8, 2018 at 2:25 AM, Inga Stotland <inga.stotland@intel.com> wrote:
> Call bt_shell_clanup if failed to start the tool.
> ---
>  mesh/btmesh.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mesh/btmesh.c b/mesh/btmesh.c
> index 108ec39f3..6a005a978 100644
> --- a/mesh/btmesh.c
> +++ b/mesh/btmesh.c
> @@ -137,8 +137,8 @@ int main(int argc, char *argv[])
>         bt_shell_set_menu(&main_menu);
>
>         if (!index_option) {
> -               bt_shell_usage();
> -               return 0;
> +               l_info("Controller index is required");
> +               goto fail;
>         }
>
>         if (config_option)
> @@ -156,8 +156,7 @@ int main(int argc, char *argv[])
>         mesh = mesh_new(index, config_option);
>         if (!mesh) {
>                 l_info("Failed to create mesh\n");
> -               bt_shell_cleanup();
> -               return EXIT_FAILURE;
> +               goto fail;
>         }
>
>         if (save_option)
> @@ -172,6 +171,9 @@ int main(int argc, char *argv[])
>         mesh_unref(mesh);
>         mesh_cleanup();
>         l_main_exit();
> -
>         return status;
> +
> +fail:
> +       bt_shell_cleanup();
> +       return EXIT_FAILURE;
>  }
> --
> 2.17.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
