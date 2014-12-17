Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
References: <1418809961-28354-1-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1418809961-28354-1-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH] monitor/rfcomm: Add support for decoding Test command
Date: Wed, 17 Dec 2014 17:31:32 +0530
Message-id: <000501d019f1$443178d0$cc946a70$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Wednesday, December 17, 2014 3:23 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: d.kasatkin@samsung.com; bharat.panda@samsung.com;
> cpgs@samsung.com; Gowtham Anandha Babu
> Subject: [PATCH] monitor/rfcomm: Add support for decoding Test command
> 
>           RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
>              Address: 0x01 cr 0 dlci 0x00
>              Control: 0xef poll/final 0
>              Length: 6
>              FCS: 0xaa
>              MCC Message type: Test Command RSP(0x08)
>                Length: 4
>                Test Data: 0x 5f 54 65 73
> ---
>  monitor/rfcomm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c index 7d22fa0..be215a1
> 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -146,6 +146,23 @@ static void print_rfcomm_hdr(struct rfcomm_frame
> *rfcomm_frame, uint8_t indent)
>  	print_field("%*cFCS: 0x%2.2x", indent, ' ', hdr.fcs);  }
> 
> +static inline bool mcc_test(struct rfcomm_frame *rfcomm_frame, uint8_t
> +indent) {
> +	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
> +	uint8_t data;
> +
> +	printf("%*cTest Data: 0x ", indent, ' ');
> +
> +	while (frame->size > 1) {
> +		if (!l2cap_frame_get_u8(frame, &data))
> +			return false;
> +		printf("%2.2x ", data);
> +	}
> +
> +	printf("\n");
> +	return true;
> +}
> +
>  static inline bool mcc_msc(struct rfcomm_frame *rfcomm_frame, uint8_t
> indent)  {
>  	struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame; @@ -
> 358,6 +375,8 @@ static inline bool mcc_frame(struct rfcomm_frame
> *rfcomm_frame, uint8_t indent)
>  	rfcomm_frame->mcc = mcc;
> 
>  	switch (type) {
> +	case RFCOMM_TEST:
> +		return mcc_test(rfcomm_frame, indent+10);
>  	case RFCOMM_MSC:
>  		return mcc_msc(rfcomm_frame, indent+2);
>  	case RFCOMM_RPN:
> --
> 1.9.1
> 

Please ignore this one, I have uploaded a new set.

Regards,
Gowtham Anandha Babu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

