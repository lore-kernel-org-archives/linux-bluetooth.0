Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/README: Add Valgrind description
Date: Tue, 11 Feb 2014 17:34:15 +0100
Message-ID: <8190802.H0AKWduXNq@leonov>
In-Reply-To: <1392119033-23035-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392119033-23035-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tuesday 11 of February 2014 12:43:53 Andrzej Kaczmarek wrote:
> ---
>  android/README | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/android/README b/android/README
> index e3c314f..c7145d5 100644
> --- a/android/README
> +++ b/android/README
> @@ -108,6 +108,22 @@ be found at https://backports.wiki.kernel.org. Sample
> kernels using backports for running BlueZ on Android are available at
>  https://code.google.com/p/aosp-bluez.
> 
> +Running with Valgrind
> +=====================
> +
> +BlueZ for Android is preconfigured to be easily run under Valgrind
> memcheck. +Appropriate configuration and required modules are automatically
> included when +building either userdebug or eng variant of Android
> platform.
> +
> +Valgrind can be enabled in runtime by setting
> "persist.sys.bluetooth.valgrind" +property to either literal "true" or any
> numeric value >0. For example: +adb root
> +adb shell setprop persist.sys.bluetooth.valgrind true
> +
> +After changing property value Bluetooth need to be restarted to apply
> changes +(this can be done using UI, just disable and enable it again).
> Property is +persistent, i.e. there's no need to enable Valgrind again
> after reboot. +
>  =============================
>  Building and running on Linux
>  =============================

Pushed, thanks.

-- 
BR
Szymon Janc
