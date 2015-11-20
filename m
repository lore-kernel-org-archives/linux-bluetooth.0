Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 22/22] monitor/a2dp: Decode LDAC capabilities
Date: Fri, 20 Nov 2015 17:40:09 +0100
Message-ID: <1486854.e8g2EASchL@ix>
In-Reply-To: <1448028820-25330-23-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl> <1448028820-25330-23-git-send-email-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Friday 20 November 2015 15:13:40 Andrzej Kaczmarek wrote:
> > ACL Data RX: Handle 12 flags 0x02 dlen 24
> 
>       Channel: 67 len 20 [PSM 25 mode 0] {chan 1}
>       AVDTP: Get Capabilities (0x02) Response Accept (0x02) type 0x00 label
> 2 nosp 0 Service Category: Media Transport (0x01)
>         Service Category: Media Codec (0x07)
>           Media Type: Audio (0x00)
>           Media Codec: Non-A2DP (0xff)
>             Vendor ID: Sony Corporation (0x0000012d)
>             Vendor Specific Codec ID: LDAC (0x00aa)
>               Unknown: 0x073c
>         Service Category: Content Protection (0x04)
>           Content Protection Type: SCMS-T (0x0002)
> 
> < ACL Data TX: Handle 12 flags 0x02 dlen 26
>       Channel: 2753 len 22 [PSM 25 mode 0] {chan 1}
>       AVDTP: Set Configuration (0x03) Command (0x00) type 0x00 label 5 nosp
> 0 ACP SEID: 5
>         INT SEID: 3
>         Service Category: Media Transport (0x01)
>         Service Category: Media Codec (0x07)
>           Media Type: Audio (0x00)
>           Media Codec: Non-A2DP (0xff)
>             Vendor ID: Sony Corporation (0x0000012d)
>             Vendor Specific Codec ID: LDAC (0x00aa0
>               Unknown: 0x0104
>         Service Category: Content Protection (0x04)
>           Content Protection Type: SCMS-T (0x0002)
> ---
>  monitor/a2dp.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> index d438db0..2077d70 100644
> --- a/monitor/a2dp.c
> +++ b/monitor/a2dp.c
> @@ -50,6 +50,8 @@
>  /* Vendor Specific A2DP Codecs */
>  #define APTX_VENDOR_ID		0x0000004f
>  #define APTX_CODEC_ID		0x0001
> +#define LDAC_VENDOR_ID		0x0000012d
> +#define LDAC_CODEC_ID		0x00aa
> 
>  struct bit_desc {
>  	uint8_t bit;
> @@ -212,6 +214,8 @@ static const char *vndcodec2str(uint32_t vendor_id,
> uint16_t codec_id) {
>  	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID)
>  		return "aptX";
> +	else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID)
> +		return "LDAC";
> 
>  	return "Unknown";
>  }
> @@ -503,6 +507,20 @@ static bool codec_vendor_aptx_cap(uint8_t losc, struct
> l2cap_frame *frame) return true;
>  }
> 
> +static bool codec_vendor_ldac(uint8_t losc, struct l2cap_frame *frame)
> +{
> +	uint16_t cap = 0;
> +
> +	if (losc != 2)
> +		return false;
> +
> +	l2cap_frame_get_le16(frame, &cap);
> +
> +	print_field("%*cUnknown: 0x%04x", BASE_INDENT + 2, ' ', cap);
> +
> +	return true;
> +}
> +
>  static bool codec_vendor_cap(uint8_t losc, struct l2cap_frame *frame)
>  {
>  	uint32_t vendor_id = 0;
> @@ -524,6 +542,8 @@ static bool codec_vendor_cap(uint8_t losc, struct
> l2cap_frame *frame)
> 
>  	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID) {
>  		codec_vendor_aptx_cap(losc, frame);
> +	} else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID) {
> +		codec_vendor_ldac(losc, frame);

Should this return value  from function? Otherwise you may silently ignore 
data if length doesn't match.

>  	} else {
>  		packet_hexdump(frame->data, losc);
>  		l2cap_frame_pull(frame, frame, losc);
> @@ -573,6 +593,8 @@ static bool codec_vendor_cfg(uint8_t losc, struct
> l2cap_frame *frame)
> 
>  	if (vendor_id == APTX_VENDOR_ID && codec_id == APTX_CODEC_ID) {
>  		codec_vendor_aptx_cfg(losc, frame);
> +	} else if (vendor_id == LDAC_VENDOR_ID && codec_id == LDAC_CODEC_ID) {
> +		codec_vendor_ldac(losc, frame);
>  	} else {
>  		packet_hexdump(frame->data, losc);
>  		l2cap_frame_pull(frame, frame, losc);

-- 
pozdrawiam
Szymon Janc
