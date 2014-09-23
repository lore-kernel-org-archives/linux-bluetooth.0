Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/build: Add BLUEZ_EXTENSIONS to default cflags
Date: Tue, 23 Sep 2014 16:13:18 +0200
Message-ID: <9540580.EFTB4ij8tO@uw000953>
In-Reply-To: <1411454927-27079-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411454927-27079-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 23 of September 2014 08:48:47 Jakub Tyszkowski wrote:
> This is to be sure that all modules knows when we use extensions.
> ---
>  android/Android.mk | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index db5032d..8887a97 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -14,6 +14,10 @@ BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
>  			-DANDROID_VERSION=$(ANDROID_VERSION) \
>  			-DANDROID_STORAGEDIR=\"/data/misc/bluetooth\" \
>  
> +ifeq ($(BLUEZ_EXTENSIONS), true)
> +BLUEZ_COMMON_CFLAGS += -DBLUEZ_EXTENSIONS
> +endif
> +
>  # Enable warnings enabled in autotools build
>  BLUEZ_COMMON_CFLAGS += -Wall -Wextra \
>  			-Wdeclaration-after-statement \
> @@ -142,10 +146,6 @@ LOCAL_SHARED_LIBRARIES := \
>  
>  LOCAL_CFLAGS := $(BLUEZ_COMMON_CFLAGS)
>  
> -ifeq ($(BLUEZ_EXTENSIONS), true)
> -LOCAL_CFLAGS += -DBLUEZ_EXTENSIONS
> -endif
> -
>  LOCAL_MODULE := bluetooth.default
>  LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw
>  LOCAL_MODULE_TAGS := optional
> 

Patch applied. Thanks.

-- 
Best regards, 
Szymon Janc
