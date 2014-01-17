Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] android/pts: Add PTS test results document for A2DP
Date: Fri, 17 Jan 2014 21:31:58 +0100
Message-ID: <1546310.WH0JHHFMur@athlon>
In-Reply-To: <1389866462-7993-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389866462-7993-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 16 January 2014 11:01:00 Jakub Tyszkowski wrote:
> This will allow for better tracking of current state of implementation.
> ---
>  android/Makefile.am  |  2 ++
>  android/pts-a2dp.txt | 57
> ++++++++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 59
> insertions(+)
>  create mode 100644 android/pts-a2dp.txt
> 
> diff --git a/android/Makefile.am b/android/Makefile.am
> index cd4a526..0ce0188 100644
> --- a/android/Makefile.am
> +++ b/android/Makefile.am
> @@ -148,4 +148,6 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt
> android/README \ android/pics-avrcp.txt android/pixit-avrcp.txt \
>  		android/pics-a2dp.txt android/pixit-a2dp.txt \
>  		android/pics-avctp.txt android/pixit-avctp.txt \
> +		android/pts-a2dp.txt \
> +

This extra empty line is not needed.

>  		android/pts-l2cap.txt
> diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
> new file mode 100644
> index 0000000..a269ec1
> --- /dev/null
> +++ b/android/pts-a2dp.txt
> @@ -0,0 +1,57 @@
> +PTS test results for A2DP
> +
> +PTS version: 5.0
> +Tested: --not yet tested--
> +
> +Results:
> +PASS	test passed
> +FAIL	test failed
> +INC	test is inconclusive
> +N/A	test is disabled due to PICS setup
> +
> +		Source (SRC)
> +---------------------------------------------------------------------------
> ---- +Test Name		Result	Notes
> +---------------------------------------------------------------------------
> ---- +TC_SRC_CC_BV_09_I	INC
> +TC_SRC_CC_BV_10_I	N/A
> +TC_SRC_REL_BV_01_I	INC
> +TC_SRC_REL_BV_02_I	INC
> +TC_SRC_SET_BV_01_I	INC
> +TC_SRC_SET_BV_02_I	INC
> +TC_SRC_SET_BV_03_I	INC
> +TC_SRC_SET_BV_04_I	INC
> +TC_SRC_SET_BV_05_I	INC
> +TC_SRC_SET_BV_06_I	INC
> +TC_SRC_SUS_BV_01_I	INC
> +TC_SRC_SUS_BV_02_I	INC
> +TC_SRC_SDP_BV_01_I	INC
> +TC_SRC_AS_BV_01_I	INC
> +---------------------------------------------------------------------------
> ---- +
> +
> +		Sink (SNK)
> +---------------------------------------------------------------------------
> ---- +Test Name		Result	Notes
> +---------------------------------------------------------------------------
> ---- +TC_SNK_CC_BV_01_I	N/A
> +TC_SNK_CC_BV_02_I	N/A
> +TC_SNK_CC_BV_03_I	N/A
> +TC_SNK_CC_BV_04_I	N/A
> +TC_SNK_CC_BV_05_I	N/A
> +TC_SNK_CC_BV_06_I	N/A
> +TC_SNK_CC_BV_07_I	N/A
> +TC_SNK_CC_BV_08_I	N/A
> +TC_SNK_REL_BV_01_I	N/A
> +TC_SNK_REL_BV_02_I	N/A
> +TC_SNK_SET_BV_01_I	N/A
> +TC_SNK_SET_BV_02_I	N/A
> +TC_SNK_SET_BV_03_I	N/A
> +TC_SNK_SET_BV_04_I	N/A
> +TC_SNK_SET_BV_05_I	N/A
> +TC_SNK_SET_BV_06_I	N/A
> +TC_SNK_SUS_BV_01_I	N/A
> +TC_SNK_SUS_BV_02_I	N/A
> +TC_SNK_SDP_BV_02_I	N/A
> +TC_SNK_AS_BV_01_I	N/A
> +---------------------------------------------------------------------------
> ----

-- 
Szymon K. Janc
szymon.janc@gmail.com
