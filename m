Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [RFC 1/4] Add LEAddressType property for Adapter1 and Device1
 interfaces
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171211103837.25150-1-szymon.janc@codecoup.pl>
Date: Wed, 13 Dec 2017 09:47:07 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <76FA8EB0-63F0-45E2-BE1A-DCC06DA1C7ED@holtmann.org>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This provides information about LE Identity Address Type used. This
> information is needed for L2CAP sockets and for PTS testing purposes.
> ---
> doc/adapter-api.txt | 9 +++++++++
> doc/device-api.txt  | 9 +++++++++
> 2 files changed, 18 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index d852aa6b9..b5abdda39 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -149,6 +149,15 @@ Properties	string Address [readonly]
> 
> 			The Bluetooth device address.
> 
> +		string LEAddressType [readonly, optional]
> +
> +			The Bluetooth device LE Identity Address Type. This is
> +			present only if LE is supported by adapter.
> +
> +			Possible values:
> +				"public" - Public address
> +				"static" - Static Random address
> +

actually just call this AddressType and have it default to public for dual-mode and BR/EDR controllers. In case of single-mode LE controller that really uses a static address name it “random”. The static part will be in the address itself.

> 		string Name [readonly]
> 
> 			The Bluetooth system name (pretty hostname).
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 8b69c2ef3..dfeca305c 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -124,6 +124,15 @@ Properties	string Address [readonly]
> 
> 			The Bluetooth device address of the remote device.
> 
> +		string LEAddressType [readonly, optional]
> +
> +			The Bluetooth device LE Identity Address Type. This is
> +			present only if device supports LE.
> +
> +			Possible values:
> +				"public" - Public address
> +				"static" - Static Random address
> +

And this is the same as above.

Regards

Marcel

