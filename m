Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Add avtest to debug builds
Date: Fri, 31 Jan 2014 14:43:57 +0100
Message-ID: <2047435.vTTSWYZz0V@leonov>
In-Reply-To: <1391160672-9088-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390999219-15012-1-git-send-email-sebastianx.chlad@intel.com> <1391160672-9088-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 31 of January 2014 11:31:12 Sebastian Chlad wrote:
> ---
>  android/Android.mk | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 1d12da5..09ed32d 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -354,6 +354,28 @@ LOCAL_MODULE := l2ping
>  include $(BUILD_EXECUTABLE)
> 
>  #
> +# avtest
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +        bluez/tools/avtest.c \
> +        bluez/lib/bluetooth.c \
> +        bluez/lib/hci.c \
> +
> +LOCAL_C_INCLUDES := \
> +        $(LOCAL_PATH)/bluez/lib \
> +
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

Applied, thanks.

-- 
BR
Szymon Janc
