Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Jul 2014 10:51:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Initial PTS docs for SPP
Message-ID: <20140722075153.GA25167@t440s.lan>
References: <1405953581-9541-1-git-send-email-sebastian.chlad@tieto.com>
 <1405953581-9541-2-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405953581-9541-2-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Mon, Jul 21, 2014, Sebastian Chlad wrote:
> PTS tests done on Android 4.4.4 and PTS 5.2
> ---
>  android/Makefile.am   |  2 +-
>  android/bite-spp.txt  | 19 ----------------
>  android/pics-spp.txt  | 61 ++++++++++++++++++++++++++++++++++++++++-----------
>  android/pixit-spp.txt | 19 ++++++++++++++++
>  android/pts-spp.txt   | 26 ++++++++++++++++++++++
>  5 files changed, 94 insertions(+), 33 deletions(-)
>  delete mode 100644 android/bite-spp.txt
>  create mode 100644 android/pixit-spp.txt
>  create mode 100644 android/pts-spp.txt
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index 057e92a..13633d1 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -316,7 +316,7 @@ EXTRA_DIST += android/Android.mk android/README \
>  				android/pixit-dis.txt \
>  				android/pixit-rfcomm.txt \
>  				android/pts-rfcomm.txt \
> -				android/bite-spp.txt \
> +				android/pts-spp.txt \
>  				android/pts-l2cap.txt \
>  				android/pts-gap.txt \
>  				android/pts-did.txt \

Seems like you're forgetting to add pixit-spp.txt to Makefile.am?

Johan
