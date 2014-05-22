Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Include headers from libhardware as system headers
Date: Thu, 22 May 2014 09:32:25 +0200
Message-ID: <6903600.aZEQEVyvJm@uw000953>
In-Reply-To: <1400689082-12662-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400689082-12662-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 21 of May 2014 18:18:02 Andrzej Kaczmarek wrote:
> Including hardware/audio.h in Android build produces sign-compare
> warning due to nested include of cutils/bitops.h. Since we cannot avoid
> this warning in sane way unless it's fixed in AOSP tree, we can make
> GCC think this is a system header and suppress warnings.
> 
> This patch changes the way headers from libhardware are added to
> search path from LOCAL_C_INCLUDES to explicit "-isystem" option added
> to LOCAL_CFLAGS.
> ---
>  android/Android.mk | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 4235a7c..d3d94ed 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -121,12 +121,12 @@ LOCAL_SRC_FILES := \

I'd rather fix this in AOSP instead of hacking this in our build system.

-- 
Best regards, 
Szymon Janc
