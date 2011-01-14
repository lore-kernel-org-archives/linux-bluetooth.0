Return-Path: <cyrus@holtmann.org>
To: =?UTF-8?Q?Elvis_Pf=C3=BCtzenreuter?= <epx@signove.com>
Subject: Re: [PATCH] [RFC] HDP: reject MDL reconnection with different MTU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Fri, 14 Jan 2011 10:22:02 +0100
From: =?UTF-8?Q?Jos=C3=A9_Antonio_Santos_Cadenas?= <jcaden@libresoft.es>
Cc: <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1294960264-7622-1-git-send-email-epx@signove.com>
References: <1294960264-7622-1-git-send-email-epx@signove.com>
Message-ID: <33e10449eddb45a9d7de33c23d05e14f@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

 Hi Elvis,

 On Thu, 13 Jan 2011 21:11:04 -0200, Elvis PfÃ¼tzenreuter wrote:
> From: Elvis Pfutzenreuter <epx@signove.com>
>
> This patch implements refusal of a MDL reconnection if the new L2CAP
> connection presents a different MTU. Accordingly to HDP spec. item 
> 3.5.
>
> It aims to pass the TC_SNK_HCT_BV_07_C PTS test. (It does not pass 
> yet
> because PTS itself seems to have issues. See ticket 7121 for 
> details.)

 Nice catch!

 The patch seems OK for me, but please, let me some time for review this 
 issue more deeply before pushing the patch.

 Regards.

 Jose.

> ---
>  health/hdp.c       |   17 +++++++++++++++--
>  health/hdp_types.h |    1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/health/hdp.c b/health/hdp.c
> index dc1f803..4f89958 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -874,6 +874,7 @@ static gboolean check_channel_conf(struct
> hdp_channel *chan)
>  	GError *err = NULL;
>  	GIOChannel *io;
>  	uint8_t mode;
> +	uint16_t mtu;
>  	int fd;
>
>  	fd = mcap_mdl_get_fd(chan->mdl);
> @@ -883,6 +884,7 @@ static gboolean check_channel_conf(struct
> hdp_channel *chan)
>
>  	if (!bt_io_get(io, BT_IO_L2CAP, &err,
>  			BT_IO_OPT_MODE, &mode,
> +			BT_IO_OPT_OMTU, &mtu,
>  			BT_IO_OPT_INVALID)) {
>  		error("Error: %s", err->message);
>  		g_io_channel_unref(io);
> @@ -894,13 +896,24 @@ static gboolean check_channel_conf(struct
> hdp_channel *chan)
>
>  	switch (chan->config) {
>  	case HDP_RELIABLE_DC:
> -		return mode == L2CAP_MODE_ERTM;
> +		if (mode != L2CAP_MODE_ERTM)
> +			return FALSE;
> +		break;
>  	case HDP_STREAMING_DC:
> -		return mode == L2CAP_MODE_STREAMING;
> +		if (mode != L2CAP_MODE_STREAMING)
> +			return FALSE;
> +		break;
>  	default:
>  		error("Error: Connected with unknown configuration");
>  		return FALSE;
>  	}
> +
> +	DBG("MDL MTU: %d; Channel MTU: %d", mtu, chan->mtu);
> +
> +	if (!chan->mtu)
> +		chan->mtu = mtu;
> +
> +	return chan->mtu == mtu;
>  }
>
>  static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void 
> *data)
> diff --git a/health/hdp_types.h b/health/hdp_types.h
> index fffdb32..714cf9a 100644
> --- a/health/hdp_types.h
> +++ b/health/hdp_types.h
> @@ -120,6 +120,7 @@ struct hdp_channel {
>  	uint8_t			config;		/* Channel configuration */
>  	uint8_t			mdep;		/* Remote MDEP */
>  	uint16_t		mdlid;		/* Data channel Id */
> +	uint16_t		mtu;		/* Channel MTU */
>  	struct hdp_echo_data	*edata;		/* private data used by echo channels 
> */
>  	gint			ref;		/* Reference counter */
>  };

