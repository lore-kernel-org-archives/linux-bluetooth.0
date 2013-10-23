Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Make use of Android system headers instead of local one
Date: Wed, 23 Oct 2013 14:54:32 +0200
Message-ID: <1590675.ZHhqgJkD5A@uw000953>
In-Reply-To: <1382532281-5445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382532281-5445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wednesday 23 of October 2013 15:44:41 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Since the headers were copied to android/ folder Android build started
> to use those instead of original Android system headers. The patch
> puts Android system headers first.
> ---
>  android/Android.mk | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 3163763..0640842 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -71,6 +71,9 @@ LOCAL_SRC_FILES := \
>  	hal-pan.c \
>  	hal-av.c \
>  
> +LOCAL_C_INCLUDES += \
> +	system/core/include \
> +

We could use include-path-for to not hardcode path to core
LOCAL_C_INCLUDES += $(call include-path-for, system-core)

>  LOCAL_SHARED_LIBRARIES := \
>  	libcutils \
>  
> 


-- 
BR
Szymon Janc
