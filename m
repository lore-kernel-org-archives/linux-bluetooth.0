Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1389371461-11578-1-git-send-email-sebastianx.chlad@intel.com>
References: <1389371461-11578-1-git-send-email-sebastianx.chlad@intel.com>
Date: Mon, 13 Jan 2014 12:15:24 +0200
Message-ID: <CABBYNZKuocUb4StXWW_jR9vF-X6pQJTBsPPYMLyiEz-X8VMZ8g@mail.gmail.com>
Subject: Re: [PATCH] tools/bluetooth-player: check path validity
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Fri, Jan 10, 2014 at 6:31 PM, Sebastian Chlad
<sebastianx.chlad@intel.com> wrote:
> Bluetooth-player change-folder cmd approves any argument however it
> can be and then should a valid path only. Failing in providing
> a valid path crashes bluetooth-player thus argument should be
> checked if it's a valid path.
> ---
>  tools/bluetooth-player.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
> index 2afdd17..f10d9be 100644
> --- a/tools/bluetooth-player.c
> +++ b/tools/bluetooth-player.c
> @@ -738,6 +738,11 @@ static void cmd_change_folder(int argc, char *argv[])
>                 return;
>         }
>
> +       if (dbus_validate_path(argv[1], NULL) == FALSE) {
> +               rl_printf("Not a valid path\n");
> +               return;
> +       }
> +
>         if (check_default_player() == FALSE)
>                 return;
>
> --
> 1.8.3.2

Pushed, thanks.


-- 
Luiz Augusto von Dentz
