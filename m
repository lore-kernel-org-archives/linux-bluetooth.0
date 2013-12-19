Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: Re: [PATCH] android/build: Adding l2test to Android.mk
Date: Thu, 19 Dec 2013 14:33:08 +0100
Message-ID: <1816695.PCLkSfLpb1@uw000953>
In-Reply-To: <1387457595-8020-1-git-send-email-sebastianx.chlad@intel.com>
References: <1387457595-8020-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

> Enabling l2test tool for the android target
> ---
>  android/Android.mk | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index ebc3219..fee2f6c 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -226,3 +226,27 @@ LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := audio.a2dp.default
>  
>  include $(BUILD_SHARED_LIBRARY)
> +
> +#
> +# l2cap-test
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	../tools/l2test.c \
> +	../lib/bluetooth.c \
> +	../lib/hci.c \
> +
> +LOCAL_C_INCLUDES := \
> +	$(LOCAL_PATH)/.. \
> +	$(LOCAL_PATH)/../lib \
> +	$(LOCAL_PATH)/../src/shared \
> +
> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
> +LOCAL_MODULE_TAGS := eng
> +LOCAL_MODULE := l2test
> +
> +include $(BUILD_EXECUTABLE)
> 

Applied (after fixing commit message), thanks.

-- 
BR
Szymon Janc


