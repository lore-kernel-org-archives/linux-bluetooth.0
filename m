Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/pts: Update GATT PTS results
Date: Wed, 28 May 2014 11:39:20 +0200
Message-ID: <5699609.HsHMzrXfEx@uw000953>
In-Reply-To: <1401269655-27595-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401269655-27595-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 28 of May 2014 11:34:15 Jakub Tyszkowski wrote:
> ---
>  android/pts-gatt.txt | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
> index 57c99dc..60968e2 100644
> --- a/android/pts-gatt.txt
> +++ b/android/pts-gatt.txt
> @@ -159,9 +159,24 @@ TC_GAR_SR_BI_06_C	PASS	haltest:
>  				gatts start_service
>  TC_GAR_SR_BI_07_C	PASS
>  TC_GAR_SR_BI_08_C	PASS
> -TC_GAR_SR_BI_09_C	INC
> -TC_GAR_SR_BI_10_C	INC
> -TC_GAR_SR_BI_11_C	INC
> +TC_GAR_SR_BI_09_C	PASS	haltest:
> +				gatts add_service
> +				gatts add_chaaracteristic:
> +						<properties> 2 <permissions> 1
> +				gatts start_service
> +				gatts send_response: <status> 8
> +TC_GAR_SR_BI_10_C	PASS	haltest:
> +				gatts add_service
> +				gatts add_chaaracteristic:
> +						<properties> 2 <permissions> 1
> +				gatts start_service
> +				gatts send_response: <status> 5
> +TC_GAR_SR_BI_11_C	PASS	haltest:
> +				gatts add_service
> +				gatts add_chaaracteristic:
> +						<properties> 2 <permissions> 1
> +				gatts start_service
> +				gatts send_response: <status> 12
>  TC_GAR_SR_BV_04_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_chaaracteristic:
> @@ -265,7 +280,13 @@ TC_GAR_SR_BV_07_C	PASS	haltest:
>  				gatts send_response:
>  						<data> value greater than MTU
>  						repeat with correct offset
> -TC_GAR_SR_BV_08_C	INC
> +TC_GAR_SR_BV_08_C	PASS	haltest:
> +				gatts add_service
> +				gatts add_chaaracteristic:
> +						<properties> 2 <permissions> 1
> +				gatts add_descriptor: <permissions> 1
> +				gatts start_service
> +				gatts send_response: repeat with correct offset
>  TC_GAR_SR_BI_28_C	PASS	haltest:
>  				gatts add_service
>  				gatts add_chaaracteristic:
> 

Applied. Thanks.

-- 
Best regards, 
Szymon Janc
