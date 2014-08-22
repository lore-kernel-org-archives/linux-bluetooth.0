Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix header include
Date: Fri, 22 Aug 2014 10:20:49 +0200
Message-ID: <1641453.pzoKud3VOE@uw000953>
In-Reply-To: <1408540007-7621-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1408540007-7621-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 20 of August 2014 16:06:47 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Since Android KitKat we can use sys/prctl.h and sys/capability.h
> as specified in the manual page. Fixes also build warnings:
> ...
> warning: implicit declaration of function 'prctl'
> [-Wimplicit-function-declaration]
>   if (prctl(PR_SET_KEEPCAPS, 1) < 0) {
>   ^
> ...
> ---
>  android/main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/android/main.c b/android/main.c
> index 0a0c150..5299789 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -36,10 +36,8 @@
>  #include <unistd.h>
>  
>  #include <sys/signalfd.h>
> -#if defined(ANDROID)
> +#include <sys/prctl.h>
>  #include <sys/capability.h>
> -#include <linux/prctl.h>
> -#endif
>  
>  #include <glib.h>
>  
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
