Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [RFC 2/7] doc/device-api: Add AdvertisingData property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180418110502.13099-2-luiz.dentz@gmail.com>
Date: Wed, 18 Apr 2018 16:19:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B738AD8F-D0DA-4BFE-ADE9-9AEE08437D59@holtmann.org>
References: <20180418110502.13099-1-luiz.dentz@gmail.com>
 <20180418110502.13099-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> This adds AdvertisingData which exposes data being advertised which is
> may be useful for profiles not handled by bluetoothd.
> ---
> doc/device-api.txt | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index 1b448eef1..f2f8464bc 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -251,3 +251,8 @@ Properties	string Address [readonly]
> 		array{byte} AdvertisingFlags [readonly, experimental]
> 
> 			The Advertising Data Flags of the remote device.
> +
> +		dict AdvertisingData [readonly, experimental]
> +
> +			The Advertising Data of the remote device. Keys are
> +			are 8 bits AD Type followed by data as byte array.

this somehow needs to be explained on how a dict like that would look like. And also which AD types are _not_ valid here. Or at least not valid in conjunction with using other properties.

Regards

Marcel

