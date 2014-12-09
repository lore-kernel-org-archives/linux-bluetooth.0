Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/build: Enable multilib build for bluetooth.default
Date: Tue, 09 Dec 2014 12:13:49 +0100
Message-ID: <2042162.IYkz5hhu3z@leonov>
In-Reply-To: <1418118307-13170-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1418118307-13170-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 09 of December 2014 11:45:07 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/Android.mk | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 9ee2fc9..2b90cee 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -154,7 +154,7 @@ LOCAL_SHARED_LIBRARIES := \
>  LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> 
>  LOCAL_MODULE := bluetooth.default
> -LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
> +LOCAL_MODULE_RELATIVE_PATH := hw
>  LOCAL_MODULE_TAGS := optional
>  LOCAL_MODULE_CLASS := SHARED_LIBRARIES
>  LOCAL_REQUIRED_MODULES := bluetoothd bluetoothd-snoop init.bluetooth.rc

Patch applied, thanks.

-- 
BR
Szymon Janc
