Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastianx.chlad@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update PICS and PTS for AVCTP
Date: Wed, 05 Feb 2014 10:55:38 +0100
Message-ID: <7444676.oQVWzMdvAq@uw000953>
In-Reply-To: <1391505632-5306-1-git-send-email-sebastianx.chlad@intel.com>
References: <1391505632-5306-1-git-send-email-sebastianx.chlad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Tuesday 04 of February 2014 11:20:32 Sebastian Chlad wrote:
> Since we do not support AVCTP fragmentation for now we shell set PICS
> settings for AVCTP accordingly as well as set respective PTS test cases
> as N/A
> ---
>  android/pics-avctp.txt | 2 +-
>  android/pts-avctp.txt  | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
> index 939ffdb..269bf08 100644
> --- a/android/pics-avctp.txt
> +++ b/android/pics-avctp.txt
> @@ -58,7 +58,7 @@ TSPC_AVCTP_2_14	False		Support for multiple AVCTP channel establishment
>  -------------------------------------------------------------------------------
>  Parameter Name	Selected	Description
>  -------------------------------------------------------------------------------
> -TSPC_AVCTP_3_1	True (*)	Message fragmentation (O)
> +TSPC_AVCTP_3_1	False		Message fragmentation (O)
>  TSPC_AVCTP_3_2	True		Transaction label management (M)
>  TSPC_AVCTP_3_3	True		Packet type field management (M)
>  TSPC_AVCTP_3_4	True		Message type field management (M)
> diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
> index 4090ec0..72a6373 100644
> --- a/android/pts-avctp.txt
> +++ b/android/pts-avctp.txt
> @@ -37,6 +37,6 @@ TC_TG_CCM_BV_04_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
>  TC_TG_NFR_BV_02_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
>  TC_TG_NFR_BV_03_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
>  TC_TG_NFR_BI_01_C	PASS
> -TC_TG_FRA_BV_02_C	FAIL
> -TC_TG_FRA_BV_03_C	INC
> +TC_TG_FRA_BV_02_C	N/A	Fragmentation not supported
> +TC_TG_FRA_BV_03_C	N/A	Fragmentation not supported
>  -------------------------------------------------------------------------------
> 

Pushed, thanks.

-- 
Best regards, 
Szymon Janc
