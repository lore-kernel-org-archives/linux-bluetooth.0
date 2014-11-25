Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416868537-2478-1-git-send-email-szymon.janc@tieto.com>
References: <1416868537-2478-1-git-send-email-szymon.janc@tieto.com>
Date: Tue, 25 Nov 2014 12:13:42 +0100
Message-ID: <CAN_7+YaBXe2cg2iJL2nGkyBWr5Oh4PJ2raLjC4UsyzyssMaiJA@mail.gmail.com>
Subject: Re: [PATCH] shared/io-glib: Fix not calling destroy callback
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 24, 2014 at 11:35 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
> Destroy callback should be called also for G_IO_ERR | G_IO_NVAL
> condition.
> ---
>  src/shared/io-glib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/src/shared/io-glib.c b/src/shared/io-glib.c
> index af2ba4e..e9578e1 100644
> --- a/src/shared/io-glib.c
> +++ b/src/shared/io-glib.c
> @@ -159,9 +159,11 @@ static gboolean watch_callback(GIOChannel *channel, GIOCondition cond,
>                                                         gpointer user_data)
>  {
>         struct io_watch *watch = user_data;
> -       bool result;
> +       bool result, destroy;
>
> -       if (cond & (G_IO_ERR | G_IO_NVAL))
> +       destroy = watch == watch->io->disconnect_watch;
> +
> +       if (!destroy && (cond & (G_IO_ERR | G_IO_NVAL)))
>                 return FALSE;
>
Just tested this patch and it works for me.
It also looks good to me.

\Lukasz
>         if (watch->callback)
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
