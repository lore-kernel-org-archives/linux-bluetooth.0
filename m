Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20180823200854.19103-1-brian.gix@intel.com>
References: <20180823200854.19103-1-brian.gix@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Aug 2018 10:48:28 +0300
Message-ID: <CABBYNZKN6pUh2LCO36aFvsX8KLW8XrT+j6o78SsTjYON12RUcw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/1] mesh: Fixed warning-to-error from GCC 8.1.1
To: Brian Gix <brian.gix@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, "Stotland, Inga" <inga.stotland@intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>, Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Thu, Aug 23, 2018 at 11:08 PM, Brian Gix <brian.gix@intel.com> wrote:
> Fixed compiler flagged unsafe usage of strncpy
> ---
>  mesh/storage.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/mesh/storage.c b/mesh/storage.c
> index 85fa81dda..937f801a6 100644
> --- a/mesh/storage.c
> +++ b/mesh/storage.c
> @@ -298,13 +298,11 @@ bool storage_parse_config(struct mesh_net *net, const char *config_name)
>         result = parse_config(net, config_name, false);
>
>         if (!result) {
> -               char *bak = (char *) l_malloc(strlen(config_name) + 5);
> -
> -               if (!bak)
> -                       goto done;
> +               size_t len = strlen(config_name) + 5;
> +               char *bak = l_malloc(len);

I would consider allocating bak in the stack, or perhaps use alloca if
you don't want to waste stack space, that way we don't have to free
these string that are just used temporarily.

>
>                 /* Fall-back to Backup version */
> -               strncpy(bak, config_name, strlen(config_name) + 1);
> +               strncpy(bak, config_name, len);
>                 bak = strncat(bak, ".bak", 5);
>
>                 remove(config_name);
> @@ -592,15 +590,13 @@ struct write_info {
>  static void idle_save_config(void *user_data)
>  {
>         struct write_info *info = user_data;
> -       char *tmp = (char *) l_malloc(strlen(info->config_name) + 5);
> -       char *bak = (char *) l_malloc(strlen(info->config_name) + 5);
> +       size_t len = strlen(info->config_name) + 5;
> +       char *tmp = l_malloc(len);
> +       char *bak = l_malloc(len);

Same here.

>         bool result = false;
>
> -       if (!tmp || !bak)
> -               goto done;
> -
> -       strncpy(tmp, info->config_name, strlen(info->config_name)  + 1);
> -       strncpy(bak, info->config_name, strlen(info->config_name)  + 1);
> +       strncpy(tmp, info->config_name, len);
> +       strncpy(bak, info->config_name, len);
>         tmp = strncat(tmp, ".tmp", 5);
>         bak = strncat(bak, ".bak", 5);
>         remove(tmp);
> @@ -615,7 +611,6 @@ static void idle_save_config(void *user_data)
>         }
>
>         remove(tmp);
> -done:
>         l_free(tmp);
>         l_free(bak);
>
> --
> 2.17.1
>



-- 
Luiz Augusto von Dentz
