Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 25/28] android/hog: Add MIN definition
Date: Thu, 02 Apr 2015 17:41:09 +0200
Message-ID: <9335022.2RmRJadLzG@leonov>
In-Reply-To: <1427906444-11769-26-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com> <1427906444-11769-26-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Wednesday 01 of April 2015 18:40:41 Mariusz Skamra wrote:
> It's needed to delete attrib, where the previous definition was.

Just squeeze this patch with one that requires this macro.

> ---
>  android/hog.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/hog.c b/android/hog.c
> index 9276d40..eb9c9d4 100644
> --- a/android/hog.c
> +++ b/android/hog.c
> @@ -59,6 +59,10 @@
>  #include "android/bas.h"
>  #include "android/hog.h"
> 
> +#ifndef MIN
> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> +#endif
> +
>  #define HOG_REPORT_TYPE_INPUT	1
>  #define HOG_REPORT_TYPE_OUTPUT	2
>  #define HOG_REPORT_TYPE_FEATURE	3

-- 
BR
Szymon Janc
