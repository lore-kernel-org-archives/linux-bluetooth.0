Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/socket: Fix calling cleanup with invalid pointer
Date: Fri, 21 Feb 2014 15:30:08 +0100
Message-ID: <4112303.uEkGK64xUY@uw000953>
In-Reply-To: <1392991129-23026-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392991129-23026-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Friday 21 of February 2014 14:58:49 Andrzej Kaczmarek wrote:
> ---
>  android/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/socket.c b/android/socket.c
> index 48a8746..e2da689 100644
> --- a/android/socket.c
> +++ b/android/socket.c
> @@ -1151,7 +1151,7 @@ void bt_socket_unregister(void)
>  
>  	for (ch = 0; ch <= RFCOMM_CHANNEL_MAX; ch++)
>  		if (servers[ch].rfsock)
> -			cleanup_rfsock(&servers[ch]);
> +			cleanup_rfsock(servers[ch].rfsock);
>  
>  	memset(servers, 0, sizeof(servers));
>  

Pushed, thanks.

-- 
Best regards, 
Szymon Janc
