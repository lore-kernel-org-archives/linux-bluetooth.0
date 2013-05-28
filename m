Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369696024-27434-2-git-send-email-gustavo@padovan.org>
References: <1369696024-27434-1-git-send-email-gustavo@padovan.org>
	<1369696024-27434-2-git-send-email-gustavo@padovan.org>
Date: Tue, 28 May 2013 01:13:34 -0700
Message-ID: <CABBYNZLfFW=tkcucf+CXpA9wUgnZ-hRgm2-N9SpMdwLGOSrb5g@mail.gmail.com>
Subject: Re: [PATCH 2/4] obex: extract src and dst address and store it
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, May 27, 2013 at 4:07 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> This commit creates src and dst members in obex_session to later use them
> to export via Session D-Bus API.
> ---
>  obexd/src/obex-priv.h | 2 ++
>  obexd/src/obex.c      | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/obexd/src/obex-priv.h b/obexd/src/obex-priv.h
> index 41854bc..90aa225 100644
> --- a/obexd/src/obex-priv.h
> +++ b/obexd/src/obex-priv.h
> @@ -27,6 +27,8 @@ struct obex_session {
>         uint32_t id;
>         uint8_t cmd;
>         uint8_t action_id;
> +       char src[18];
> +       char dst[18];
>         char *name;
>         char *destname;
>         char *type;
> diff --git a/obexd/src/obex.c b/obexd/src/obex.c
> index a3e7b0e..b08a412 100644
> --- a/obexd/src/obex.c
> +++ b/obexd/src/obex.c
> @@ -40,6 +40,7 @@
>  #include <inttypes.h>
>
>  #include <glib.h>
> +#include <bluetooth.h>
>  #include <btio/btio.h>
>  #include <gobex/gobex.h>
>
> @@ -1102,6 +1103,7 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
>         GObex *obex;
>         GObexTransportType type;
>         static uint32_t id = 0;
> +       bdaddr_t src, dst;
>
>         DBG("");
>
> @@ -1134,6 +1136,12 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
>         os->obex = obex;
>         os->io = g_io_channel_ref(io);
>
> +       bt_io_get(io, NULL, BT_IO_OPT_SOURCE_BDADDR, &src,
> +                       BT_IO_OPT_DEST_BDADDR, &dst, BT_IO_OPT_INVALID);
> +
> +       ba2str(&src, os->src);
> +       ba2str(&dst, os->dst);
> +
>         sessions = g_slist_prepend(sessions, os);
>
>         return 0;
> --
> 1.8.1.4

I would prefer having this in the transport driver we just need to
extend with getsockname as getpeername is already supported, btw you
can use BT_IO_OPT_SOURCE and BT_IO_OPT_DEST directly so there is no
need to include bluetooth.h.

--
Luiz Augusto von Dentz
