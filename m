Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Build hciattach tool
Date: Fri, 18 Apr 2014 15:16:04 +0200
Message-ID: <2191282.BWAK0eFnUi@uw000953>
In-Reply-To: <1397565665-28832-1-git-send-email-szymon.janc@tieto.com>
References: <1397565665-28832-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tuesday 15 of April 2014 14:41:05 Szymon Janc wrote:
> ---
> This requires ppoll. bionic at http://code.google.com/p/aosp-bluez
> was updated with ppoll backported from bionic master branch.
> 
>  android/Android.mk | 30 ++++++++++++++++++++++++++++++
>  android/README     |  2 +-
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 5f4e70c..f838bfd 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -443,6 +443,36 @@ LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
>  include $(BUILD_EXECUTABLE)
>  
>  #
> +# hciattach
> +#
> +
> +include $(CLEAR_VARS)
> +
> +LOCAL_SRC_FILES := \
> +	bluez/tools/hciattach.c \
> +	bluez/tools/hciattach_st.c \
> +	bluez/tools/hciattach_ti.c \
> +	bluez/tools/hciattach_tialt.c \
> +	bluez/tools/hciattach_ath3k.c \
> +	bluez/tools/hciattach_qualcomm.c \
> +	bluez/tools/hciattach_intel.c \
> +	bluez/tools/hciattach_bcm43xx.c \
> +	bluez/lib/bluetooth.c \
> +	bluez/lib/hci.c \
> +
> +LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
> +
> +LOCAL_STATIC_LIBRARIES := \
> +	bluetooth-headers \
> +
> +LOCAL_MODULE_TAGS := optional
> +LOCAL_MODULE := hciattach
> +
> +LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/bluez/configure.ac
> +
> +include $(BUILD_EXECUTABLE)
> +
> +#
>  # libsbc
>  #
>  
> diff --git a/android/README b/android/README
> index ff4d7bf..6254d34 100644
> --- a/android/README
> +++ b/android/README
> @@ -33,7 +33,7 @@ by BlueZ. SBC code is available at git://git.kernel.org/pub/scm/bluetooth/sbc
>  - Bionic support - Currently only 'master' branch available at
>  https://android.googlesource.com/platform/bionic provides all required
>  functionality and running BlueZ on release branch requires backporting missing
> -features (currently only epoll_create1 call for Android 4.4.2). Sample
> +features (currently epoll_create1 and ppoll calls for Android 4.4.2). Sample
>  Bionic for Android 4.4.2 with all required features backported is available at
>  https://code.google.com/p/aosp-bluez.platform-bionic/
>  
> 

Pushed.

-- 
Best regards, 
Szymon Janc
