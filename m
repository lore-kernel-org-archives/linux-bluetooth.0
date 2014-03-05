Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/avdtp: Fix crash when DISCOVER failed
Date: Wed, 05 Mar 2014 16:46:04 +0100
Message-ID: <3751014.xU7GndY0WZ@uw000953>
In-Reply-To: <1394028150-2199-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1394028150-2199-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 05 of March 2014 15:02:30 Andrzej Kaczmarek wrote:
> Discover callback is only set when avdtp_discover was successful so we
> need to check if it's set before calling.
> ---
>  android/avdtp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/android/avdtp.c b/android/avdtp.c
> index f104e3e..96c7d0d 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -937,7 +937,8 @@ static void finalize_discovery(struct avdtp *session, int err)
>  	if (discover->id > 0)
>  		g_source_remove(discover->id);
>  
> -	discover->cb(session, session->seps, err ? &avdtp_err : NULL,
> +	if (discover->cb)
> +		discover->cb(session, session->seps, err ? &avdtp_err : NULL,
>  							discover->user_data);
>  	g_free(discover);
>  }
> 

Applied.

-- 
Best regards, 
Szymon Janc
