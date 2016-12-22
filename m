Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1482365553-71040-1-git-send-email-mcchou@chromium.org>
References: <1482365553-71040-1-git-send-email-mcchou@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Dec 2016 12:45:44 +0200
Message-ID: <CABBYNZL6UPyaAz+mabh27vVWRbtSAsN0jRkwd_ANFQdy_4wMdw@mail.gmail.com>
Subject: Re: [PATCH v5] monitor/rfcomm: Fix a potential memory access issue
 for compatibility with LLVM
To: Miao-chen Chou <mcchou@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        josephsih@chromium.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 22, 2016 at 2:12 AM,  <mcchou@chromium.org> wrote:
> From: Miao-chen Chou <mcchou@chromium.org>
>
> This patch removes "packed" attribute from the definition of struct rfcomm_rpn
> to prevent the access to an unaligned struct member in mmc_rpn(). This patch
> also introduces a temp variable in mcc_pn() to prevent unaligned access without
> touching the definition of struct rfcomm_pn, since struct rfcomm_pn is used as
> a PDU.
>
> error messages from LLVM build:
>
> monitor/rfcomm.c:238:36: error: taking address of packed member 'pm' of class
> or structure 'rfcomm_rpn' may result in an unaligned pointer value
> [-Werror,-Waddress-of-packed-member]
>         if (!l2cap_frame_get_le16(frame, &rpn.pm))
> monitor/rfcomm.c:287:36: error: taking address of packed member 'mtu' of class
> or structure 'rfcomm_pn' may result in an unaligned pointer value
> [-Werror,-Waddress-of-packed-member]
>         if (!l2cap_frame_get_le16(frame, &pn.mtu))
>
> Currently there is no corresponding flag in GCC to generate the same error
> messages. See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=51628.
> ---
> v5 adds more details about the error messages.
>
>  monitor/rfcomm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index fd7bbdc..afeb5e1 100644
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
>
>         if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
>                 return false;
> --
> 2.8.0.rc3.226.g39d4020

Applied, thanks.

-- 
Luiz Augusto von Dentz
