Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/socket: Use same RFCOMM channels for services as Linux daemon
Date: Sat, 01 Mar 2014 14:06:39 +0100
Message-ID: <11615914.CiKuHk2JIG@leonov>
In-Reply-To: <1393622608-22965-1-git-send-email-szymon.janc@tieto.com>
References: <1393622608-22965-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Friday 28 of February 2014 22:23:28 Szymon Janc wrote:
> Use numbers from doc/assigned-numbers.txt.
> ---
>  android/socket.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/android/socket.c b/android/socket.c
> index ee98b54..9aab345 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -47,9 +47,10 @@
> 
>  #define RFCOMM_CHANNEL_MAX 30
> 
> -#define OPP_DEFAULT_CHANNEL	12
> +#define OPP_DEFAULT_CHANNEL	9
>  #define HFAG_DEFAULT_CHANNEL	13
> -#define PBAP_DEFAULT_CHANNEL	19
> +#define PBAP_DEFAULT_CHANNEL	15
> +#define MAP_MAS_DEFAULT_CHANNEL	16
> 
>  #define SVC_HINT_OBEX 0x10
> 
> @@ -403,7 +404,7 @@ static const struct profile_info {
>  			0x00, 0x00, 0x11, 0x32, 0x00, 0x00, 0x10, 0x00,
>  			0x80, 0x00, 0x00, 0x80, 0x5F, 0x9B, 0x34, 0xFB
>  		},
> -		.channel = 0,
> +		.channel = MAP_MAS_DEFAULT_CHANNEL,
>  		.svc_hint = SVC_HINT_OBEX,
>  		.sec_level = BT_IO_SEC_MEDIUM,
>  		.create_record = create_mas_record

Pushed.

-- 
BR
Szymon Janc
