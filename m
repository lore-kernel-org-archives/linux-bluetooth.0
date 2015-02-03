Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ian Coolidge <icoolidge@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/log: Add missing libc includes.
Date: Tue, 03 Feb 2015 10:54:21 +0100
Message-ID: <4381977.cQkKW9qsOB@uw000953>
In-Reply-To: <1422904240-31160-1-git-send-email-icoolidge@google.com>
References: <1527070.LF3VyE4bnx@uw000953> <1422904240-31160-1-git-send-email-icoolidge@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

On Monday 02 of February 2015 11:10:40 Ian Coolidge wrote:
> Bionic is moving to reduce the amount of transitive includes,
> so they should not be relied upon.
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
> 

Patch applied, thanks.

-- 
Best regards, 
Szymon Janc
