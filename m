Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] network-api: improve documentation
From: Marcel Holtmann <marcel@holtmann.org>
To: Paul Fertser <fercerpav@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200908110622.n7B6MsPa013874@home.pavel.comp>
References: <200908110622.n7B6MsPa013874@home.pavel.comp>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 15:04:27 -0700
Message-Id: <1250028267.30166.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paul,

> Information about ways of specifying uuids and about disconnect conditions.

it is UUIDs and not uuids.

> Signed-off-by: Paul Fertser <fercerpav@gmail.com>

We don't use Signed-off-by for BlueZ.

> ---
>  doc/network-api.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/doc/network-api.txt b/doc/network-api.txt
> index 7271193..d935863 100644
> --- a/doc/network-api.txt
> +++ b/doc/network-api.txt
> @@ -17,6 +17,14 @@ Methods		string Connect(string uuid)
>  			device name. Examples of the device name are bnep0,
>  			bnep1 etc.
>  
> +			uuid can be either one of "gn"/"panu"/"nap" (case
> +			insensitive) or traditional string representation
> +			of uuid or a hexadecimal number.

Write it UUID. And use "gn", "panu" or "nap".

> +			The connection will be closed and network device
> +			released either upon calling Disconnect() or when
> +			the client disappears from the bus.

s/bus/message bus/

Regards

Marcel


