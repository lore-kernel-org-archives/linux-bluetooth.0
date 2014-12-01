Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: PTS test for PAN on Android 5.0 and PTS 5.3
Date: Mon, 01 Dec 2014 14:46:35 +0100
Message-ID: <1843508.2xGbeAgoAB@uw000953>
In-Reply-To: <1417162385-17289-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417162385-17289-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Friday 28 of November 2014 09:13:05 Grzegorz Kolodziejczyk wrote:
> ---
>  android/pts-pan.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/android/pts-pan.txt b/android/pts-pan.txt
> index dac1dec..e95a82e 100644
> --- a/android/pts-pan.txt
> +++ b/android/pts-pan.txt
> @@ -1,8 +1,8 @@
>  PTS test results for PAN
>  
>  PTS version: 5.3
> -Tested: 17-October-2014
> -Android version: 4.4.4
> +Tested: 17-November-2014
> +Android version: 5.0
>  
>  Results:
>  PASS	test passed
> @@ -54,7 +54,7 @@ TC_BNEP_PANU_BROADCAST_0_BV_04_C	N/A
>  TC_PANU_Ipv4_Autonet_BV_01_I		PASS	After DHCP request fail send
>  						DHCP address request.
>  						From IUT: send address request
> -						dhcpd -r 169.254.x.x bt-pan
> +						dhcpcd -r 169.254.x.x bt-pan
>  TC_PANU_Ipv6_Autonet_BV_02_I		N/A
>  TC_PANU_IP_LLMNR_BV_01_I		N/A	SE #3558, TSE #4382, TCW #448
>  TC_PANU_IP_LLMNR_BV_02_I		N/A
> 

Applied, thanks.

-- 
Best regards, 
Szymon Janc
