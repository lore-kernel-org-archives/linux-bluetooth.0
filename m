Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pixit: correct PIXIT value
Date: Fri, 21 Feb 2014 11:44:07 +0100
Message-ID: <2149527.GhYszomYke@uw000953>
In-Reply-To: <1392818658-18623-1-git-send-email-sebastian.chlad@tieto.com>
References: <1392818658-18623-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 19 of February 2014 15:04:18 Sebastian Chlad wrote:
> It is important for NAP role to set proper PTS btaddr in PIXIT
> ---
>  android/pixit-pan.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
> index 6544a9c..21434fb 100644
> --- a/android/pixit-pan.txt
> +++ b/android/pixit-pan.txt
> @@ -3,7 +3,7 @@ PAN PIXIT for the PTS tool.
>  PTS version: 5.0
>  
>  * - different than PTS defaults
> -& - should be set to IUT Bluetooth address
> +& - should be set to IUT or PTS Bluetooth address respectively
>  
>  		Required PIXIT settings
>  -------------------------------------------------------------------------------
> @@ -22,7 +22,7 @@ TSPX_iut_ip_address					192.168.167.152
>  TSPX_iut_port_number					4242
>  TSPX_PTS_ip_address					192.168.168.100
>  TSPX_PTS_port_number					4242
> -TSPX_bd_addr_PTS					000000000000
> +TSPX_bd_addr_PTS					112233445566 (*&)
>  TSPX_checksum						E851
>  TSPX_secure_simple_pairing_pass_key_confirmation	False
>  TSPX_iut_friendly_bt_name				gprs-pc
> 

Pushed, thanks.

-- 
Best regards, 
Szymon Janc
