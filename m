Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update AVCTP pixits, pics and test results for PTS 6.0
Date: Wed, 11 Feb 2015 15:44:46 +0100
Message-ID: <25888386.pCYphTH2in@uw000953>
In-Reply-To: <1423663924-3981-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1423663924-3981-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wednesday 11 of February 2015 15:12:04 Grzegorz Kolodziejczyk wrote:
> This patch updates tet pixits, pics, test results and their instructions
> for AVCTP profile against android 5.0.
> 
> PTS uses AVCTP ETS in version: 9.0.0.11
> ---
>  android/pics-avctp.txt  | 2 +-
>  android/pixit-avctp.txt | 2 +-
>  android/pts-avctp.txt   | 5 +++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pics-avctp.txt b/android/pics-avctp.txt
> index 0afa33c..4fc599f 100644
> --- a/android/pics-avctp.txt
> +++ b/android/pics-avctp.txt
> @@ -1,6 +1,6 @@
>  AVCTP PICS for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  # - not yet implemented/supported
> diff --git a/android/pixit-avctp.txt b/android/pixit-avctp.txt
> index f380e96..4b2c783 100644
> --- a/android/pixit-avctp.txt
> +++ b/android/pixit-avctp.txt
> @@ -1,6 +1,6 @@
>  AVCTP PIXIT for the PTS tool.
>  
> -PTS version: 5.3
> +PTS version: 6.0
>  
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
> diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
> index 7a5f4ce..d05aa05 100644
> --- a/android/pts-avctp.txt
> +++ b/android/pts-avctp.txt
> @@ -1,7 +1,7 @@
>  PTS test results for AVCTP
>  
> -PTS version: 5.3
> -Tested: 03-December-2014
> +PTS version: 6.0
> +Tested: 11-February-2015
>  Android version: 5.0
>  
>  Results:
> @@ -21,6 +21,7 @@ TC_CT_CCM_BV_04_C	N/A
>  TC_CT_CCM_BI_01_C	N/A
>  TC_CT_NFR_BV_01_C	N/A
>  TC_CT_NFR_BV_04_C	PASS	haltest: rc set_volume 5
> +				Note: IUT must be connectable and discoverable
>  TC_CT_FRA_BV_01_C	N/A
>  TC_CT_FRA_BV_04_C	N/A
>  -------------------------------------------------------------------------------
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
