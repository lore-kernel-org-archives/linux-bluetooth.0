Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Implement ATT handle indications
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <1298637457-19588-1-git-send-email-epx@signove.com>
Date: Fri, 25 Feb 2011 10:34:16 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C00D88F8-CE33-48DB-B67C-19C464F2C02A@signove.com>
References: <1298637457-19588-1-git-send-email-epx@signove.com>
To: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 25 Feb 2011, at 09:37 , Elvis Pfützenreuter wrote:

> Treatment of near-concomitant indications, the first possibly blocking
> the second, will be implemented in another patch.
> ---
> src/attrib-server.c |   24 ++++++++++++++++++++++++
> 1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/src/attrib-server.c b/src/attrib-server.c
> index 5f645bb..2114700 100644
> --- a/src/attrib-server.c
> +++ b/src/attrib-server.c
> @@ -58,6 +58,7 @@ struct gatt_channel {
> 	guint mtu;
> 	guint id;
> 	gboolean encrypted;
> +	guint outstanding_indications;
> };
> 
> struct group_elem {
> @@ -872,6 +873,10 @@ static void channel_handler(const uint8_t *ipdu, uint16_t len,
> 		length = find_by_type(start, end, &uuid, value, vlen,
> 							opdu, channel->mtu);
> 		break;
> +	case ATT_OP_HANDLE_CNF:
> +		if (channel->outstanding_indications)
> +			channel->outstanding_indications -= 1;
> +		return;
> 	case ATT_OP_READ_MULTI_REQ:
> 	case ATT_OP_PREP_WRITE_REQ:
> 	case ATT_OP_EXEC_WRITE_REQ:
> @@ -969,6 +974,25 @@ static void attrib_notify_clients(struct attribute *attr)
> 			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
> 							NULL, NULL, NULL);
> 		}
> +
> +		if (channel->outstanding_indications)
> +			continue;
> +
> +		/* Indication */
> +		if (g_slist_find_custom(channel->indicate,
> +				GUINT_TO_POINTER(handle), handle_cmp) != NULL) {
> +			uint8_t pdu[ATT_MAX_MTU];
> +			uint16_t len;
> +
> +			len = enc_indication(attr, pdu, channel->mtu);
> +			if (len == 0)
> +				return;
> +
> +			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
> +							NULL, NULL, NULL);
> +
> +			channel->outstanding_indications += 1;
> +		}
> 	}
> }
> 
> -- 
> 1.7.1

I was thinking better and using a boolean for outstanding_indications is better,
since the current logic never lets it go above 1. So, ignore this patch, I
will send another one.

