Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1409826158-29266-1-git-send-email-vikram.pal@samsung.com>
References: <1409826158-29266-1-git-send-email-vikram.pal@samsung.com>
Date: Fri, 5 Sep 2014 13:32:21 +0300
Message-ID: <CABBYNZ+75-eA4X1pTwA5AQMWBTbJMoaft8Gq1WLOtOM66EXvbA@mail.gmail.com>
Subject: Re: [PATCH] monitor: Remove superfluous call to l2cap_frame_pull
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vikrampal Yadav <vikram.pal@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Sep 4, 2014 at 1:22 PM, Vikrampal Yadav <vikram.pal@samsung.com> wrote:
> Removed superfluous call to l2cap_frame_pull.
> ---
>  monitor/avctp.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index 64d4b58..98ffa22 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -546,16 +546,13 @@ static bool avrcp_list_player_attributes(struct l2cap_frame *frame,
>                                                 uint8_t ctype, uint8_t len,
>                                                 uint8_t indent)
>  {
> -       struct l2cap_frame avrcp_frame;
>         uint8_t num;
>         int i;
>
>         if (len == 0)
>                 return true;
>
> -       l2cap_frame_pull(&avrcp_frame, frame, 0);
> -
> -       if (!l2cap_frame_get_u8(&avrcp_frame, &num))
> +       if (!l2cap_frame_get_u8(frame, &num))
>                 return false;
>
>         print_field("%*cAttributeCount: 0x%02x", (indent - 8), ' ', num);
> @@ -563,7 +560,7 @@ static bool avrcp_list_player_attributes(struct l2cap_frame *frame,
>         for (i = 0; num > 0; num--, i++) {
>                 uint8_t attr;
>
> -               if (!l2cap_frame_get_u8(&avrcp_frame, &attr))
> +               if (!l2cap_frame_get_u8(frame, &attr))
>                         return false;
>
>                 print_field("%*cAttributeID: 0x%02x (%s)", (indent - 8), ' ',
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
