Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS test results for OPP
Date: Thu, 30 Jan 2014 17:28:29 +0100
Message-ID: <1527546.Ru8CWtTvf4@leonov>
In-Reply-To: <1390931987-10904-1-git-send-email-sebastianx.chlad@intel.com>
References: <1390931987-10904-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 28 of January 2014 19:59:47 Sebastian Chlad wrote:
> ---
>  android/pts-opp.txt | 37 ++++++++++++++++++++-----------------
>  1 file changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/android/pts-opp.txt b/android/pts-opp.txt
> index b9329b9..3c4ab47 100644
> --- a/android/pts-opp.txt
> +++ b/android/pts-opp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for OPP
> 
> -PTS version: 4.9
> -Tested: 14.11.2013
> +PTS version: 5.0
> +Tested: 28.01.2014
> 
>  Results:
>  PASS	test passed
> @@ -14,9 +14,9 @@ Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_CLIENT_OPH_BV_01_I	PASS
>  TC_CLIENT_OPH_BV_02_I	N/A
> -TC_CLIENT_OPH_BV_03_I	PASS
> +TC_CLIENT_OPH_BV_03_I	PASS	Tester must send a contact to PTS
>  TC_CLIENT_OPH_BV_04_I	N/A
> -TC_CLIENT_OPH_BV_05_I	PASS
> +TC_CLIENT_OPH_BV_05_I	PASS	Tester must send a contact to PTS
>  TC_CLIENT_OPH_BV_07_I	N/A
>  TC_CLIENT_OPH_BV_08_I	N/A
>  TC_CLIENT_OPH_BV_09_I	N/A
> @@ -49,33 +49,36 @@ TC_CLIENT_BCE_BV_04_I	N/A
>  TC_CLIENT_BCE_BV_05_I	N/A
>  TC_CLIENT_BCE_BV_06_I	N/A
>  TC_CLIENT_BCE_BV_07_I	N/A
> -TC_SERVER_OPH_BV_01_I	PASS
> -TC_SERVER_OPH_BV_02_I	PASS
> -TC_SERVER_OPH_BV_03_I	PASS
> -TC_SERVER_OPH_BV_04_I	PASS
> -TC_SERVER_OPH_BV_05_I	PASS
> +TC_SERVER_OPH_BV_01_I	PASS	IUT must be in the connectable mode
> +TC_SERVER_OPH_BV_02_I	PASS	IUT must be in the connectable mode
> +TC_SERVER_OPH_BV_03_I	PASS	IUT must be in the connectable mode. Tester 
must
> +					accept incoming file
> +TC_SERVER_OPH_BV_04_I	PASS	IUT must be in the connectable mode. Tester 
must
> +					accept incoming file
> +TC_SERVER_OPH_BV_05_I	PASS	IUT must be in the connectable mode. Tester 
must
> +					reject incoming file
>  TC_SERVER_OPH_BV_07_I	N/A
>  TC_SERVER_OPH_BV_08_I	N/A
>  TC_SERVER_OPH_BV_09_I	N/A
> -TC_SERVER_OPH_BV_10_I	PASS
> +TC_SERVER_OPH_BV_10_I	PASS	IUT must be in the connectable mode
>  TC_SERVER_OPH_BV_11_I	N/A
>  TC_SERVER_OPH_BV_12_I	N/A
>  TC_SERVER_OPH_BV_13_I	N/A
> -TC_SERVER_OPH_BV_14_I	PASS
> +TC_SERVER_OPH_BV_14_I	PASS	IUT must be in the connectable mode
>  TC_SERVER_OPH_BV_15_I	N/A
>  TC_SERVER_OPH_BV_16_I	N/A
>  TC_SERVER_OPH_BV_17_I	N/A
> -TC_SERVER_OPH_BV_18_I	PASS
> -TC_SERVER_OPH_BV_19_I	PASS
> +TC_SERVER_OPH_BV_18_I	PASS	IUT must be in the connectable mode
> +TC_SERVER_OPH_BV_19_I	PASS	IUT must be in the connectable mode
>  TC_SERVER_OPH_BV_21_I	N/A
> -TC_SERVER_OPH_BV_22_I	PASS
> -TC_SERVER_OPH_BV_23_I	PASS
> +TC_SERVER_OPH_BV_22_I	PASS	IUT must be in the connectable mode
> +TC_SERVER_OPH_BV_23_I	PASS	IUT must be in the connectable mode
>  TC_SERVER_OPH_BV_24_I	N/A
>  TC_SERVER_OPH_BV_25_I	N/A
>  TC_SERVER_OPH_BV_26_I	N/A
> -TC_SERVER_OPH_BV_34_I	PASS
> +TC_SERVER_OPH_BV_34_I	PASS	IUT must be in the connectable mode
>  TC_SERVER_BCP_BV_01_I	N/A
> -TC_SERVER_BCP_BV_02_I	PASS
> +TC_SERVER_BCP_BV_02_I	PASS	IUT must be in the connectable mode
>  TC_SERVER_BCP_BV_03_I	N/A
>  TC_SERVER_BCP_BV_04_I	N/A
>  TC_SERVER_BCP_BV_05_I	N/A

Applied, thanks.

-- 
BR
Szymon Janc
