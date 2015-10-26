Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/README: Update known Android issues section
Date: Mon, 26 Oct 2015 21:05:22 +0100
Message-ID: <5608810.3GPEjARR0U@ix>
In-Reply-To: <1445349902-16586-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1445349902-16586-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tuesday 20 October 2015 16:05:02 Grzegorz Kolodziejczyk wrote:
> This adds a patch which allows handling ssp passkey request.
> ---
>  android/README | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/android/README b/android/README
> index 9aa9a37..6b7f79d 100644
> --- a/android/README
> +++ b/android/README
> @@ -9,7 +9,7 @@ replacement to Android provided Bluetooth stack.
>  More details about BlueZ for Android architecture and components can be
> found in android/hal-ipc-api.txt file.
> 
> -Supported Android version: 4.4 KitKat and 5.0 Lollipop
> +Supported Android version: 4.4 KitKat and 5.0, 5.1.1 Lollipop
> 
> 
>  Building and running on Android
> @@ -402,12 +402,16 @@ affect qualification or user experience. This section
> provides list of recommended Android fixes that are not part of latest AOSP
> release supported by BlueZ.
> 
> +For Android 5.1.1 Lollipop:
> +https://android-review.googlesource.com/177314
> +
>  For Android 5.0 Lollipop:
>  https://android-review.googlesource.com/99761
>  https://android-review.googlesource.com/100297
>  https://android-review.googlesource.com/102882
>  https://android-review.googlesource.com/132733
>  https://android-review.googlesource.com/132763
> +https://android-review.googlesource.com/177314
> 
>  For Android 4.4 KitKat:
>  https://android-review.googlesource.com/82757
> @@ -417,6 +421,7 @@ https://android-review.googlesource.com/99761
>  https://android-review.googlesource.com/99850
>  https://android-review.googlesource.com/100297
>  https://android-review.googlesource.com/102882
> +https://android-review.googlesource.com/177314
> 
>  Unimplemented Bluetooth features
>  ================================

Applied, thanks.

-- 
pozdrawiam
Szymon Janc
