Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH 1/2] doc/device-api: Add AdvertisingDataFlags
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1476743233-26706-2-git-send-email-puthik@chromium.org>
Date: Tue, 18 Oct 2016 06:44:55 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <47A80E45-6212-44B8-9DB0-E4B00F38A25F@holtmann.org>
References: <1476743233-26706-1-git-send-email-puthik@chromium.org>
 <1476743233-26706-2-git-send-email-puthik@chromium.org>
To: puthik@chromium.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Puthikorn,

> This exposed AdvertisingDataFlags to BlueZ Device API
> 
> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
> ---
> doc/device-api.txt | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/doc/device-api.txt b/doc/device-api.txt
> index f5cac49..3ed4e06 100644
> --- a/doc/device-api.txt
> +++ b/doc/device-api.txt
> @@ -230,3 +230,7 @@ Properties	string Address [readonly]
> 
> 			Indicate whether or not service discovery has been
> 			resolved.
> +
> +		uint8 AdvertisingDataFlags [readonly]
> +
> +			The Advertising Data Flags of the remote device.

I prefer if we just call this AdvertisingFlags and strictly speaking this needs to be array{uint8}. The AD type is defined as variable length. It is not just an uint8. We could debate to go with uint32 here if that helps, but just a uint8 will lock us in and is not really future proof.

Regards

Marcel

