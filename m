Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 01/47] android: Set exact Android version
Date: Tue, 04 Nov 2014 15:03:38 +0100
Message-ID: <1604181.xXzdJLTG5G@uw000953>
In-Reply-To: <1415089150-18798-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415089150-18798-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1415089150-18798-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 04 of November 2014 10:18:24 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> For local build set exact current Android version.
> ---
>  android/Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 496fbc4..bd05654 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -1,6 +1,6 @@
>  if ANDROID
>  
> -AM_CFLAGS += -DANDROID_VERSION=0xFFFFFF -DBLUEZ_EXTENSIONS
> +AM_CFLAGS += -DANDROID_VERSION=0x040404 -DBLUEZ_EXTENSIONS
>  
>  android_plugindir = $(abs_top_srcdir)/android/.libs
>  

This patch is now applied, thanks. 

-- 
Best regards, 
Szymon Janc
