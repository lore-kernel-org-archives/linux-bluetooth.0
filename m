Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1482263413-85198-1-git-send-email-mcchou@chromium.org>
References: <1482263413-85198-1-git-send-email-mcchou@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Dec 2016 16:03:37 +0200
Message-ID: <CABBYNZKZzvum3s8YcVzUYQME77UOAD_4FdnQSYHiRGSJ20noVA@mail.gmail.com>
Subject: Re: [PATCH v4] monitor/rfcomm: Fix a potential memory access issue
 for compatibility with LLVM
To: Miao-chen Chou <mcchou@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Dec 20, 2016 at 9:50 PM,  <mcchou@chromium.org> wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This patch removes "packed" attribute from the definition of struct rfcomm_rpn
> to prevent the access to an unaligned struct member in mmc_rpn(). This patch
> also introduces a temp variable in mcc_pn() to prevent unaligned access without
> touching the definition of struct rfcomm_pn, since struct rfcomm_pn is used as
> a PDU.
> ---
> v4 removes the unrelated change on the code format.
>
>  monitor/rfcomm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index b32ad40..4bd549c 100644
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
> @@ -265,6 +265,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>  {
>         struct l2cap_frame *frame = &rfcomm_frame->l2cap_frame;
>         struct rfcomm_pn pn;
> +       uint16_t mtu;
>
>         /* rfcomm_pn struct is defined in rfcomm.h */
>
> @@ -284,8 +285,10 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>         if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
>                 return false;
>
> -       if (!l2cap_frame_get_le16(frame, &pn.mtu))
> +       /* prevent unaligned memory access */
> +       if (!l2cap_frame_get_le16(frame, &mtu))
>                 return false;
> +       pn.mtu = mtu;

Interesting, isn't this causing unaligned access anyway since it is
assigning to pn.mtu which is packed? Or this is fine as far as it is
not accessed via void *? Btw, please add the compiler output and flags
it is being used, it is quite possible we can replicate the same
errors on gcc or perhaps it is missing some flags used in gcc to make
this aligned?

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
