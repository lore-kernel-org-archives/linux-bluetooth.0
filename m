Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Set exact Android version
Date: Wed, 27 Aug 2014 13:59:24 +0200
Message-ID: <1663200.3uZcVUqXQg@uw000953>
In-Reply-To: <1409140460-14029-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1409140460-14029-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wednesday 27 of August 2014 14:54:20 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For local build set exact current Android version.
> ---
>  android/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 4b93c5b..24714c4 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -1,6 +1,6 @@
>  if ANDROID
>  
> -AM_CFLAGS += -DANDROID_VERSION=0xFFFFFF
> +AM_CFLAGS += -DANDROID_VERSION=0x040404
>  
>  android_plugindir = $(abs_top_srcdir)/android/.libs
  
This is on purpose, since on host we always want to build latest API.

-- 
Best regards, 
Szymon Janc
