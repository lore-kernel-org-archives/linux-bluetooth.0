Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/doc: Update repository for Intel device build
Date: Tue, 26 Aug 2014 11:37:29 +0200
Message-ID: <3517265.qbqS1P6ODn@uw000953>
In-Reply-To: <1409038990-18316-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1409038990-18316-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 26 of August 2014 10:43:10 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use repositories from github/01org/
> ---
>  android/README | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/android/README b/android/README
> index 79434fc..b10789b 100644
> --- a/android/README
> +++ b/android/README
> @@ -88,16 +88,16 @@ Downloading and building for Intel devices
>  ------------------------------------------
>  
>  Sample Android tree with all required components for Intel devices based on
> -Intel reference image (https://01.org/android-ia) is availabe at
> -https://code.google.com/p/android-bluez/
> +Intel reference image (https://01.org/android-ia) can be reconstructed following
> +instructions below.
>  
>  This tree provides support for Dell XPS12, Minnowboard MAX, Intel NUC,
>  Acer Iconia W700 and other devices mentioned in:
>  https://01.org/android-ia/guides/devices
>  
>  Downloading:
> -repo init -u https://code.google.com/p/android-bluez.manifest/ -b android-ia \
> -	-m topic/bluez/master
> +repo init -u https://github.com/01org/android-bluez-manifest.git -b android-ia \
> +	-m topic/bluez
>  repo sync
>  
>  Building:
> 

Patch applied. Thanks.

-- 
Best regards, 
Szymon Janc
