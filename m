Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415782396-28799-1-git-send-email-vikram.pal@samsung.com>
References: <1415782396-28799-1-git-send-email-vikram.pal@samsung.com>
Date: Wed, 12 Nov 2014 14:18:47 +0200
Message-ID: <CABBYNZKDBecKc96qmXX6PmGa8o-kc=Y+BRCZUwT=A3NWJR+n6A@mail.gmail.com>
Subject: Re: [PATCH 1/3] monitor: Adjust for ERTM control bytes
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Wed, Nov 12, 2014 at 10:53 AM, Vikrampal Yadav
<vikram.pal@samsung.com> wrote:
> Adjustment for ERTM control bytes fixed.
> ---
>  monitor/l2cap.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index ebdd20f..b37f20f 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -2621,6 +2621,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
>                 connless_packet(index, in, handle, cid, data, size);
>                 break;
>         case 0x0003:
> +               /* Adjust for ERTM control bytes */
> +               data += 2;
> +               size -= 2;
>                 amp_packet(index, in, handle, cid, data, size);
>                 break;
>         case 0x0004:
> @@ -2635,6 +2638,9 @@ static void l2cap_frame(uint16_t index, bool in, uint16_t handle,
>         default:
>                 l2cap_frame_init(&frame, index, in, handle, cid, data, size);
>
> +               if (frame.mode > 0)
> +                       l2cap_frame_pull(&frame, &frame, 2);
> +
>                 print_indent(6, COLOR_CYAN, "Channel:", "", COLOR_OFF,
>                                 " %d len %d [PSM %d mode %d] {chan %d}",
>                                                 cid, size, frame.psm,
> --
> 1.9.1

This is probably not enough if we really want to do it right, please
check tools/parser/l2cap.c:l2cap_ctrl_ext_parse we most likely need to
do something similar but this time we should actually not pass
s-frames to be decoded further, only i-frames should contain data
relevant to profiles.



-- 
Luiz Augusto von Dentz
