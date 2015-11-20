Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 03/22] monitor/avdtp: Decode AVDTP_DISCOVER
Date: Fri, 20 Nov 2015 17:50:14 +0100
Message-ID: <3348927.TWrBTZh3Fe@ix>
In-Reply-To: <1448028820-25330-4-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1448028820-25330-1-git-send-email-andrzej.kaczmarek@codecoup.pl> <1448028820-25330-4-git-send-email-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Friday 20 November 2015 15:13:21 Andrzej Kaczmarek wrote:
> < ACL Data TX: Handle 256 flags 0x00 dlen 6
>       Channel: 258 len 2 [PSM 25 mode 0] {chan 2}
>       AVDTP: Discover (0x01) Command (0x00) type 0x00 label 0 nosp 0
> 
> > ACL Data RX: Handle 256 flags 0x02 dlen 14
> 
>       Channel: 66 len 10 [PSM 25 mode 0] {chan 2}
>       AVDTP: Discover (0x01) Response Accept (0x02) type 0x00 label 0 nosp 0
> ACP SEID: 1
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x01)
>           In use: No
>         ACP SEID: 5
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x01)
>           In use: No
>         ACP SEID: 3
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x01)
>           In use: No
>         ACP SEID: 2
>           Media Type: Audio (0x00)
>           SEP Type: SRC (0x01)
>           In use: No
> ---
>  monitor/avdtp.c | 134
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> 132 insertions(+), 2 deletions(-)
> 
> diff --git a/monitor/avdtp.c b/monitor/avdtp.c
> index de4edbb..78e3c3b 100644
> --- a/monitor/avdtp.c
> +++ b/monitor/avdtp.c
> @@ -109,6 +109,115 @@ static const char *sigid2str(uint8_t sigid)
>  	}
>  }
> 
> +static const char *error2str(uint8_t error)
> +{
> +	switch (error) {
> +	case 0x01:
> +		return "BAD_HEADER_FORMAT";
> +	case 0x11:
> +		return "BAD_LENGTH";
> +	case 0x12:
> +		return "BAD_ACP_SEID";
> +	case 0x13:
> +		return "SEP_IN_USE";
> +	case 0x14:
> +		return "SEP_NOT_IN_USER";
> +	case 0x17:
> +		return "BAD_SERV_CATEGORY";
> +	case 0x18:
> +		return "BAD_PAYLOAD_FORMAT";
> +	case 0x19:
> +		return "NOT_SUPPORTED_COMMAND";
> +	case 0x1a:
> +		return "INVALID_CAPABILITIES";
> +	case 0x22:
> +		return "BAD_RECOVERY_TYPE";
> +	case 0x23:
> +		return "BAD_MEDIA_TRANSPORT_FORMAT";
> +	case 0x25:
> +		return "BAD_RECOVERY_FORMAT";
> +	case 0x26:
> +		return "BAD_ROHC_FORMAT";
> +	case 0x27:
> +		return "BAD_CP_FORMAT";
> +	case 0x28:
> +		return "BAD_MULTIPLEXING_FORMAT";
> +	case 0x29:
> +		return "UNSUPPORTED_CONFIGURATION";
> +	case 0x31:
> +		return "BAD_STATE";
> +	default:
> +		return "Unknown";
> +	}
> +}
> +
> +static const char *mediatype2str(uint8_t media_type)
> +{
> +	switch (media_type) {
> +	case 0x00:
> +		return "Audio";
> +	case 0x01:
> +		return "Video";
> +	case 0x02:
> +		return "Multimedia";
> +	default:
> +		return "Reserved";
> +	}
> +}
> +
> +static bool avdtp_reject_common(struct avdtp_frame *avdtp_frame)
> +{
> +	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
> +	uint8_t error;
> +
> +	if (!l2cap_frame_get_u8(frame, &error))
> +		return false;
> +
> +	print_field("Error code: %s (0x%02x)", error2str(error), error);
> +
> +	return true;
> +}
> +
> +static bool avdtp_discover(struct avdtp_frame *avdtp_frame)
> +{
> +	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
> +
> +	if (avdtp_frame->hdr & 0x01)
> +		goto reject;
> +
> +	if (avdtp_frame->hdr & 0x02)
> +		goto response;
> +
> +	/* no extra parameters */
> +	return true;
> +
> +reject:
> +	return avdtp_reject_common(avdtp_frame);
> +
> +response:
> +	for (;;) {
> +		uint8_t seid;
> +		uint8_t info;
> +
> +		if (!l2cap_frame_get_u8(frame, &seid))
> +			break;
> +
> +		if (!l2cap_frame_get_u8(frame, &info))
> +			return false;
> +
> +		print_field("ACP SEID: %d", seid >> 2);
> +		print_field("%*cMedia Type: %s (0x%02x)", 2, ' ',
> +					mediatype2str(info >> 4), info >> 4);
> +		print_field("%*cSEP Type: %s (0x%02x)", 2, ' ',
> +						info & 0x04 ? "SNK" : "SRC",
> +						(info >> 3) & 0x01);
> +		print_field("%*cIn use: %s", 2, ' ',
> +						seid & 0x02 ? "Yes" : "No");
> +	}


Maybe it is a matter of taste, but I'd not abuse goto in such simple 
functions.
ie

/* reject */
if (avdtp_frame->hdr & 0x01)
	return avdtp_reject_common(avdtp_frame);

/* response */
if (avdtp_frame->hdr & 0x02) {
	....
	return true;
}

....
return true;


> +
> +	return true;
> +}
> +
>  static bool avdtp_signalling_packet(struct avdtp_frame *avdtp_frame)
>  {
>  	struct l2cap_frame *frame = &avdtp_frame->l2cap_frame;
> @@ -116,6 +225,7 @@ static bool avdtp_signalling_packet(struct avdtp_frame
> *avdtp_frame) uint8_t hdr;
>  	uint8_t sig_id;
>  	uint8_t nosp = 0;
> +	bool ret;
> 
>  	if (frame->in)
>  		pdu_color = COLOR_MAGENTA;
> @@ -152,8 +262,28 @@ static bool avdtp_signalling_packet(struct avdtp_frame
> *avdtp_frame) sig_id, msgtype2str(hdr & 0x03), hdr & 0x03,
>  			hdr & 0x0c, hdr >> 4, nosp);
> 
> -	packet_hexdump(frame->data, frame->size);
> -	return true;
> +	/* Start Packet */
> +	if ((hdr & 0x0c) == 0x04) {
> +		/* TODO: handle fragmentation */
> +		packet_hexdump(frame->data, frame->size);
> +		return true;
> +	}
> +
> +	/* General Reject */
> +	if ((hdr & 0x03) == 0x03)
> +		return true;
> +
> +	switch (sig_id) {
> +	case AVDTP_DISCOVER:
> +		ret = avdtp_discover(avdtp_frame);
> +		break;
> +	default:
> +		packet_hexdump(frame->data, frame->size);
> +		ret = true;
> +		break;
> +	}
> +
> +	return ret;
>  }
> 
>  void avdtp_packet(const struct l2cap_frame *frame)

-- 
pozdrawiam
Szymon Janc
