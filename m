Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417608081-27926-3-git-send-email-gowtham.ab@samsung.com>
References: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
	<1417608081-27926-3-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 4 Dec 2014 16:18:20 +0100
Message-ID: <CAA4A+aDGt89cqFVfdGc4vpRpH1kB9qf+Y5XonTvmXaJ9pBz9vg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] monitor/rfcomm: Add support for RPN frame decoding
From: Szymon Janc <szymon.janc@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Dec 3, 2014 at 1:01 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Changes made to decode RPN frame in RFCOMM for btmon.
>
>       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
>          Address: 0x03 cr 1 dlci 0x00
>          Control: 0xef poll/final 0
>          Length: 10
>          FCS: 0x70
>          MCC Message type: Remote Port Negotiation Command CMD(0x24)
>            Length: 8
>            dlci 32
>            br 3 db 2 sb 0 p 0 pt 0 xi 0 xo 0
>            rtri 0 rtro 0 rtci 0 rtco 0 xon 17 xoff 19
>            pm 0x3f7f
> ---
>  monitor/rfcomm.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index cd50c8c..62b52cc 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -63,6 +63,18 @@ static char *cr_str[] = {
>  #define GET_V24_IC(sigs)       ((sigs & 0x40) >> 6)
>  #define GET_V24_DV(sigs)       ((sigs & 0x80) >> 7)
>
> +/* RPN macros */
> +#define GET_RPN_DB(parity)     (parity & 0x03)
> +#define GET_RPN_SB(parity)     ((parity & 0x04) >> 2)
> +#define GET_RPN_PARITY(parity) ((parity & 0x08) >> 3)
> +#define GET_RPN_PTYPE(parity)  ((parity & 0x03) >> 3)
> +#define GET_RPN_XIN(io)                (io & 0x01)
> +#define GET_RPN_XOUT(io)       ((io & 0x02) >> 1)
> +#define GET_RPN_RTRI(io)       ((io & 0x04) >> 2)
> +#define GET_RPN_RTRO(io)       ((io & 0x08) >> 3)
> +#define GET_RPN_RTCI(io)       ((io & 0x10) >> 4)
> +#define GET_RPN_RTCO(io)       ((io & 0x20) >> 5)
> +
>  struct rfcomm_lhdr {
>         uint8_t address;
>         uint8_t control;
> @@ -77,6 +89,16 @@ struct rfcomm_lmsc {
>         uint8_t break_sig;
>  } __attribute__((packed));
>
> +struct rfcomm_rpn {
> +       uint8_t dlci;
> +       uint8_t bit_rate;
> +       uint8_t parity;
> +       uint8_t io;
> +       uint8_t xon;
> +       uint8_t xoff;
> +       uint16_t pm;
> +} __attribute__ ((packed));
> +
>  struct rfcomm_lmcc {
>         uint8_t type;
>         uint16_t length;
> @@ -138,6 +160,55 @@ done:
>         return true;
>  }
>
> +static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
> +{
> +       struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
> +       struct rfcomm_rpn rpn;
> +
> +       if (!l2cap_frame_get_u8(frame, &rpn.dlci))
> +               return false;
> +
> +       print_field("%*cdlci %d", indent, ' ', RFCOMM_GET_DLCI(rpn.dlci));
> +
> +       if (frame->size < 7)
> +               goto done;
> +
> +       /* port value octets (optional) */
> +
> +       if (!l2cap_frame_get_u8(frame, &rpn.bit_rate))
> +               return false;
> +
> +       if (!l2cap_frame_get_u8(frame, &rpn.parity))
> +               return false;
> +
> +       if (!l2cap_frame_get_u8(frame, &rpn.io))
> +               return false;
> +
> +       print_field("%*cbr %d db %d sb %d p %d pt %d xi %d xo %d", indent, ' ',
> +               rpn.bit_rate, GET_RPN_DB(rpn.parity), GET_RPN_SB(rpn.parity),
> +               GET_RPN_PARITY(rpn.parity), GET_RPN_PTYPE(rpn.parity),
> +               GET_RPN_XIN(rpn.io), GET_RPN_XOUT(rpn.io));
> +
> +       if (!l2cap_frame_get_u8(frame, &rpn.xon))
> +               return false;
> +
> +       if (!l2cap_frame_get_u8(frame, &rpn.xoff))
> +               return false;
> +
> +       print_field("%*crtri %d rtro %d rtci %d rtco %d xon %d xoff %d",
> +               indent, ' ', GET_RPN_RTRI(rpn.io), GET_RPN_RTRO(rpn.io),
> +               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
> +               rpn.xoff);
> +
> +       if (!l2cap_frame_get_be16(frame, &rpn.pm))
> +               return false;
> +
> +       print_field("%*cpm 0x%04x", indent, ' ', __bswap_16(rpn.pm));

This __bswap_16 is invalid since rpn.pm was already converted to host
order by l2cap_frame_get_be16(). (It wouldn't work correctly on BE
arch anyway).

Also this was causing build problems under Android. If you are able to
build-test under Android please do so. If not then at least point this
in cover letter or patch comment that code was tested only under
Linux).

I've fixed this myself but please pay attention to this with any
future submission.

> +
> +done:
> +       return true;
> +}
> +
>  struct mcc_data {
>         uint8_t type;
>         const char *str;
> @@ -201,6 +272,8 @@ static inline bool mcc_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>         switch (type) {
>         case RFCOMM_MSC:
>                 return mcc_msc(rfcomm_frame, indent+2);
> +       case RFCOMM_RPN:
> +               return mcc_rpn(rfcomm_frame, indent+2);
>         default:
>                 packet_hexdump(frame->data, frame->size);
>         }
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
pozdrawiam
Szymon K. Janc
szymon.janc@gmail.com
