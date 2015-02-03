Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Ian Coolidge <icoolidge@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/build: Create a target for hciconfig.
Date: Tue, 03 Feb 2015 10:53:34 +0100
Message-ID: <2544642.FWIBRmgKZO@uw000953>
In-Reply-To: <1422865529-9857-2-git-send-email-icoolidge@google.com>
References: <D620962F-0B39-4DF2-B9B1-CC5918193C9F@holtmann.org> <1422865529-9857-1-git-send-email-icoolidge@google.com> <1422865529-9857-2-git-send-email-icoolidge@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

On Monday 02 of February 2015 00:25:29 Ian Coolidge wrote:
> ---
>  android/Android.mk | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index c1a9eff..ff71089 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -539,6 +539,34 @@ LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
>  include $(BUILD_EXECUTABLE)
>  
>  #
> +# hciconfig
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES:= \
> +	bluez/tools/hciconfig.c \
> +	bluez/tools/csr.c \
> +	bluez/lib/bluetooth.c \
> +	bluez/lib/hci.c \
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
> +LOCAL_MODULE := hciconfig
> +
> +LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
> +
> +include $(BUILD_EXECUTABLE)
> +
> +#
>  # l2ping
>  #
>  

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
