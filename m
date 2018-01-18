Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC] adapter: Add CreateDevice method
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180111110423.14498-1-szymon.janc@codecoup.pl>
Date: Thu, 18 Jan 2018 10:40:04 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC7FA4A5-2523-4D7F-8C0C-4CD61EDFB6A5@holtmann.org>
References: <20180111110423.14498-1-szymon.janc@codecoup.pl>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> This allows to create Device1 object without discovery. This is needed for
> some of qualification tests where there is no general discovery upfront
> and we need to do connection to device with provided address.
> 
> Another usecase is for scenario where scanning happen on one controller but
> connection handling on another.
> 
> Implementation wide this results in new temporary device object being created
> that if unused will be cleanup just like it would be if found during discovery
> session.

so what are the rules around the cleanup? On next discovery it is gone again, then that might needs to be mentioned.

> 
> This patch implements bare minimum properties needed for connection - address
> and address type. If needed eg. for non-NFC based OOB it could be extended with
> more options.
> ---
> doc/adapter-api.txt | 29 ++++++++++++++++
> src/adapter.c       | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 125 insertions(+)
> 
> diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> index 0533b674a..c8f3ce26e 100644
> --- a/doc/adapter-api.txt
> +++ b/doc/adapter-api.txt
> @@ -145,6 +145,35 @@ Methods		void StartDiscovery()
> 
> 			Possible errors: None
> 
> +		void CreateDevice(dict properties) [experimental]
> +
> +			Creates new temporary device with defined properties.

Why is this not returning the device object path that gets created? Seems a waste time cycles to wait for a device showing up later.

> +
> +			Parameters that may be set in the filter dictionary
> +			include the following:
> +
> +			string Address
> +
> +				The Bluetooth device address of the remote
> +				device. This parameter is mandatory.
> +
> +			string AddressType
> +
> +				The Bluetooth device Address Type. This is
> +				address type that should be used for initial
> +				connection. If this parameter is not present
> +				BR/EDR device is created.
> +
> +				Possible values:
> +					"public" - Public address
> +					"random" - Random address
> +
> +			Possible errors: org.bluez.Error.InvalidArguments
> +					 org.bluez.Error.AlreadyExists
> +					 org.bluez.Error.NotSupported
> +					 org.bluez.Error.NotReady
> +					 org.bluez.Error.Failed
> +

Now what I wonder is that in case of LE, this should actually trigger a quick scan for that device so that you get advertising data and other information about the device. We are missing a kernel API for such a targeted case and that might need fixing as well.

In case of BR/EDR, this might should trigger a connection and SDP discovery.

Otherwise this is not an API and just a hack to create a device path object. So you are essentially just doing an “InjectDevice” instead of anything real.

That said, using a DiscoverDevice() method name might be more accurate.

Regards

Marcel

