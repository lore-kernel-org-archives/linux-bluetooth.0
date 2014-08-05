Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Aug 2014 10:58:35 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/doc: Add instructions for android-ia
Message-ID: <20140805075834.GD26104@aemeltch-MOBL1>
References: <1406900402-12528-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406900402-12528-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Fri, Aug 01, 2014 at 04:40:02PM +0300, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Add instructions for building Android image based on android-ia from
> 01.org.
> ---
>  android/README | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/android/README b/android/README
> index fb00f40..79434fc 100644
> --- a/android/README
> +++ b/android/README
> @@ -84,6 +84,31 @@ After full build is done it is possible to rebuild only BlueZ:
>  'mm' (or 'mm -B' to force rebuilding of all files)
>  'adb sync' to update target device.
>  
> +Downloading and building for Intel devices
> +------------------------------------------
> +
> +Sample Android tree with all required components for Intel devices based on
> +Intel reference image (https://01.org/android-ia) is availabe at
> +https://code.google.com/p/android-bluez/
> +
> +This tree provides support for Dell XPS12, Minnowboard MAX, Intel NUC,
> +Acer Iconia W700 and other devices mentioned in:
> +https://01.org/android-ia/guides/devices
> +
> +Downloading:
> +repo init -u https://code.google.com/p/android-bluez.manifest/ -b android-ia \
> +	-m topic/bluez/master
> +repo sync
> +
> +Building:
> +source build/envsetup.sh
> +lunch haswell_generic-eng
> +make -j8
> +
> +Installing:
> +Live and Install image is $OUT/live.img
> +Flash live.img to USB flash and boot from it. More instructions here:
> +https://01.org/android-ia/guides/developers/build-and-install
>  
>  Linux Kernel requirements
>  -------------------------
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
