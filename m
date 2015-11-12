Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <ext.szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/log: Fix compilation error in AOSP
Date: Thu, 12 Nov 2015 11:17:50 +0100
Message-ID: <7348840.K5Wc2JxOWi@leonov>
In-Reply-To: <1447265391-26817-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447265391-26817-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 11 of November 2015 19:09:51 Andrzej Kaczmarek wrote:
> btd_debug() has new parameter introduced in dcfdc556.
> ---
>  android/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/log.c b/android/log.c
> index 8013eba..35917c6 100644
> --- a/android/log.c
> +++ b/android/log.c
> @@ -139,7 +139,7 @@ void error(const char *format, ...)
>  	va_end(ap);
>  }
> 
> -void btd_debug(const char *format, ...)
> +void btd_debug(uint16_t index, const char *format, ...)
>  {
>  	va_list ap;

Applied, thanks.

-- 
BR
Szymon Janc
