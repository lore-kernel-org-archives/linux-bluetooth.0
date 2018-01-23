Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1f42874f-efcf-f50c-ef2b-a9b709d93db4@jp.fujitsu.com>
References: <1f42874f-efcf-f50c-ef2b-a9b709d93db4@jp.fujitsu.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jan 2018 15:42:16 -0200
Message-ID: <CABBYNZLxGhTmYda3uVFAnErdiUUFmX3vKvVG7a0WJjN6RgSGnA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] obexd: Clean up unneeded list in src/obex.c
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Tue, Jan 23, 2018 at 7:45 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Cleans up the sessions list which has been unneeded by commit 8572afb4
> ("obexd: Make use of transport drivers and some cleanups").
> ---
>  obexd/src/obex.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index 308e56d07..a4bae857f 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -54,8 +54,6 @@
>  #include "service.h"
>  #include "transport.h"
>
> -static GSList *sessions = NULL;
> -
>  typedef struct {
>         uint8_t  version;
>         uint8_t  flags;
> @@ -233,8 +231,6 @@ static void os_reset_session(struct obex_session *os)
>
>  static void obex_session_free(struct obex_session *os)
>  {
> -       sessions = g_slist_remove(sessions, os);
> -
>         if (os->io) {
>                 g_io_channel_shutdown(os->io, TRUE, NULL);
>                 g_io_channel_unref(os->io);
> @@ -1067,8 +1063,6 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
>         obex_getsockname(os, &os->src);
>         obex_getpeername(os, &os->dst);
>
> -       sessions = g_slist_prepend(sessions, os);
> -
>         return 0;
>  }
>
> --
> 2.14.1

Applied, thanks.

-- 
Luiz Augusto von Dentz
