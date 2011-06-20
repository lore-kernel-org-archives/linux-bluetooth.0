Return-Path: <cyrus@holtmann.org>
Message-ID: <20110620110046.36582j7fh6rjxcg0@mail.hendrik-sattler.de>
Date: Mon, 20 Jun 2011 11:00:46 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: openobex-users@lists.sourceforge.net, Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org,
	openobex-users@lists.sourceforge.net, haijun@qca.qualcomm.com
Subject: Re: [openobex-users] [PATCH openobex 1/3] Add transport format
 member in fdobex_data struct. Support STREAM and SEQPACKET transport
 format.
References: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
In-Reply-To: <1308548849-11615-1-git-send-email-nami.li@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Nami <nami.li@atheros.com>:

> ---
>  include/openobex/obex_const.h |    4 ++++
>  lib/fdobex.h                  |    1 +
>  2 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/include/openobex/obex_const.h b/include/openobex/obex_const.h
> index cb7afeb..8acee91 100644
> --- a/include/openobex/obex_const.h
> +++ b/include/openobex/obex_const.h
> @@ -302,6 +302,10 @@ enum obex_rsp_mode {
>    OBEX_RSP_MODE_SINGLE = 1, /**< single response mode (SRM) */
>  };
>
> +enum fdobex_transport_format{
> +	 FDOBEX_MT_STREAM ,
> +	 FDOBEX_MT_SEQPACKET
> +};
>  /* Min, Max and default transport MTU */
>  #define OBEX_DEFAULT_MTU	1024
>  #define OBEX_MINIMUM_MTU	255

Insert an empty line after the enum, please.
Also document the enum and its members, see the enum above. This is  
needed for the doxygen output.

> diff --git a/lib/fdobex.h b/lib/fdobex.h
> index 07e33ab..6839e77 100644
> --- a/lib/fdobex.h
> +++ b/lib/fdobex.h
> @@ -6,5 +6,6 @@ void fdobex_get_ops(struct obex_transport_ops* ops);
>
>  struct fdobex_data {
>  	socket_t writefd; /* write descriptor */
> +	enum fdobex_transport_format fmt;
>  };
>  #endif
> --
> 1.7.1
>
>
> ------------------------------------------------------------------------------
> EditLive Enterprise is the world's most technically advanced content
> authoring tool. Experience the power of Track Changes, Inline Image
> Editing and ensure content is compliant with Accessibility Checking.
> http://p.sf.net/sfu/ephox-dev2dev
> _______________________________________________
> Openobex-users mailing list
> Openobex-users@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/openobex-users
>



