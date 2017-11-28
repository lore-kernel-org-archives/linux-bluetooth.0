Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 2/3 v2] doc/mgmt-api: Add support for Set default Phy
 command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1511173617-25442-3-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Tue, 28 Nov 2017 09:56:48 +0100
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <DBCCCD9D-7CAC-45F6-89E2-9BE30B625FC6@holtmann.org>
References: <1511173617-25442-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1511173617-25442-3-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> ---
> doc/mgmt-api.txt | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 69e84cd..b59bf0c 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2940,9 +2940,47 @@ Get PHY Information Command
> 	LE 1M TX and LE 1M RX would be supported by default.
> 
> 	This command is only available for LE capable controllers.
> +        It will return Not Supported otherwise.
> +
> +        Possible errors:        Not Supported
> +				Invalid Index
> +
> +Set Default PHY Command
> +==========================

I think the name “Set PHY Configuration” would be better.

> +
> +	Command Code:		0x0044
> +	Controller Index:	<controller id>
> +	Command Parameters: 	Default_phy (1 Octet)
> +	Return Parameters:	Current_phys (1 Octet)

Returning the current selected PHYs is rather useless here. It would be exactly the same value we put in. However what might be useful is an event that indicates the change of the PHY Configuration.

I would also name it Selected_PHYs to match up with the Get PHY Configuration command.

> +
> +	This command is used to set the default PHYs to the controller.
> +
> +	This will be stored and used for all the subsequent scanning
> +	and connection initiation.
> +
> +	Prior to this, Get PHY information Command should be called
> +	to retrieve the supported PHYs by the controller. If default_phy
> +	has PHY not supported by the controller (not there in supported_phys)
> +	then Invalid Parameters will be returned.

“The list of supported PHYs can be retrieved via the Get PHY Configuration command. Selecting unsupported PHYs will result in an Invalid Parameters error.”

> +
> +	This can be called at any point to change the preferred PHYs.
> +
> +	Default_phy is a bitmask with the following bits.
> +		0	LE 1M TX
> +		1	LE 1M RX
> +		2	LE 2M TX
> +		3	LE 2M RX
> +		4	LE CODED TX
> +		5	LE CODED RX
> +
> +	This command generates a Command Complete event on success
> +	or a Command Status event on failure.
> +
> +	This command is only available for LE capable controllers.
> 	It will return Not Supported otherwise.

Same comments from Get command applies. If we combine TX/RX into a single parameter, then we should use 2 octets. Also we might want to extend this to BR/EDR packet type selection.

Regards

Marcel

