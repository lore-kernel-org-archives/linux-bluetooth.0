Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
References: <1382608464-10389-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 24 Oct 2013 18:34:10 +0300
Message-ID: <CABBYNZJwYOy1XuN0WGk-pX2YKpAUhvpAS=-DmCrRdE0iKVsUrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] android: Start command watch after notify channel
 is connected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Oct 24, 2013 at 12:54 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> From: Szymon Janc <szymon.janc@gmail.com>
>
> Daemon should start processing commands only after both communication
> channels were connected.
> ---
>  android/main.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/android/main.c b/android/main.c
> index 9879f05..740b532 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -288,9 +288,11 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
>
>         g_io_add_watch(io, cond, notif_watch_cb, NULL);
>
> -       info("Successfully connected to HAL");
> +       cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
>
> -       /* TODO start handling commands */
> +       g_io_add_watch(hal_cmd_io, cond, cmd_watch_cb, NULL);
> +
> +       info("Successfully connected to HAL");
>
>         return FALSE;
>  }
> @@ -305,10 +307,6 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
>                 return FALSE;
>         }
>
> -       cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
> -
> -       g_io_add_watch(io, cond, cmd_watch_cb, NULL);
> -
>         hal_notif_io = connect_hal(notif_connect_cb);
>         if (!hal_notif_io) {
>                 error("Cannot connect to HAL, terminating");
> --
> 1.8.4

Pushed, thanks.


-- 
Luiz Augusto von Dentz
