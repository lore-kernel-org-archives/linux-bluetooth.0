Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Oct 2013 10:19:15 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] android: Suppress compiler warnings not used in
 autotools build
Message-ID: <20131030081914.GH27517@aemeltch-MOBL1>
References: <1383060218-25693-1-git-send-email-szymon.janc@tieto.com>
 <1383060218-25693-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383060218-25693-2-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Oct 29, 2013 at 04:23:38PM +0100, Szymon Janc wrote:
> Android build system is enabling some additional warnings that are not
> enabled when building with autotools. This avoids spurious warnings
> while building on Android.
> ---
>  android/Android.mk | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/android/Android.mk b/android/Android.mk
> index c88b27e..fc1b276 100644
> --- a/android/Android.mk
> +++ b/android/Android.mk
> @@ -9,6 +9,9 @@ pathmap_INCL += glib:external/bluetooth/glib
>  # Specify common compiler flags
>  BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\"
>  
> +# Disable warnings enabled by Android but not enabled in autotools build
> +BLUEZ_COMMON_CFLAGS += -Wno-pointer-arith

I wouldn't put this to BLUEZ_COMMON_CFLAGS, maybe only bluetoothd target
CFLAGS, the issue withing HAL might be easily fixed. We use void pointer
in math operations.

Best regards 
Andrei Emeltchenko 
