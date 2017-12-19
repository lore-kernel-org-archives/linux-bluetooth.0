Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Add AddressType property for Adapter1 and Device1 interfaces
Date: Tue, 19 Dec 2017 13:00:39 +0100
Message-ID: <1898759.IM56CrD3XN@ix>
In-Reply-To: <20171213135110.27167-1-szymon.janc@codecoup.pl>
References: <20171213135110.27167-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday, 13 December 2017 14:51:07 CET Szymon Janc wrote:
> This provides information about address type being used.  It is needed
> for L2CAP sockets and PTS testing purposes.
> ---
>  doc/adapter-api.txt | 12 ++++++++++++
>  doc/device-api.txt  | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index d852aa6b9..0533b674a 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -149,6 +149,18 @@ Properties	string Address [readonly]
> 
>  			The Bluetooth device address.
> 
> +		string AddressType [readonly]
> +
> +			The Bluetooth  Address Type. For dual-mode and BR/EDR
> +			only adapter this defaults to "public". Single mode LE
> +			adapters may have either value. With privacy enabled
> +			this contains type of Identity Address and not type of
> +			address used for connection.
> +
> +			Possible values:
> +				"public" - Public address
> +				"random" - Random address
> +
>  		string Name [readonly]
> 
>  			The Bluetooth system name (pretty hostname).
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 8b69c2ef3..1b448eef1 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -124,6 +124,19 @@ Properties	string Address [readonly]
> 
>  			The Bluetooth device address of the remote device.
> 
> +		string AddressType [readonly]
> +
> +			The Bluetooth device Address Type. For dual-mode and
> +			BR/EDR only devices this defaults to "public". Single
> +			mode LE devices may have either value. If remote device
> +			uses privacy than before pairing this represents address
> +			type used for connection and Identity Address after
> +			pairing.
> +
> +			Possible values:
> +				"public" - Public address
> +				"random" - Random address
> +
>  		string Name [readonly, optional]
> 
>  			The Bluetooth remote name. This value can not be

Applied.

-- 
pozdrawiam
Szymon Janc
