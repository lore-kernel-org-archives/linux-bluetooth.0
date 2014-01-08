Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix bluetoothd installation path
Date: Wed, 08 Jan 2014 17:57:22 +0100
Message-ID: <1482934.Q0UzPI5uvD@athlon>
In-Reply-To: <1389199321-26623-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389199321-26623-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 08 January 2014 17:42:01 Andrzej Kaczmarek wrote:
> This patch removes explicit LOCAL_MODULE_PATH definition for bluetoothd
> and bluetoothd-snoop modules which caused both binaries to be installed
> in /system/xbin instead of /system/bin folder.
> ---
>  android/Android.mk | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 16339b1..8eb918e 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -75,7 +75,6 @@ $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
> 
>  $(foreach file,$(lib_headers), $(shell ln -sf ../$(file)
> $(LOCAL_PATH)/../lib/bluetooth/$(file)))
> 
> -LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := bluetoothd
> 
> @@ -264,7 +263,6 @@ LOCAL_C_INCLUDES := \
> 
>  LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> 
> -LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE := bluetoothd-snoop

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
