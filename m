Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: GAP PTS test results for Android 5.0
Date: Mon, 08 Dec 2014 14:06:28 +0100
Message-ID: <1752340.zfeeGKvYfF@leonov>
In-Reply-To: <1417787354-6603-1-git-send-email-sebastian.chlad@tieto.com>
References: <1417787354-6603-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 05 of December 2014 14:49:14 Sebastian Chlad wrote:
> ---
>  android/pts-gap.txt | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/android/pts-gap.txt b/android/pts-gap.txt
> index 99a6a7d..c597258 100644
> --- a/android/pts-gap.txt
> +++ b/android/pts-gap.txt
> @@ -1,8 +1,8 @@
>  PTS test results for GAP
> 
>  PTS version: 5.3
> -Tested: 28-October-2014
> -Android version: 4.4.4
> +Tested: 05-December-2014
> +Android version: 5.0
>  Kernel version: 3.18
> 
>  Results:
> @@ -94,7 +94,7 @@ TC_IDLE_NAMP_BV_01_C	PASS	possible to PASS using 
haltest
> following steps: gattc - register client, connect to PTS, search
>  				all services, get characteristic and then read
>  				characteristic (name)
> -TC_IDLE_NAMP_BV_02_C	INC	PTS issue #12679
> +TC_IDLE_NAMP_BV_02_C	PASS	PTS issue #12679
>  				haltest: gatts connect
>  TC_CONN_NCON_BV_01_C	PASS	btmgmt connectable off
>  				btmgmt advertising on
> @@ -174,8 +174,7 @@ TC_BOND_BON_BV_01_C	PASS	PTS issue #12503
>  				To bond with PTS execute
>  				btmgmt pair -t 0x01 -c 0x03 <PTS addr>
>  TC_BOND_BON_BV_02_C	PASS
> -TC_BOND_BON_BV_03_C	INC	PTS issue #12678
> -				Note: tiny chance to pass if PTS won't crash
> +TC_BOND_BON_BV_03_C	PASS	PTS issue #12678
>  				gattc register_client
>  				gattc listen 1
>  TC_BOND_BON_BV_04_C	PASS	haltest: gattc_register_client
> @@ -338,7 +337,11 @@ TC_PRIV_CONN_BV_06_C	N/A
>  TC_PRIV_CONN_BV_07_C	N/A
>  TC_PRIV_CONN_BV_08_C	N/A
>  TC_PRIV_CONN_BV_09_C	N/A
> -TC_PRIV_CONN_BV_10_C	INC	PTS issue #12312
> +TC_PRIV_CONN_BV_10_C	PASS	PTS issue #12312
> +				Note: currently for this test following PIXITs
> +				are required to be be changed:
> +				TSPX_using_public_device_address: FALSE
> +				TSPX_using_random_device_address: TRUE
>  TC_PRIV_CONN_BV_11_C	INC	PTS issue #12310, JIRA #BA-186
>  TC_ADV_BV_01_C		N/A
>  TC_ADV_BV_02_C		PASS	gattc register_client

Applied, thanks.

-- 
BR
Szymon Janc
