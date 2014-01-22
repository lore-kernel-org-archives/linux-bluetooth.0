Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/2] android: Add btmgmt to debug builds
Date: Wed, 22 Jan 2014 01:03:37 +0100
Message-ID: <21726089.bZcAWeKVj0@athlon>
In-Reply-To: <1390333570-13196-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1390333570-13196-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tuesday 21 January 2014 20:46:09 Andrzej Kaczmarek wrote:
> ---
>  android/Android.mk | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index e66d70a..e3a31c1 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -296,3 +296,33 @@ LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)
> 
>  include $(BUILD_PREBUILT)
> +
> +#
> +# btmgmt
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	../tools/btmgmt.c \
> +	../lib/bluetooth.c \
> +	../lib/sdp.c \
> +	../monitor/mainloop.c \
> +	../src/shared/io-mainloop.c \
> +	../src/shared/mgmt.c \
> +	../src/shared/queue.c \
> +	../src/shared/util.c \
> +	../src/uuid-helper.c \
> +
> +LOCAL_C_INCLUDES := \
> +	$(LOCAL_PATH)/.. \
> +	$(LOCAL_PATH)/../src \
> +	$(LOCAL_PATH)/../lib \
> +
> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
> +LOCAL_MODULE_TAGS := debug
> +LOCAL_MODULE := btmgmt
> +
> +include $(BUILD_EXECUTABLE)

Both patches applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
