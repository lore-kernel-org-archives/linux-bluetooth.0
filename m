Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Sebastian Chlad <sebastian.chlad@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/pixit: Set phone number type
Date: Thu, 13 Mar 2014 15:24:59 +0100
Message-ID: <2145617.JKP1Tthn4Q@uw000953>
In-Reply-To: <1394629949-13166-1-git-send-email-sebastian.chlad@tieto.com>
References: <1394629949-13166-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sebastian,

On Wednesday 12 of March 2014 14:12:28 Sebastian Chlad wrote:
> Phone number type should be set accordingly.
> ---
>  android/pixit-hfp.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
> index 3b04cbe..f539e07 100644
> --- a/android/pixit-hfp.txt
> +++ b/android/pixit-hfp.txt
> @@ -5,6 +5,7 @@ PTS version: 5.0
>  * - different than PTS defaults
>  & - should be set to IUT Bluetooth address
>  # - should be set to the respective phone numbers
> +^ - should be set according to the reported phone number's type
>  
>  		Required PIXIT settings
>  -------------------------------------------------------------------------------
> @@ -17,8 +18,8 @@ TSPX_ag_class_of_device					400204
>  TSPX_packet_type_sco					00A0
>  TSPX_phone_number					1234567 (#)
>  TSPX_second_phone_number				7654321 (#)
> -TSPX_phone_number_type					129
> -TSPX_second_phone_number_type				129
> +TSPX_phone_number_type					145 (*^)
> +TSPX_second_phone_number_type				145 (*^)
>  TSPX_phone_number_memory				1
>  TSPX_phone_number_memory_invalid_index			9999
>  TSPX_scan_all_memory_dial_locations			FALSE
> 

both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
