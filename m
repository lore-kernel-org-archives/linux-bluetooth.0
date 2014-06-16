Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: Fix bit numbering in mgmt-api
Date: Mon, 16 Jun 2014 12:41:47 +0200
Message-ID: <3441889.Jpmp4xIXLo@uw000953>
In-Reply-To: <1400073481-7099-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400073481-7099-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Wednesday 14 of May 2014 15:18:00 Andrzej Kaczmarek wrote:
> ---
>  doc/mgmt-api.txt | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cd5cd24..9374f9d 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -214,20 +214,20 @@ Read Controller Information Command
>  	Current_Settings & Supported_Settings is a bitmask with
>  	currently the following available bits:
>  
> -		1	Powered
> -		2	Connectable
> -		3	Fast Connectable
> -		4	Discoverable
> -		5	Pairable
> -		6	Link Level Security (Sec. mode 3)
> -		7	Secure Simple Pairing
> -		8	Basic Rate/Enhanced Data Rate
> -		9	High Speed
> -		10	Low Energy
> -		11	Advertising
> -		12	Secure Connections
> -		13	Debug Keys
> -		14	Privacy
> +		0	Powered
> +		1	Connectable
> +		2	Fast Connectable
> +		3	Discoverable
> +		4	Pairable
> +		5	Link Level Security (Sec. mode 3)
> +		6	Secure Simple Pairing
> +		7	Basic Rate/Enhanced Data Rate
> +		8	High Speed
> +		9	Low Energy
> +		10	Advertising
> +		11	Secure Connections
> +		12	Debug Keys
> +		13	Privacy
>  
>  	This command generates a Command Complete event on success or
>  	a Command Status event on failure.
> @@ -1270,9 +1270,9 @@ Start Discovery Command
>  	Possible values for the Address_Type parameter are a bit-wise or
>  	of the following bits:
>  
> -		1	BR/EDR
> -		2	LE Public
> -		3	LE Random
> +		0	BR/EDR
> +		1	LE Public
> +		2	LE Random
>  
>  	By combining these e.g. the following values are possible:
>  
> 

This patch is now applied, thanks.

-- 
Best regards, 
Szymon Janc
