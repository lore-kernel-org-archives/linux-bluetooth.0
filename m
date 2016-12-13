Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1481317184-173403-1-git-send-email-mcchou@chromium.org>
References: <CABBYNZKzAbRHLBMU_WGH_aht_-ycU1OOuqJ_4M1RDovFd8z8tw@mail.gmail.com>
 <1481317184-173403-1-git-send-email-mcchou@chromium.org>
From: Miao-chen Chou <mcchou@chromium.org>
Date: Tue, 13 Dec 2016 13:34:54 -0800
Message-ID: <CAHgsZ+iWHFDNOqA4JBRpboKoOaCg5qxxJURa7apPyvuGqVJ38w@mail.gmail.com>
Subject: Re: [PATCH v3] monitor/rfcomm: Fix a potential memory access issue
 for compatibility with LLVM
To: linux-bluetooth@vger.kernel.org
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        josephsih@chromium.org, Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Is there any comment on this patch?

Thanks,
Miao

On Sat, Dec 10, 2016 at 4:59 AM,  <mcchou@chromium.org> wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This patch removes "packed" attribute from the definition of struct rfcomm_rpn
> to prevent the access to an unaligned struct member in mmc_rpn(). This patch
> also introduces a temp variable in mcc_pn() to prevent unaligned access without
> touching the definition of struct rfcomm_pn, since struct rfcomm_pn is used as
> a PDU.
> ---
>  monitor/rfcomm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index b32ad40..08f3e36 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -106,7 +106,7 @@ struct rfcomm_rpn {
>         uint8_t xon;
>         uint8_t xoff;
>         uint16_t pm;
> -} __attribute__ ((packed));
> +};
>
>  struct rfcomm_rls {
>         uint8_t dlci;
> @@ -232,8 +232,7 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>
>         print_field("%*crtri %d rtro %d rtci %d rtco %d xon %d xoff %d",
>                 indent, ' ', GET_RPN_RTRI(rpn.io), GET_RPN_RTRO(rpn.io),
> -               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
> -               rpn.xoff);
> +               GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon, rpn.xoff);
>
>         if (!l2cap_frame_get_le16(frame, &rpn.pm))
>                 return false;
> @@ -265,6 +264,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>  {
>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>         struct rfcomm_pn pn;
> +       uint16_t mtu;
>
>         /* rfcomm_pn struct is defined in rfcomm.h */
>
> @@ -284,8 +284,10 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
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
