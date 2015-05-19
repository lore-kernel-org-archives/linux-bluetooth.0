Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Mariusz Skamra <mariusz.skamra@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update SPP test results
Date: Tue, 19 May 2015 19:18:19 +0200
Message-ID: <2136018.0falkM9Tx6@leonov>
In-Reply-To: <1432047116-27352-1-git-send-email-mariusz.skamra@tieto.com>
References: <1432047116-27352-1-git-send-email-mariusz.skamra@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mariusz,

On Tuesday 19 of May 2015 16:51:56 Mariusz Skamra wrote:
> PTS 6.1 and Android 5.1
> ---
>  android/pics-spp.txt  | 12 ++++++------
>  android/pixit-spp.txt |  2 +-
>  android/pts-spp.txt   |  7 +++----
>  3 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/android/pics-spp.txt b/android/pics-spp.txt
> index d9bb883..d6bf97a 100644
> --- a/android/pics-spp.txt
> +++ b/android/pics-spp.txt
> @@ -1,6 +1,6 @@
>  SPP PICS for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  # - not yet implemented/supported
> @@ -80,11 +80,11 @@ TSPC_SPP_4_5	True (*)	Displayable text name (C.2)
>  TSPC_SPP_4_6	True (*)	BluetoothProfileDescriptorList (C.3)
>  ---------------------------------------------------------------------------
> ---- C.1: Mandatory for role B, if capability 'Support of Serial Profile
> Service' -	(SPP 2/1) supported. Irrelevant for role A.
> -C.2: Mandatory to support if 2/1 (Support of Serial Profile Service) AND
> 0/1 -	(SPP v1.1) are supported, otherwise Optional.
> -C.3: Mandatory to support if 2/1 (Support of Serial Profile Service) AND
> 0/2 -	(SPP v1.2) are supported, otherwise Optional.
> +	(TSPC_SPP_2_1) supported. Irrelevant for role A.
> +C.2: Mandatory to support if TSPC_SPP_2_1 AND TSPC_SPP_0_1 are supported,
> +	otherwise Optional.
> +C.3: Mandatory to support if TSPC_SPP_2_1 AND TSPC_SPP_0_2 are supported,
> +	otherwise Optional.
>  ---------------------------------------------------------------------------
> ----
> 
> 
> diff --git a/android/pixit-spp.txt b/android/pixit-spp.txt
> index 8e2d70f..4bd54d0 100644
> --- a/android/pixit-spp.txt
> +++ b/android/pixit-spp.txt
> @@ -1,6 +1,6 @@
>  SPP PIXIT for the PTS tool.
> 
> -PTS version: 6.0
> +PTS version: 6.1
> 
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-spp.txt b/android/pts-spp.txt
> index 2d2815b..b1c06a3 100644
> --- a/android/pts-spp.txt
> +++ b/android/pts-spp.txt
> @@ -1,8 +1,8 @@
>  PTS test results for SPP
> 
> -PTS version: 6.0
> -Tested: 29-January-2015
> -Android version: 5.0
> +PTS version: 6.1
> +Tested: 19-May-2015
> +Android version: 5.1
> 
>  Results:
>  PASS	test passed
> @@ -22,7 +22,6 @@ TC_DevB_APP_BV_02_C	PASS	haltest: socket listen
> BTSOCK_RFCOMM SerialPort TC_APP_BV_03_C		N/A	Missing in PTS
>  				PTS issue #12388
>  				Note: tests BV_03 : BV_6 currently not supported
> -				ETA: December 2014 (PTS 6.0)
>  TC_APP_BV_04_C		N/A	Missing in PTS
>  TC_APP_BV_05_C		N/A	Missing in PTS
>  TC_APP_BV_06_C		N/A	Missing in PTS

Since we don't track unimplemented tests from TS in other profiles, let's not 
do this here. So just remove tests that are not present in latest PTS from the 
list.

-- 
BR
Szymon Janc
