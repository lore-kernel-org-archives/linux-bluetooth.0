Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add avtest to debug builds
Date: Thu, 30 Jan 2014 17:25:23 +0100
Message-ID: <695553450.ftiWlZ47uS@leonov>
In-Reply-To: <1390999219-15012-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390999219-15012-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 29 of January 2014 14:40:19 Sebastian Chlad wrote:
> ---
>  android/Android.mk | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 1d12da5..238bb7c 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -354,6 +354,34 @@ LOCAL_MODULE := l2ping
>  include $(BUILD_EXECUTABLE)
> 
>  #
> +# avtest
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	bluez/tools/avtest.c \
> +	bluez/lib/bluetooth.c \
> +	bluez/lib/hci.c \
> +
> +LOCAL_C_INCLUDES := \
> +	$(LOCAL_PATH)/bluez/lib \
> +
> +lib_headers := \
> +	bluetooth.h \
> +	hci.h \
> +
> +$(foreach file,$(lib_headers), $(shell ln -sf ../$(file)
> $(LOCAL_PATH)/bluez/lib/bluetooth/$(file))) +

Why is this need? Please compare on how other tools were added to Android.mk 

> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
> +LOCAL_MODULE_TAGS := debug
> +LOCAL_MODULE := avtest
> +
> +include $(BUILD_EXECUTABLE)
> +
> +#
>  # libsbc
>  #

-- 
BR
Szymon Janc
