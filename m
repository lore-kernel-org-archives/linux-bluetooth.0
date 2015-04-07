Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools: Fix btmgmt build on Android
Date: Tue, 07 Apr 2015 11:03:11 +0200
Message-ID: <3161930.4iEHlW5ORN@leonov>
In-Reply-To: <1428396276-9396-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428396276-9396-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Tuesday 07 of April 2015 10:44:36 Mariusz Skamra wrote:
> target Executable: btmgmt
> (out/target/product/mako/obj/EXECUTABLES/btmgmt_intermediates/LINKED/btmgmt
> ) external/bluetooth/bluez/tools/btmgmt.c:1477: error: undefined reference
> to 'hci_bustostr' collect2: error: ld returned 1 exit status
> ---
>  android/Android.mk | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index f218805..1e22ca6 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -539,6 +539,7 @@ include $(CLEAR_VARS)
>  LOCAL_SRC_FILES := \
>  	bluez/tools/btmgmt.c \
>  	bluez/lib/bluetooth.c \
> +	bluez/lib/hci.c \
>  	bluez/lib/sdp.c \
>  	bluez/src/shared/mainloop.c \
>  	bluez/src/shared/io-mainloop.c \

Patch applied, thanks.

-- 
BR
Szymon Janc
