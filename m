Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] android/pts: Interim PTS tests results for L2CAP
Date: Tue, 28 Oct 2014 12:37:17 +0100
Message-ID: <2573718.xsSlhbvHdt@leonov>
In-Reply-To: <1414165542-8527-1-git-send-email-sebastian.chlad@tieto.com>
References: <1414165542-8527-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Friday 24 of October 2014 17:45:42 Sebastian Chlad wrote:
> ---
>  android/pts-l2cap.txt | 60
> +++++++++++++++++++++++++++++++++++++-------------- 1 file changed, 44
> insertions(+), 16 deletions(-)
> 
> diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
> index 0746ea7..9706d69 100644
> --- a/android/pts-l2cap.txt
> +++ b/android/pts-l2cap.txt
> @@ -1,7 +1,7 @@
>  PTS test results for L2CAP
> 
> -PTS version: 5.2
> -Tested: 14-August-2014
> +PTS version: 5.3
> +Tested: 24-October-2014
>  Android version: 4.4.4
>  Kernel version: 3.18
> 
> @@ -15,28 +15,37 @@ N/A    test is disabled due to PICS setup
>  Test Name		Result	Notes
>  ---------------------------------------------------------------------------
> ---- TC_COS_CED_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
> -TC_COS_CED_BV_03_C	PASS	l2test -w -N 1 -P 4113
> -TC_COS_CED_BV_04_C	PASS	l2test -r -P 4113
> -TC_COS_CED_BV_05_C	PASS	l2test -r -P 4113
> -TC_COS_CED_BV_07_C	PASS	l2test -r -P 4113
> -TC_COS_CED_BV_08_C	PASS	l2test -r -P 4113
> +TC_COS_CED_BV_03_C	PASS	l2test -y -N 1 -P 4113 <bdaddr>
> +TC_COS_CED_BV_04_C	PASS	l2test -n -P 4113 <bdaddr>
> +TC_COS_CED_BV_05_C	PASS	PTS issue #12351
> +				btmgmt ssp off
> +				l2test -r -P 4113
> +TC_COS_CED_BV_07_C	PASS	l2test -n -P 4113 <bdaddr>
> +TC_COS_CED_BV_08_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_CED_BV_09_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_CED_BV_10_C	N/A
> -TC_COS_CED_BV_11_C	PASS	l2test -r -P 4113
> +TC_COS_CED_BV_11_C	PASS	l2test -u -P 4113 <bdaddr>
>  TC_COS_CED_BI_01_C	PASS
> -TC_COS_CFD_BV_01_C	PASS	l2test -r -P 4113
> -TC_COS_CFD_BV_02_C	PASS	l2test -r -P 4113
> -TC_COS_CFD_BV_03_C	PASS	l2test -r -P 4113
> +TC_COS_CFD_BV_01_C	PASS	PTS issue #12351
> +				btmgmt ssp off
> +				l2test -r -P 4113
> +TC_COS_CFD_BV_02_C	PASS	l2test -n -P 4113 <bdaddr>
> +TC_COS_CFD_BV_03_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_CFD_BV_08_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_CFD_BV_09_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_CFD_BV_10_C	N/A
> -TC_COS_CFD_BI_11_C	PASS	l2test -r -P 4113
> -TC_COS_CFD_BV_12_C	PASS	l2test -r -P 4113
> +TC_COS_CFD_BV_11_C	PASS	l2test -n -P 4113 <bdaddr>
> +TC_COS_CFD_BV_12_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_CFD_BV_13_C	N/A
>  TC_COS_IEX_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
>  TC_COS_IEX_BV_02_C	PASS
>  TC_COS_ECH_BV_01_C	PASS
>  TC_COS_ECH_BV_02_C	PASS	l2ping -c 1 <bdaddr>
> +TC_COS_CFC_BV_01_C	INC	JIRA #BA-181
> +TC_COS_CFC_BV_02_C	INC	JIRA #BA-181
> +TC_COS_CFC_BV_03_C	PASS	l2test -u -V le_public <bdaddr>
> +TC_COS_CFC_BV_04_C	PASS	l2test -u -V le_public <bdaddr>
> +TC_COS_CFC_BV_05_C	PASS	l2test -m -V le_public <bdaddr>
>  TC_CLS_CLR_BV_01_C	N/A
>  TC_CLS_UCD_BV_01_C	PASS
>  TC_CLS_UCD_BV_02_C	PASS	l2test -s -G -N 1 -P 4113 <bdaddr>
> @@ -75,10 +84,12 @@ TC_OFS_BV_01_C		PASS	l2test -x -X ertm -P 4113 
-F 0 -N 1
> TC_OFS_BV_02_C		PASS	l2test -r -X ertm -P 4113 -F 0
>  TC_OFS_BV_03_C		PASS	l2test -x -X streaming -P 4113 -F 0 -N 1
>  TC_OFS_BV_04_C		PASS	l2test -r -X streaming -P 4113 -F 0
> +				JIRA issue #BA-180
>  TC_OFS_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 1
>  TC_OFS_BV_06_C		PASS	l2test -r -X ertm -P 4113
>  TC_OFS_BV_07_C		PASS	l2test -x -X streaming -P 4113 -F 0 -N 1
>  TC_OFS_BV_08_C		PASS	l2test -r -X streaming -P 4113
> +				JIRA issue #BA-180
>  TC_ERM_BV_01_C		PASS	l2test -x -X ertm -P 4113 -N 3 -Y 3
>  TC_ERM_BV_02_C		PASS	l2test -r -X ertm -P 4113
>  TC_ERM_BV_03_C		PASS	l2test -r -X ertm -P 4113
> @@ -92,7 +103,7 @@ TC_ERM_BV_11_C		PASS	l2test -x -X ertm -P 4113 -N 1 
-Q 1
>  TC_ERM_BV_12_C		PASS	l2test -x -X ertm -P 4113 -R -N 1 -Q 1
>  TC_ERM_BV_13_C		PASS	l2test -x -X ertm -P 4113 -N 2
>  TC_ERM_BV_14_C		PASS	l2test -x -X ertm -P 4113 -N 4
> -TC_ERM_BV_15_C		PASS	l2test -X ertm -P 4113 -N 4
> +TC_ERM_BV_15_C		PASS	l2test -x -X ertm -P 4113 -N 4
>  TC_ERM_BV_16_C		N/A
>  TC_ERM_BV_17_C		PASS	l2test -X ertm -P 4113
>  TC_ERM_BV_18_C		PASS	l2test -x -X ertm -P 4113 -N 1
> @@ -147,6 +158,23 @@ TC_ECF_BV_08_C		N/A
>  TC_LE_CPU_BV_01_C	PASS	l2test -r -V le_public -J 4
>  TC_LE_CPU_BV_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
>  TC_LE_CPU_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
> -TC_LE_CPU_BI_02_C	INC	PTS issue #12339
> +TC_LE_CPU_BI_02_C	PASS	PTS issue #12339
> +				Note: use Common.dll and ETS for L2CAP
> +				from #12339
>  				l2test -r -V le_public -J 4
> -TC_LE_REJ_BV_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
> +TC_LE_REJ_BI_01_C	PASS	l2test -n -V le_public -J 4 <braddr>
> +TC_LE_REJ_BI_02_C	PASS	l2test -n -V le_public -J 4 <braddr>
> +TC_LE_CFC_BV_01_C	PASS	l2test -n -V le_public -P 37 <braddr>
> +TC_LE_CFC_BV_02_C	PASS	l2test -n -V le_public -P 37 <braddr>
> +TC_LE_CFC_BV_03_C	INC	PTS issue #12665
> +TC_LE_CFC_BV_04_C	PASS	l2test -n -V le_public -P 241  <braddr>
> +TC_LE_CFC_BV_05_C	INC	PTS issue #12665
> +TC_LE_CFC_BV_06_C	INC	JIRA #BA-182
> +TC_LE_CFC_BV_07_C	INC	JIRA #BA-183
> +TC_LE_CFC_BI_01_C	INC	JIRA #BA-183
> +TC_LE_CFC_BV_08_C	PASS	l2test -n -V le_public -P 37 <braddr>
> +TC_LE_CFC_BV_09_C	PASS	l2test -n -V le_public -P 37 <braddr>
> +TC_LE_CFC_BV_16_C	PASS	l2test -n -V le_public -P 37 <braddr>
> +TC_LE_CFC_BV_17_C	N/A
> +TC_LE_CID_BV_01_C	INC
> +TC_LE_CID_BV_02_I	INC

Applied. Thanks.

-- 
BR
Szymon Janc
