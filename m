Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 1/3] doc/mgmt-api: Add support for Get supported phys
 command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1510655538-12883-3-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Tue, 14 Nov 2017 12:31:33 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <6C819BC9-C1E6-4662-A274-99C325BA7CBF@holtmann.org>
References: <1510655538-12883-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1510655538-12883-3-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> ---
> doc/mgmt-api.txt | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 8e7de14..80edb14 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2916,6 +2916,29 @@ Set Appearance Command
> 				Invalid Parameters
> 				Invalid Index
> 
> +Get Supported PHYs Command
> +==========================
> +
> +	Command Code:		0x0043
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Supported_phys (1 Octet)
> +
> +	This command is used to retrieve the supported phys by the
> +	controller.
> +
> +	Supported_phys is a bitmask with the following bits.
> +		0	LE 1M
> +		1	LE 2M
> +		2	LE CODED (LR)
> +
> +	LE 1M would be supported by default.
> +
> +	This command is only available for LE capable controllers.
> +	It will return Not Supported otherwise.
> +
> +	Possible errors:	Not Supported
> +				Invalid Index

please combine getting supported PHYs and configured/selected PHYs into a single patch.

This patch should also include the changes to the Supported_Settings / Current_Settings of Read Controller Information (and its extended version).

So we need to have an extra bit there.

	16   PHY configuration

For supported settings this will be available if either LE 2M or LE Coded is supported. And it will not be set if only LE 1M is supported (that is covered with the LE bit.

It is also important to note that even with LE 2M and LE Coded supported by the hardware, we should limit it to use only LE 1M and not actually allow any other PHYs (this might actually need some extra patch to make this the default).

And if either LE 2M or LE Coded is selected, then PHY configuration bit should be set.

For the supported and default PHYs, I think we need to split between TX and RX PHYs like the spec does.

Regards

Marcel

