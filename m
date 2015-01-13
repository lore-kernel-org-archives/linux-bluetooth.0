Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Make shutdown timeout shorter
Date: Tue, 13 Jan 2015 14:49:21 +0100
Message-ID: <1923894.5Av9aTq1So@uw000953>
In-Reply-To: <1420712170-14973-1-git-send-email-szymon.janc@tieto.com>
References: <1420712170-14973-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday 08 of January 2015 11:16:10 Szymon Janc wrote:
> Android L is using 8 seconds for both enable and disable timeouts.
> Set daemon shutdown timeout to 5 seconds to make sure we fit into
> framework timeout in case things goes wrong.
> ---
>  android/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/main.c b/android/main.c
> index 58dd9ab..ec28742 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -70,7 +70,7 @@
>  #define DEFAULT_NAME "BlueZ for Android"
>  
>  #define STARTUP_GRACE_SECONDS 5
> -#define SHUTDOWN_GRACE_SECONDS 10
> +#define SHUTDOWN_GRACE_SECONDS 5
>  
>  static char *config_vendor = NULL;
>  static char *config_model = NULL;
> 

Applied.

-- 
Best regards, 
Szymon Janc
