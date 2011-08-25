Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Aug 2011 09:30:41 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] hcidump: parse extended control field in l2cap
Message-ID: <20110825123041.GA25269@joana>
References: <1314268449-3528-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1314268449-3528-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1314268449-3528-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-08-25 13:34:09 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds support for parsing extended control field. Extended control
> field may be used for ERTM and streaming mode (if EWS specified).
> Remove magic numbers concerning the subject. Patch to bluez with
> definitinos shall be applied.
> ---
>  parser/l2cap.c |  129 ++++++++++++++++++++++++++++++++++++++++----------------
>  1 files changed, 93 insertions(+), 36 deletions(-)
> 
> diff --git a/parser/l2cap.c b/parser/l2cap.c
> index 217008d..42d3974 100644
> --- a/parser/l2cap.c
> +++ b/parser/l2cap.c
> @@ -60,6 +60,9 @@ typedef struct {
>  } cid_info;
>  #define CID_TABLE_SIZE 20
>  
> +/* FIXME */
> +static int ext_ctrl;
> +
>  static cid_info cid_table[2][CID_TABLE_SIZE];
>  
>  #define SCID cid_table[0]
> @@ -352,13 +355,13 @@ static char *fcs2str(uint8_t fcs)
>  static char *sar2str(uint8_t sar)
>  {
>  	switch (sar) {
> -	case 0x00:
> +	case L2CAP_SAR_UNSEGMENTED:
>  		return "Unsegmented";
> -	case 0x01:
> +	case L2CAP_SAR_START:
>  		return "Start";
> -	case 0x02:
> +	case L2CAP_SAR_END:
>  		return "End";
> -	case 0x03:
> +	case L2CAP_SAR_CONTINUE:
>  		return "Continuation";
>  	default:
>  		return "Bad SAR";
> @@ -369,13 +372,13 @@ static char *sar2str(uint8_t sar)
>  static char *supervisory2str(uint8_t supervisory)
>  {
>  	switch (supervisory) {
> -	case 0x00:
> +	case L2CAP_SUPER_RR:
>  		return "Receiver Ready (RR)";
> -	case 0x01:
> +	case L2CAP_SUPER_REJ:
>  		return "Reject (REJ)";
> -	case 0x02:
> +	case L2CAP_SUPER_RNR:
>  		return "Receiver Not Ready (RNR)";
> -	case 0x03:
> +	case L2CAP_SUPER_SREJ:
>  		return "Select Reject (SREJ)";
>  	default:
>  		return "Bad Supervisory";
> @@ -564,6 +567,7 @@ static void conf_opt(int level, void *ptr, int len, int in, uint16_t cid)
>  			printf("EWS");
>  			if (h->len > 0)
>  				printf(" %d", get_val(h->val, h->len));
> +			ext_ctrl = 1;
>  			break;
>  
>  		default:
> @@ -763,6 +767,63 @@ static inline void info_rsp(int level, l2cap_cmd_hdr *cmd, struct frame *frm)
>  	}
>  }
>  
> +static void l2cap_ctrl_ext_parse(int level, struct frame *frm, uint32_t ctrl)
> +{
> +	p_indent(level, frm);
> +
> +	printf("%s:", ctrl & L2CAP_EXT_CTRL_FRAME_TYPE ? "S-frame" : "I-frame");

Blank line here.

> +	if (ctrl & L2CAP_EXT_CTRL_FRAME_TYPE) {
> +		printf(" %s", supervisory2str((ctrl & L2CAP_EXT_CTRL_SUPERVISE_MASK) >>
> +					L2CAP_EXT_CTRL_SUPER_SHIFT));
> +	} else {
> +		uint8_t sar = (ctrl & L2CAP_EXT_CTRL_SAR_MASK) >>
> +			L2CAP_EXT_CTRL_SAR_SHIFT;
> +		printf(" %s", sar2str(sar));
> +		if (sar == L2CAP_SAR_START) {
> +			uint16_t len;
> +			len = btohs(bt_get_unaligned((uint16_t *) frm->ptr));
> +			frm->ptr += L2CAP_SDULEN_SIZE;
> +			frm->len -= L2CAP_SDULEN_SIZE;
> +			printf(" (len %d)", len);
> +		}
> +		printf(" TxSeq %d", (ctrl & L2CAP_EXT_CTRL_TXSEQ_MASK) >>
> +				L2CAP_EXT_CTRL_TXSEQ_SHIFT);
> +	}

and here.

> +	printf(" ReqSeq %d", (ctrl & L2CAP_EXT_CTRL_REQSEQ_MASK) >>
> +			L2CAP_EXT_CTRL_REQSEQ_SHIFT);

and here.

> +	if (ctrl & L2CAP_EXT_CTRL_FINAL)
> +		printf(" F-bit");

and here.

The same for the other function, these blank lines makes the code more
readable.

	Gustavo
