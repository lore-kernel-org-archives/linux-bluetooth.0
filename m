Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417787069-11163-1-git-send-email-gowtham.ab@samsung.com>
References: <1417787069-11163-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 5 Dec 2014 17:14:46 +0200
Message-ID: <CABBYNZKre80wPrG9FxA8YkiD+_X4U9dD=6o-5n5jKJWxCoBLFQ@mail.gmail.com>
Subject: Re: [PATCH ] monitor/rfcomm: Fix byte ordering issue
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Dec 5, 2014 at 3:44 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> The correct byte order for RFCOMM protocol is
> little endian.
> ---
>  monitor/rfcomm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index fe3afb7..e8dfdb5 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -218,7 +218,7 @@ static inline bool mcc_rpn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>                 GET_RPN_RTCI(rpn.io), GET_RPN_RTCO(rpn.io), rpn.xon,
>                 rpn.xoff);
>
> -       if (!l2cap_frame_get_be16(frame, &rpn.pm))
> +       if (!l2cap_frame_get_le16(frame, &rpn.pm))
>                 return false;
>
>         print_field("%*cpm 0x%04x", indent, ' ', rpn.pm);
> @@ -267,7 +267,7 @@ static inline bool mcc_pn(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>         if (!l2cap_frame_get_u8(frame, &pn.ack_timer))
>                 return false;
>
> -       if (!l2cap_frame_get_be16(frame, &pn.mtu))
> +       if (!l2cap_frame_get_le16(frame, &pn.mtu))
>                 return false;
>
>         if (!l2cap_frame_get_u8(frame, &pn.max_retrans))
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
