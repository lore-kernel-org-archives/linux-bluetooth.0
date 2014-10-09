Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412855826-3665-1-git-send-email-vikram.pal@samsung.com>
References: <1412855826-3665-1-git-send-email-vikram.pal@samsung.com>
Date: Thu, 9 Oct 2014 14:58:35 +0300
Message-ID: <CABBYNZJ-SdhX2S6_BPoPYe2qyavnpqhWAYgKmPi4qAABsrMw2g@mail.gmail.com>
Subject: Re: [PATCH] Monitor: Fix indentation for AVRCP PASS THROUGH commands
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikram,

On Thu, Oct 9, 2014 at 2:57 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Intendation for AVRCP PASS THROUGH commands' decoding fixed.

Please use lower case at the beginning e.g. monitor:

> ---
>  monitor/avctp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index a4e34c5..4abd18f 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -686,13 +686,13 @@ static bool avrcp_passthrough_packet(struct avctp_frame *avctp_frame,
>         if (!l2cap_frame_get_u8(frame, &op))
>                 return false;
>
> -       print_field("%*cOperation: 0x%02x (%s %s)", (indent - 2), ' ', op,
> +       print_field("%*cOperation: 0x%02x (%s %s)", (indent - 8), ' ', op,
>                                 op2str(op), op & 0x80 ? "Released" : "Pressed");
>
>         if (!l2cap_frame_get_u8(frame, &len))
>                 return false;
>
> -       print_field("%*cLength: 0x%02x", (indent - 2), ' ', len);
> +       print_field("%*cLength: 0x%02x", (indent - 8), ' ', len);
>
>         packet_hexdump(frame->data, frame->size);
>         return true;
> --
> 1.9.1


Could you please start adding the output of the btmon to the
description once you add new parsers like this that way we can spot
more easily formatting bugs such as this.



-- 
Luiz Augusto von Dentz
