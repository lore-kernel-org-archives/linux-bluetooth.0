Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415011293-29661-6-git-send-email-gowtham.ab@samsung.com>
References: <1415011293-29661-1-git-send-email-gowtham.ab@samsung.com>
	<1415011293-29661-6-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 3 Nov 2014 16:39:06 +0200
Message-ID: <CABBYNZ++OJPY_rg4FGaTT8=PMjCk94ZxhqGy93uprhd7U4FKwQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] monitor/rfcomm: Add handlers for mcc frame type
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Nov 3, 2014 at 12:41 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> From: Bharat Panda <bharat.panda@samsung.com>
>
> Changes made to decode different mcc frame type in RFCOMM
> for btmon.
> ---
>  monitor/rfcomm.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index a43b2a2..b85e8fd 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -90,6 +90,51 @@ static void print_rfcomm_hdr(const struct l2cap_frame *frame,
>         print_field("FCS : (0x%2.2x)", fcs);
>  }
>
> +static inline void mcc_test(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +}
> +
> +static inline void mcc_fcon(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +}
> +
> +static inline void mcc_fcoff(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +}
> +
> +static inline void mcc_msc(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +       packet_hexdump(frame->data, frame->size);
> +}
> +
> +static inline void mcc_rpn(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +       packet_hexdump(frame->data, frame->size);
> +}
> +
> +static inline void mcc_rls(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +       packet_hexdump(frame->data, frame->size);
> +}
> +
> +static inline void mcc_pn(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +       packet_hexdump(frame->data, frame->size);
> +}
> +
> +static inline void mcc_nsc(const struct l2cap_frame *frame,
> +                               struct rfcomm_lhdr hdr, struct rfcomm_lmcc mcc)
> +{
> +       packet_hexdump(frame->data, frame->size);
> +}

Im fine if you want to add parsing functions upfront but they should
do something useful other than just packet_hexdump otherwise don't
bother, btw please add the output that this changes are producing in
the description so we can more easily visualize the format you are
proposing.

>  static const char *type2str(uint8_t type)
>  {
>         switch (type) {
> @@ -141,8 +186,37 @@ static inline bool mcc_frame(const struct l2cap_frame *frame,
>         print_indent(7, opcode_color, "RFCOMM(s): ", "", COLOR_OFF, "%s %s",
>                                         type2str(type), CR_STR(mcc.type));
>
> -       print_rfcomm_hdr(&rfcomm_frame, hdr);
> -       packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
> +       switch (type) {
> +       case RFCOMM_TEST:
> +               mcc_test(&rfcomm_frame, hdr, mcc);
> +               packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
> +               break;
> +       case RFCOMM_FCON:
> +               mcc_fcon(&rfcomm_frame, hdr, mcc);
> +               break;
> +       case RFCOMM_FCOFF:
> +               mcc_fcoff(&rfcomm_frame, hdr, mcc);
> +               break;
> +       case RFCOMM_MSC:
> +               mcc_msc(&rfcomm_frame, hdr, mcc);
> +               break;
> +       case RFCOMM_RPN:
> +               mcc_rpn(&rfcomm_frame, hdr, mcc);
> +               break;
> +       case RFCOMM_RLS:
> +               mcc_rls(&rfcomm_frame, hdr, mcc);
> +               break;
> +       case RFCOMM_PN:
> +               mcc_pn(&rfcomm_frame, hdr, mcc);
> +               break;
> +       case RFCOMM_NSC:
> +               mcc_nsc(&rfcomm_frame, hdr, mcc);
> +               break;
> +       default:
> +               print_field("MCC message type 0x%02x: ", type);
> +               print_rfcomm_hdr(&rfcomm_frame, hdr);
> +               packet_hexdump(rfcomm_frame.data, rfcomm_frame.size);
> +       }
>
>         return true;
>  }
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
