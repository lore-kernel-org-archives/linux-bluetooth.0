Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1434899332-5208-1-git-send-email-mrlemux@gmail.com>
References: <1434899332-5208-1-git-send-email-mrlemux@gmail.com>
Date: Tue, 23 Jun 2015 18:29:16 +0300
Message-ID: <CABBYNZLkEQOXe6293+5brnCkrsd17KQLibX=ngD9KPQGMwyGgg@mail.gmail.com>
Subject: Re: [PATCH v2] client: Display address if calling 'disconnect'
 without arguments
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mateusz Lemusisk <mrlemux@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mateusz,

On Sun, Jun 21, 2015 at 6:08 PM, Mateusz Lemusisk <mrlemux@gmail.com> wrote:
> Simplified the patch
> ---
>  client/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/client/main.c b/client/main.c
> index 41e95b2..f1a600f 100644
> --- a/client/main.c
> +++ b/client/main.c
> @@ -1421,7 +1421,12 @@ static void cmd_disconn(const char *arg)
>                 rl_printf("Failed to disconnect\n");
>                 return;
>         }
> +       if (strlen(arg) == 0) {
> +               DBusMessageIter iter;
>
> +               if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
> +                   dbus_message_iter_get_basic(&iter, &arg);
> +       }
>         rl_printf("Attempting to disconnect from %s\n", arg);
>  }
>
> --
> 2.4.2

Applied, thanks.


-- 
Luiz Augusto von Dentz
