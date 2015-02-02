Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update SPP TC_DevA_APP_BV_01_C instruction
Date: Mon, 02 Feb 2015 22:06:57 +0100
Message-ID: <3413618.MYqlWnmNeZ@athlon>
In-Reply-To: <1422891458-13997-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1422891458-13997-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Monday 02 February 2015 16:37:38 Grzegorz Kolodziejczyk wrote:
> This patch updates SPP test case instruction. Use haltest socket connect
> command instead of rctest.
> ---
>  android/pts-spp.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pts-spp.txt b/android/pts-spp.txt
> index 6972020..2d2815b 100644
> --- a/android/pts-spp.txt
> +++ b/android/pts-spp.txt
> @@ -13,8 +13,8 @@ N/A	test is disabled due to PICS setup
>  ---------------------------------------------------------------------------
> ---- Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- -TC_DevA_APP_BV_01_C	PASS	sdptool browse <bdaddr> - check RFCOMM
> channel -				rctest -n -P <channel> <bdaddr>
> +TC_DevA_APP_BV_01_C	PASS	haltest: socket connect <PTS addr>
> +					BTSOCK_RFCOMM 00001101 0
>  TC_DevB_APP_BV_02_C	PASS	haltest: socket listen BTSOCK_RFCOMM 
SerialPort
>  					00001101
>  				Note: IUT must be in connectable, discoverable

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
