Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth:  FTP and OPP over L2CAP
From: Marcel Holtmann <marcel@holtmann.org>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Jun 2011 04:17:10 -0700
In-Reply-To: <1308110046-5704-1-git-send-email-nami.li@atheros.com>
References: <1308110046-5704-1-git-send-email-nami.li@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308136632.2518.11.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

> From: nami <nami.li@atheros.com>
> 
> 
> Signed-off-by: Nami <nami.li@atheros.com>

same as with the other one.

> ---
>  glib/obex-lowlevel.c          |    2 +-
>  include/openobex/obex.h       |    2 +-
>  include/openobex/obex_const.h |    5 +++++
>  lib/obex.c                    |    3 ++-
>  lib/obex_main.c               |    5 ++++-
>  lib/obex_transport.h          |    1 +
>  6 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/glib/obex-lowlevel.c b/glib/obex-lowlevel.c
> index 65172fc..660fc37 100644
> --- a/glib/obex-lowlevel.c
> +++ b/glib/obex-lowlevel.c
> @@ -496,7 +496,7 @@ obex_t *obex_open(int fd, obex_callback_t *callback, void *data)
> 
>  	OBEX_SetTransportMTU(handle, sizeof(context->buf), sizeof(context->buf));
> 
> -	if (FdOBEX_TransportSetup(handle, fd, fd, 0) < 0) {
> +	if (FdOBEX_TransportSetup(handle, fd, fd, 0, OBEX_MT_STREAM) < 0) {
>  		OBEX_Cleanup(handle);
>  		return NULL;
>  	}
> diff --git a/include/openobex/obex.h b/include/openobex/obex.h
> index f948113..0d7afec 100644
> --- a/include/openobex/obex.h
> +++ b/include/openobex/obex.h
> @@ -147,7 +147,7 @@ OPENOBEX_SYMBOL(int) BtOBEX_TransportConnect(obex_t *self, bt_addr_t *src, bt_ad
>  /*
>   * OBEX File API
>   */
> -OPENOBEX_SYMBOL(int) FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu);
> +OPENOBEX_SYMBOL(int) FdOBEX_TransportSetup(obex_t *self, int rfd, int wfd, int mtu, int fmt);

this is breaking public API.

>  /*
>   * OBEX interface discovery API
> diff --git a/include/openobex/obex_const.h b/include/openobex/obex_const.h
> index cb7afeb..4a0a7e9 100644
> --- a/include/openobex/obex_const.h
> +++ b/include/openobex/obex_const.h
> @@ -302,6 +302,11 @@ enum obex_rsp_mode {
>    OBEX_RSP_MODE_SINGLE = 1, /**< single response mode (SRM) */
>  };
> 
> +enum obex_transport_format{
> +	 OBEX_MT_STREAM ,
> +	 OBEX_MT_SEQPACKET
> +};
> +

And more important, I have no idea why are you doing this anyway. Even
with L2CAP this should run over SOCK_STREAM.

I assumed that OPP and FTP over L2CAP are requiring eL2CAP actually
which is re-presented as a stream.

Regards

Marcel


