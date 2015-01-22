Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150122004130.GA4545@mail.example1.com>
References: <20150122004130.GA4545@mail.example1.com>
Date: Thu, 22 Jan 2015 11:32:05 +0200
Message-ID: <CABBYNZLNYtZfQ-5nufAms77Ygu79Bxhc1zy6cfO+Gb2KYeYijw@mail.gmail.com>
Subject: Re: [PATCH] tools/btsnoop: Fix opcode for SCO TX packet
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jukka Kinnunen <jukka.kinnunen@iki.fi>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Thu, Jan 22, 2015 at 2:41 AM, Jukka Kinnunen <jukka.kinnunen@iki.fi> wrote:
> ---
>  tools/btsnoop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/btsnoop.c b/tools/btsnoop.c
> index 71191eb..3eb8082 100644
> --- a/tools/btsnoop.c
> +++ b/tools/btsnoop.c
> @@ -230,7 +230,7 @@ next_packet:
>                 if (flags & 0x01)
>                         opcode = BTSNOOP_OPCODE_SCO_RX_PKT;
>                 else
> -                       opcode = BTSNOOP_OPCODE_ACL_TX_PKT;
> +                       opcode = BTSNOOP_OPCODE_SCO_TX_PKT;
>                 break;
>         case 0x04:
>                 opcode = BTSNOOP_OPCODE_EVENT_PKT;
> --
> 1.9.1

Pushed.


-- 
Luiz Augusto von Dentz
