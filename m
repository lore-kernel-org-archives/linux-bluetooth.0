Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/build: Fix bluetoothd build
Date: Thu, 13 Nov 2014 14:13:56 +0100
Message-ID: <3108393.5OxeeWlg6M@uw000953>
In-Reply-To: <1415877074-25891-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1415877074-25891-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 13 of November 2014 12:11:14 Jakub Tyszkowski wrote:
> This fixes the following error:
> external/bluetooth/bluez/src/shared/gatt-db.c:787: error: undefined
> reference to 'timeout_remove'
> external/bluetooth/bluez/src/shared/gatt-db.c:879: error: undefined
> reference to 'timeout_remove'
> external/bluetooth/bluez/src/shared/gatt-db.c:825: error: undefined
> reference to 'timeout_add'
> external/bluetooth/bluez/src/shared/gatt-db.c:917: error: undefined
> reference to 'timeout_add'
> collect2: error: ld returned 1 exit status
> make: ***
> [out/target/product/flo/obj/EXECUTABLES/bluetoothd-main_intermediates/LINKED/bluetoothd-main]
> Error 1
> ---
>  android/Android.mk | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index 9735976..554e8fa 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -64,6 +64,7 @@ LOCAL_SRC_FILES := \
>  	bluez/src/shared/hfp.c \
>  	bluez/src/shared/gatt-db.c \
>  	bluez/src/shared/io-glib.c \
> +	bluez/src/shared/timeout-glib.c \
>  	bluez/src/shared/crypto.c \
>  	bluez/src/shared/uhid.c \
>  	bluez/src/sdpd-database.c \

Applied, thanks. 

-- 
Best regards, 
Szymon Janc
