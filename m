Return-Path: <cyrus@holtmann.org>
Date: Sun, 16 Aug 2009 17:39:57 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Add support for the source interface to audio IPC.
Message-ID: <20090816143858.GA4896@jh-x301>
References: <1250390653-476-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1250390653-476-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

There are a few issues with this patch:

On Sat, Aug 15, 2009, João Paulo Rechi Vita wrote:
>  	if (!interface) {
> -		if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
> +		if (dev->source && avdtp_is_connected(&dev->src, &dev->dst))
> +			return TYPE_SOURCE;
> +		else if (dev->sink && avdtp_is_connected(&dev->src, &dev->dst))
>  			return TYPE_SINK;

I think the dev->source check should be in an "else if" clause while the
dev->sink check should be first. I.e. if a device happens to support both
roles of A2DP we default to dev->sink.

> +		else if (dev->source)
> +			return TYPE_SOURCE;
>  		else if (dev->sink)
>  			return TYPE_SINK;

Same here. dev->sink check before dev->source.

> -		codec->type = BT_A2DP_SBC_SINK;
> +		if (type == AVDTP_SEP_TYPE_SINK)
> +			codec->type = BT_A2DP_SBC_SINK;
> +		else if (type == AVDTP_SEP_TYPE_SOURCE)
> +			codec->type = BT_A2DP_SBC_SOURCE;

What about the "else" part? If type is neither you should probably bail
out of the function with -EINVAL.

>  		print_mpeg12(mpeg_cap);
> -		codec->type = BT_A2DP_MPEG12_SINK;
> +		if (type == AVDTP_SEP_TYPE_SINK)
> +			codec->type = BT_A2DP_MPEG12_SINK;
> +		else if (type == AVDTP_SEP_TYPE_SOURCE)
> +			codec->type = BT_A2DP_MPEG12_SOURCE;

Same here.

> +		if (type == AVDTP_SEP_TYPE_SINK)
> +			codec->type = BT_A2DP_UNKNOWN_SINK;
> +		else if (type == AVDTP_SEP_TYPE_SOURCE)
> +			codec->type = BT_A2DP_UNKNOWN_SOURCE;

And again..

>  	}
>  
>  	codec->seid = seid;
> @@ -606,7 +623,8 @@ static void a2dp_discovery_complete(struct avdtp *session, GSList *seps,
>  
>  		type = avdtp_get_type(rsep);
>  
> -		if (type != AVDTP_SEP_TYPE_SINK)
> +		if (type != AVDTP_SEP_TYPE_SINK &&
> +			type != AVDTP_SEP_TYPE_SOURCE)
>  			continue;

Incorrect indentation for the continuation line of the if clause. It
should at least two tabs from the original to clearly separate it from the
"continue;" line.

> +	if (!dev) {
>  		g_free(client->interface);
> -		client->interface = g_strdup(AUDIO_GATEWAY_INTERFACE);
> -
> +		if (req->transport == BT_CAPABILITIES_TRANSPORT_SCO)
> +			client->interface = g_strdup(AUDIO_GATEWAY_INTERFACE);
> +		else if (req->transport == BT_CAPABILITIES_TRANSPORT_A2DP)
> +			client->interface = g_strdup(AUDIO_SOURCE_INTERFACE);

Again a missing "else" clause but this time the consequences are even more
serious. If req->transport doesn't match either of those values you'll
leave client->interface pointing to free'd memory which will probably
cause access to free'd memory or a double-free later. So at the very least
you should set client->interface to NULL here and maybe also return an
error from the function.

Johan
