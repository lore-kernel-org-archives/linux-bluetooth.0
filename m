Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 1/3 v2] doc/mgmt-api: Add support for Get PHY information
 command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1511173617-25442-2-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Tue, 28 Nov 2017 09:39:18 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <93DFE8A8-13AB-46A0-9475-F9D5856FEFE2@holtmann.org>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-2-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> ---
> doc/mgmt-api.txt | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 8e7de14..69e84cd 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2871,6 +2871,7 @@ Read Extended Controller Information Command
> 		13	Privacy
> 		14	Controller Configuration
> 		15	Static Address
> +		16  	PHY configuration
> 
> 	The EIR_Data field contains information about class of device,
> 	local name and other values. Not all of them might be present. For
> @@ -2916,6 +2917,33 @@ Set Appearance Command
> 				Invalid Parameters
> 				Invalid Index
> 
> +Get PHY Information Command
> +==========================
> +
> +	Command Code:		0x0043
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Supported_phys (1 Octet)
> +				Selected_phys (1 Octet)
> +
> +	This command is used to retrieve the supported PHYs and currently
> +	selected PHYs.
> +
> +	Supported_phys and Selected_phys is a bitmask with the following bits.
> +		0	LE 1M TX
> +		1	LE 1M RX
> +		2	LE 2M TX
> +		3	LE 2M RX
> +		4	LE CODED TX
> +		5	LE CODED RX
> +
> +	LE 1M TX and LE 1M RX would be supported by default.
> +
> +	This command is only available for LE capable controllers.
> +	It will return Not Supported otherwise.
> +
> +	Possible errors:	Not Supported
> +				Invalid Index

I think that I want to extend this command to also include BR/EDR PHY selection so that we have one command to drive all of these. So maybe the packet type selection of BR/EDR should be worked into this as well. Anyway, that should not stop us from implementing this for LE since BR/EDR can be added later.

My only question would be if we have TX/RX in the same octet or split into individual octets. In case we leave it like this, then we should make this a 2 octet value.

Regards

Marcel

