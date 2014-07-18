Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/build: Add rctest tool to Android build
Date: Fri, 18 Jul 2014 12:32:38 +0200
Message-ID: <2238097.cVBx7WdD7G@uw000953>
In-Reply-To: <1405595072-7749-1-git-send-email-sebastian.chlad@tieto.com>
References: <1405595072-7749-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Thursday 17 of July 2014 13:04:32 Sebastian Chlad wrote:
> ---
>  android/Android.mk | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 51a792f..afbe804 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -661,3 +661,31 @@ LOCAL_MODULE := avinfo
>  LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
>  
>  include $(BUILD_EXECUTABLE)
> +
> +#
> +# rctest
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	bluez/tools/rctest.c \
> +	bluez/lib/bluetooth.c \
> +	bluez/lib/hci.c \
> +	bluez/lib/sdp.c \
> +
> +LOCAL_C_INCLUDES := \
> +	$(LOCAL_PATH)/bluez \
> +
> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_STATIC_LIBRARIES := \
> +	bluetooth-headers \
> +
> +LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
> +LOCAL_MODULE_TAGS := debug
> +LOCAL_MODULE := rctest
> +
> +LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
> +
> +include $(BUILD_EXECUTABLE)
> 

Pushed. Thanks.

-- 
Best regards, 
Szymon Janc
