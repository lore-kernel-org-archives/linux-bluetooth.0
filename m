Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ian Coolidge <icoolidge@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/log: Add missing libc includes.
Date: Mon, 02 Feb 2015 12:50:25 +0100
Message-ID: <1527070.LF3VyE4bnx@uw000953>
In-Reply-To: <1422866028-10696-1-git-send-email-icoolidge@google.com>
References: <1422866028-10696-1-git-send-email-icoolidge@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

On Monday 02 of February 2015 00:33:48 Ian Coolidge wrote:
> ---
>  android/log.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/log.c b/android/log.c
> index 09d226a..8013eba 100644
> --- a/android/log.c
> +++ b/android/log.c
> @@ -25,7 +25,10 @@
>  #endif
>  
>  #include <fcntl.h>
> +#include <stdarg.h>
>  #include <stdio.h>
> +#include <stdint.h>
> +#include <stdlib.h>
>  #include <unistd.h>
>  #include <stdbool.h>
>  #include <time.h>

Could you add some explanation to commit message why those are needed?

-- 
Best regards, 
Szymon Janc
