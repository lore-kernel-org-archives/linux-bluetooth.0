Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1416173167-6401-1-git-send-email-szymon.janc@tieto.com>
References: <1416173167-6401-1-git-send-email-szymon.janc@tieto.com>
Date: Mon, 17 Nov 2014 15:01:17 +0200
Message-ID: <CABBYNZJ0_=ifGvC0_TDx4h4nNDtfkyLtnhmtPJt4dj526JPR1A@mail.gmail.com>
Subject: Re: [PATCH] monitor/rfcomm: Fix not printing userdata in UIH frame
 with credits
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Sun, Nov 16, 2014 at 11:26 PM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> ACL Data RX: Handle 7 flags 0x02 dlen 19              [hci0] 8.723738
>       Channel: 65 len 15 [PSM 3 mode 0] {chan 1}
>       RFCOMM: Unnumbered Info with Header Check (UIH)(0xef)
>          Address: 0x09 cr 0 dlci 0x02
>          Control: 0xff poll/final 1
>          Length: 10
>          FCS: 0x5c
>          Credits: 1
>         41 54 2b 43 49 4e 44 3d 3f 0d 5c               AT+CIND=?.\
> ---
>  monitor/rfcomm.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index 881ae5e..b3db98b 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -171,7 +171,6 @@ static bool uih_frame(struct rfcomm_frame *rfcomm_frame, uint8_t indent)
>                         return false;
>                 hdr->credits = credits;
>                 print_field("%*cCredits: %d", indent, ' ', hdr->credits);
> -               return true;
>         }
>
>         packet_hexdump(frame->data, frame->size);
> --
> 1.9.3

Applied, thanks.


-- 
Luiz Augusto von Dentz
