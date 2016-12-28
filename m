Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1482398755-9235-1-git-send-email-maxime.chevallier@smile.fr>
References: <1482398755-9235-1-git-send-email-maxime.chevallier@smile.fr>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Dec 2016 11:14:01 +0200
Message-ID: <CABBYNZLofQ+YkhaovQLt0yty8Tapa_d_pRErugQ+uZAjFojUDw@mail.gmail.com>
Subject: Re: [PATCH] tools/btgatt-client: Fixed register-notify prompt
To: Maxime Chevallier <maxime.chevallier@smile.fr>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Maxime,

On Thu, Dec 22, 2016 at 11:25 AM, Maxime Chevallier
<maxime.chevallier@smile.fr> wrote:
> When using the register-notify command in btgatt-client, the prompt
> would be broken :
>
> [GATT client]# register-notify 0x005f
> Registering notify handler with id: 2
> [GATT client]# [GATT client]# Registered notify handler![GATT client]#
>
> This commit fixes the prompt by using the correct printing function and
> adding an extra '\n' :
>
> [GATT client]# register-notify 0x005f
> Registering notify handler with id: 2
> [GATT client]# Registered notify handler
> [GATT client]#
> ---
>  tools/btgatt-client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index 4c8c9dd..40a03b1 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -1114,7 +1114,7 @@ static void register_notify_cb(uint16_t att_ecode, void *user_data)
>                 return;
>         }
>
> -       PRLOG("Registered notify handler!");
> +       PRLOG("Registered notify handler\n");
>  }
>
>  static void cmd_register_notify(struct client *cli, char *cmd_str)
> @@ -1149,7 +1149,7 @@ static void cmd_register_notify(struct client *cli, char *cmd_str)
>                 return;
>         }
>
> -       PRLOG("Registering notify handler with id: %u\n", id);
> +       printf("Registering notify handler with id: %u\n", id);
>  }
>
>  static void unregister_notify_usage(void)
> --
> 2.1.4

Applied, thanks.


-- 
Luiz Augusto von Dentz
