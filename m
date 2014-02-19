Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/README: Add note on libglib under Valgrind
Date: Wed, 19 Feb 2014 20:28:11 +0100
Message-ID: <2776483.0XjNauqkPR@athlon>
In-Reply-To: <1392233027-3201-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392233027-3201-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 12 February 2014 20:23:47 Andrzej Kaczmarek wrote:
> ---
>  android/README | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/android/README b/android/README
> index 75b0a83..3095383 100644
> --- a/android/README
> +++ b/android/README
> @@ -124,6 +124,12 @@ After changing property value Bluetooth need to be
> restarted to apply changes (this can be done using UI, just disable and
> enable it again). Property is persistent, i.e. there's no need to enable
> Valgrind again after reboot.
> 
> +It's recommended to have unstripped libglib.so installed which will enable
> +complete backtraces in Valgrind output. Otherwise, in many cases backtrace
> +will break at e.g. g_free() function without prior callers. It's possible
> to +have proper library installed automatically by appropriate entry in
> Android.mk, +see https://code.google.com/p/aosp-bluez.glib/ for an example.
> +
>  =============================
>  Building and running on Linux
>  =============================

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
