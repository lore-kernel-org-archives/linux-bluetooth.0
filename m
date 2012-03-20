Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 10:15:02 +0100
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH hcidump 1/2] AVRCP: Add parsing for SetAbsoluteVolume
 PDU
Message-ID: <20120320091502.GA6356@uw000554.eu.tieto.com>
References: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1332178892-8987-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 19, 2012 at 07:41:31PM +0200, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
>  parser/avrcp.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index 643e494..d746937 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -1201,6 +1201,23 @@ response:
>  	}
>  }
>  
> +static void avrcp_set_absolut_volume_dump(int level, struct frame *frm,
> +						uint8_t ctype, uint16_t len)

Typo? "absolut" --> "absolute"

> +{
> +	uint8_t value;
> +
> +	p_indent(level, frm);
> +
> +	if (len < 1) {
> +		printf("PDU Malformed\n");
> +		raw_dump(level, frm);
> +		return;
> +	}
> +
> +	value = get_u8(frm);

"value" is only lower seven bits. You should use mask 0x80. 
The same for Patch 2/2.

> +	printf("Value: 0x%02x\n", value);

"Value"? "Volume" seems to be better, and why hex value? I propose 
decimal and percent value, for example: "Volume: 38% (48/127)"


> +}
> +
>  static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>  {
>  	uint8_t pduid, pt;
> @@ -1267,6 +1284,9 @@ static void avrcp_pdu_dump(int level, struct frame *frm, uint8_t ctype)
>  	case AVRCP_REGISTER_NOTIFICATION:
>  		avrcp_register_notification_dump(level + 1, frm, ctype, len);
>  		break;
> +	case AVRCP_SET_ABSOLUTE_VOLUME:
> +		avrcp_set_absolut_volume_dump(level + 1, frm, ctype, len);
> +		break;
>  	default:
>  		raw_dump(level, frm);
>  	}
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Regards
Michal Labedzki
