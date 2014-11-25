Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: L2CAP pts tests results on Android 5.0
Date: Tue, 25 Nov 2014 22:00:40 +0100
Message-ID: <1486688.GLIPfB8mFQ@athlon>
In-Reply-To: <1416925715-9209-1-git-send-email-sebastian.chlad@tieto.com>
References: <1416925715-9209-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI Sebastian,

On Tuesday 25 November 2014 15:28:35 Sebastian Chlad wrote:
> ---
>  android/pts-l2cap.txt | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
> index 9cd2875..f46bbbd 100644
> --- a/android/pts-l2cap.txt
> +++ b/android/pts-l2cap.txt
> @@ -1,8 +1,8 @@
>  PTS test results for L2CAP
> 
>  PTS version: 5.3
> -Tested: 24-October-2014
> -Android version: 4.4.4
> +Tested: 25-November-2014
> +Android version: 5.0
>  Kernel version: 3.18
> 
>  Results:
> @@ -41,10 +41,12 @@ TC_COS_IEX_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_IEX_BV_02_C	PASS
>  TC_COS_ECH_BV_01_C	PASS
>  TC_COS_ECH_BV_02_C	PASS	l2ping -c 1 <bdaddr>
> -TC_COS_CFC_BV_01_C	INC	PTS issue #12728
> -				l2test -y -N 1 -b 40 -V le_public <braddr>
> -TC_COS_CFC_BV_02_C	INC	PTS issue #12728
> -				l2test -y -N 1 -b 1 -V le_public <bdaddr>
> +TC_COS_CFC_BV_01_C	PASS	l2test -y -N 1 -b 40 -V le_public <braddr>
> +				Note: use Common.dll and ETS for L2CAP
> +				from #12712

Please keep "PTS issue #XXXXX" in same line as test name. (this makes 
scripting easier)

Also please keep original errata number (even if it was pointed to test with 
ETS from other report).


> +TC_COS_CFC_BV_02_C	PASS	l2test -y -N 1 -b 1 -V le_public <bdaddr>
> +				Note: use Common.dll and ETS for L2CAP
> +				from #12712
>  TC_COS_CFC_BV_03_C	PASS	l2test -u -V le_public <bdaddr>
>  TC_COS_CFC_BV_04_C	PASS	l2test -u -V le_public <bdaddr>
>  TC_COS_CFC_BV_05_C	PASS	l2test -m -V le_public <bdaddr>
> @@ -95,8 +97,7 @@ TC_ERM_BV_02_C		PASS	l2test -r -X ertm -P 4113
>  TC_ERM_BV_03_C		PASS	l2test -r -X ertm -P 4113
>  TC_ERM_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
>  TC_ERM_BV_06_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
> -TC_ERM_BV_07_C		INC	PTS issue #12690
> -				l2test -r -H 1000 -K 10000 -X ertm -P 4113
> +TC_ERM_BV_07_C		PASS	l2test -r -H 1000 -K 10000 -X ertm -P 4113
>  TC_ERM_BV_08_C		PASS	l2test -x -X ertm -P 4113 -N 1
>  TC_ERM_BV_09_C		PASS	l2test -X ertm -P 4113
>  TC_ERM_BV_10_C		PASS	l2test -x -X ertm -P 4113 -N 1
> @@ -111,8 +112,7 @@ TC_ERM_BV_18_C		PASS	l2test -x -X ertm -P 4113 
-N 1
>  TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P 4113 -N 1
>  TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P 4113 -N 1
>  TC_ERM_BV_21_C		PASS	l2test -x -X ertm -P 4113 -D 2000 -N 2
> -TC_ERM_BV_22_C		INC	PTS issue #12690
> -				l2test -r -H 1000 -K 5000 -X ertm -P 4113
> +TC_ERM_BV_22_C		PASS	l2test -r -H 1000 -K 5000 -X ertm -P 4113
>  TC_ERM_BV_23_C		PASS	l2test -x -X ertm -P 4113 -N 2
>  TC_ERM_BI_01_C		N/A
>  TC_ERM_BI_02_C		PASS	l2test -X ertm -P 4113
> @@ -173,10 +173,12 @@ TC_LE_CFC_BV_04_C	PASS	l2test -n -V le_public -P 
241 
> <braddr> TC_LE_CFC_BV_05_C	INC	PTS issue #12665
>  TC_LE_CFC_BV_06_C	INC	PTS issue #12711 #12729
>  				l2test -s -V le_public <braddr>
> -TC_LE_CFC_BV_07_C	INC	PTS issue #12728
> -				l2test -u -V le_public <braddr>
> -TC_LE_CFC_BI_01_C	INC	PTS issue #12728 #12712
> -				l2test -u -V le_public <bdaddr>
> +TC_LE_CFC_BV_07_C	PASS	l2test -u -V le_public <braddr>
> +				Note: use Common.dll and ETS for L2CAP
> +				from #12712
> +TC_LE_CFC_BI_01_C	PASS	l2test -u -V le_public <bdaddr>
> +				Note: use Common.dll and ETS for L2CAP
> +				from #12712
>  TC_LE_CFC_BV_08_C	PASS	l2test -n -V le_public -P 37 <braddr>
>  TC_LE_CFC_BV_09_C	PASS	l2test -n -V le_public -P 37 <braddr>
>  TC_LE_CFC_BV_16_C	PASS	l2test -n -V le_public -P 37 <braddr>

-- 
Szymon K. Janc
szymon.janc@gmail.com
