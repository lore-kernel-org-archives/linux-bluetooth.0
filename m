Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1481160937-148025-1-git-send-email-mcchou@chromium.org>
References: <1481160937-148025-1-git-send-email-mcchou@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Dec 2016 11:52:16 +0200
Message-ID: <CABBYNZKzAbRHLBMU_WGH_aht_-ycU1OOuqJ_4M1RDovFd8z8tw@mail.gmail.com>
Subject: Re: [PATCH v2] monitor/rfcomm: Fix a potential memory access issue
 for compatibility with LLVM
To: Miao-chen Chou <mcchou@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 8, 2016 at 3:35 AM,  <mcchou@chromium.org> wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This patch replaces the use of struct rfcomm_rpn with local variables in
> mmc_rpn() to prevent the access to an unaligned struct member. Since struct
> rfcomm_rpn is only used in mmc_rpn(), its definition is removed. This patch
> also introduces a temp variable in mcc_pn() to prevent unaligned access.
> ---
>  monitor/rfcomm.c | 48 +++++++++++++++++++++---------------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index b32ad40..6b9d355 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -98,16 +98,6 @@ struct rfcomm_lmsc {
>         uint8_t break_sig;
>  } __attribute__((packed));
>
> -struct rfcomm_rpn {
> -       uint8_t dlci;
> -       uint8_t bit_rate;
> -       uint8_t parity;
> -       uint8_t io;
> -       uint8_t xon;
> -       uint8_t xoff;
> -       uint16_t pm;
> -} __attribute__ ((packed));
> -

I guess it would be cleaner if you just remove the packed from these
structs since we are not using it to store the raw PDU the padding can
be adjusted by the compiler.

>  struct rfcomm_rls {
>         uint8_t dlci;
>         uint8_t error;
> @@ -198,47 +188,48 @@ done:
>  static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>  {
>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
> -       struct rfcomm_rpn rpn;
> +       uint8_t dlci, bit_rate, parity, io, xon, xoff;
> +       uint16_t pm;
>
> -       if (!l2cap_frame_get_u8(frame, &rpn.dlci))
> +       if (!l2cap_frame_get_u8(frame, &dlci))
>                 return false;
>
> -       print_field("%*cdlci %d", indent, ' ', RFCOMM_GET_DLCI(rpn.dlci));
> +       print_field("%*cdlci %d", indent, ' ', RFCOMM_GET_DLCI(dlci));
>
>         if (frame->size < 7)
>                 goto done;
>
>         /* port value octets (optional) */
>
> -       if (!l2cap_frame_get_u8(frame, &rpn.bit_rate))
> +       if (!l2cap_frame_get_u8(frame, &bit_rate))
>                 return false;
>
> -       if (!l2cap_frame_get_u8(frame, &rpn.parity))
> +       if (!l2cap_frame_get_u8(frame, &parity))
>                 return false;
>
> -       if (!l2cap_frame_get_u8(frame, &rpn.io))
> +       if (!l2cap_frame_get_u8(frame, &io))
>                 return false;
>
>         print_field("%*cbr %d db %d sb %d p %d pt %d xi %d xo %d", indent, ' ',
> -               rpn.bit_rate, GET_RPN_DB(rpn.parity), GET_RPN_SB(rpn.parity),
> -               GET_RPN_PARITY(rpn.parity), GET_RPN_PTYPE(rpn.parity),
> -               GET_RPN_XIN(rpn.io), GET_RPN_XOUT(rpn.io));
> +               bit_rate, GET_RPN_DB(parity), GET_RPN_SB(parity),
> +               GET_RPN_PARITY(parity), GET_RPN_PTYPE(parity),
> +               GET_RPN_XIN(io), GET_RPN_XOUT(io));
>
> -       if (!l2cap_frame_get_u8(frame, &rpn.xon))
> +       if (!l2cap_frame_get_u8(frame, &xon))
>                 return false;
>
> -       if (!l2cap_frame_get_u8(frame, &rpn.xoff))
> +       if (!l2cap_frame_get_u8(frame, &xoff))
>                 return false;
>
>         print_field("%*crtri %d rtro %d rtci %d rtco %d xon %d xoff %d",
> -               indent, ' ', GET_RPN_RTRI(rpn.io), GET_RPN_RTRO(rpn.io),
> -               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
> -               rpn.xoff);
> +               indent, ' ', GET_RPN_RTRI(io), GET_RPN_RTRO(io),
> +               GET_RPN_RTCI(io), GET_RPN_RTCO(io), xon, xoff);
>
> -       if (!l2cap_frame_get_le16(frame, &rpn.pm))
> +       /* prevent unaligned memory access */
> +       if (!l2cap_frame_get_le16(frame, &pm))
>                 return false;
>
> -       print_field("%*cpm 0x%04x", indent, ' ', rpn.pm);
> +       print_field("%*cpm 0x%04x", indent, ' ', pm);
>
>  done:
>         return true;
> @@ -265,6 +256,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>  {
>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>         struct rfcomm_pn pn;
> +       uint16_t mtu;
>
>         /* rfcomm_pn struct is defined in rfcomm.h */
>
> @@ -284,8 +276,10 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>         if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
>                 return false;
>
> -       if (!l2cap_frame_get_le16(frame, &pn.mtu))
> +       /* prevent unaligned memory access */
> +       if (!l2cap_frame_get_le16(frame, &mtu))
>                 return false;
> +       pn.mtu = mtu;
>
>         if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
>                 return false;
> --
> 2.8.0.rc3.226.g39d4020
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
