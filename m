Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] android/pts: Change MCAP PIXIT value
Date: Thu, 26 Jun 2014 18:08:43 +0200
Message-ID: <2014548.p2rArrRtES@uw000953>
In-Reply-To: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403788151-21025-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thursday 26 of June 2014 15:09:05 Jakub Tyszkowski wrote:
> Handling single data channel will simplify mcaptest tool.
> This can be changed later when mcaptest will be improved.
> ---
>  android/pixit-mcap.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
> index ee67a1a..81cc6dc 100644
> --- a/android/pixit-mcap.txt
> +++ b/android/pixit-mcap.txt
> @@ -11,7 +11,7 @@ Parameter Name						Value
>  -------------------------------------------------------------------------------
>  TSPX_bd_addr_iut					112233445566 (*&)
>  TSPX_delete_link_key					FALSE
> -TSPX_MCAP_DC_max					2
> +TSPX_MCAP_DC_max					1
>  TSPX_MCAP_l2cap_psm_control				1003
>  TSPX_MCAP_l2cap_psm_control_B
>  TSPX_MCAP_l2cap_psm_data				1005
> 

All patches applied (with some minor cleanups). Thanks.

-- 
Best regards, 
Szymon Janc
