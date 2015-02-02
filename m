Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] android/build: Create a target for hciconfig.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1422861564-30169-1-git-send-email-icoolidge@google.com>
Date: Sun, 1 Feb 2015 23:49:48 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D620962F-0B39-4DF2-B9B1-CC5918193C9F@holtmann.org>
References: <1422861564-30169-1-git-send-email-icoolidge@google.com>
To: Ian Coolidge <icoolidge@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> ---
> android/Android.mk | 33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index c1a9eff..bf7e510 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -539,6 +539,39 @@ LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
> include $(BUILD_EXECUTABLE)
> 
> #
> +# hciconfig
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES:= \
> +	bluez/lib/bluetooth.c \
> +	bluez/lib/hci.c \
> +	bluez/tools/csr.c \
> +	bluez/tools/csr_h4.c \

are you sure about this csr_h4.c file? I do not think that it is needed.

> +	bluez/tools/hciconfig.c

Also could you re-order these similar to hcitool.

> +LOCAL_C_INCLUDES := \
> +	$(LOCAL_PATH)/bluez \
> +	$(LOCAL_PATH)/bluez/lib \
> +	$(LOCAL_PATH)/bluez/tools \
> +	$(LOCAL_PATH)/bluez/src \
> +	$(LOCAL_PATH)/bluez/src/shared \

The entry for hcitool gets away with just $(LOCAL_PATH)/bluez and I assume that is enough here as well.

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

Everything else looks just fine. On a side note, we never included the command so far since mostly everything can be done with btmgmt. Especially when it comes to qualification. Then again, I have no objections to include hciconfig since that command is more widely know as it seems.

Regards

Marcel

