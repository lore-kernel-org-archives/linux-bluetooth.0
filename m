Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1408526647-23894-7-git-send-email-vikram.pal@samsung.com>
References: <1408526647-23894-1-git-send-email-vikram.pal@samsung.com>
	<1408526647-23894-7-git-send-email-vikram.pal@samsung.com>
Date: Wed, 20 Aug 2014 14:43:49 +0300
Message-ID: <CABBYNZKrJCUCnWuetE3gBbTsthvh_gAhzV5zi+aWjj8Z=CgYBw@mail.gmail.com>
Subject: Re: [PATCH 7/7] monitor: Fix AVRCP rejected packet handling error
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vikrampal,

On Wed, Aug 20, 2014 at 12:24 PM, Vikrampal Yadav
<vikram.pal@samsung.com> wrote:
> Rectified the handling of AVRCP rejected packets in btmon.
> ---
>  monitor/avctp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index c75b3ff..32dfd15 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -910,7 +910,8 @@ static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
>         { }
>  };
>
> -static void avrcp_rejected_packet(const struct l2cap_frame *frame)
> +static void avrcp_rejected_packet(const struct l2cap_frame *frame,
> +                                       uint8_t indent)
>  {
>         uint8_t status;
>
> @@ -921,7 +922,8 @@ static void avrcp_rejected_packet(const struct l2cap_frame *frame)
>         }
>
>         status = *((uint8_t *) frame->data);
> -       print_field("Error: 0x%02x (%s)", status, error2str(status));
> +       print_field("%*cError: 0x%02x (%s)", (indent - 8), ' ',
> +                                       status, error2str(status));
>  }
>
>  static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
> @@ -947,7 +949,8 @@ static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
>         }
>
>         if (ctype == 0xA) {
> -               avrcp_rejected_packet(frame);
> +               l2cap_frame_pull(&avrcp_frame, frame, 4);
> +               avrcp_rejected_packet(&avrcp_frame, indent + 2);
>                 return;
>         }
>
> --
> 1.9.1

Applied this one, please next time send the fixes first.


-- 
Luiz Augusto von Dentz
