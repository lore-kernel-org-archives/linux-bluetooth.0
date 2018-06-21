Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH BlueZ v3 01/11] doc/mgmt-api: Add support for Set Phy
 Configuration command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1528978884-3882-2-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Thu, 21 Jun 2018 16:27:38 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <8ACDAD02-53CF-4D39-A533-918154485903@holtmann.org>
References: <1528978884-3882-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <1528978884-3882-2-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> This also adds PHY Configuration Changed Event.
> ---
> doc/mgmt-api.txt | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 81 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 8e7de14..caba22d 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2917,6 +2917,72 @@ Set Appearance Command
> 				Invalid Index
> 
> 
> +Get PHY Configuration Command
> +==========================
> +
> +	Command Code:		0x0043
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Supported_phys (2 Octet)
> +				Selected_phys (2 Octet)
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
> +        It will return Not Supported otherwise.
> +
> +        Possible errors:	Not Supported
> +				Invalid Index

so I spent some time thinking about how useful it is to make this LE specific or if we allow BR/EDR configuration as well. I concluded that we want to include BR/EDR as well and also tell exactly what options are configurable and which ones are static.

	Command Code:		0x0043
	Controller Index:	<controller id>
	Command Parameters:
	Return Parameters:	Supported_PHYs (4 Octets)
				Configurable_PHYs (4 Octets)
				Selected_PHYs (4 Octets)

	The PHYs parameters are a bitmask with currently the
	following available bits:

		0	BR 1M 1-Slot
		1	BR 1M 3-Slot
		2	BR 1M 5-Slot
		3	EDR 2M 1-Slot
		4	EDR 2M 3-Slot
		5	EDR 2M 5-Slot
		6	EDR 3M 1-Slot
		7	EDR 3M 3-Slot
		8	EDR 3M 5-Slot
		9	LE 1M TX
		10	LE 1M RX
		11	LE 2M TX
		12	LE 2M RX
		13	LE Coded TX
		14	LE Coded RX

	If BR/EDR is supported, then BR 1M 1-Slot is supported by
	default and can also not be deselected. If LE is supported,
	then LE 1M TX and LE 1M RX are supported by default and can
	not be deselected.

	Disabling BR/EDR completely or respectively LE has not impact
	on the PHY configuration. It is remembered over power cycles.

	This command generates a Command Complete event on success
	or a Command Status event on failure.

	Possible errors:	Invalid Parameters
				Invalid Index



Double empty lines after each command.

> +
> +Set PHY Configuration Command
> +=============================
> +
> +	Command Code:		0x0044
> +	Controller Index:	<controller id>
> +	Command Parameters: 	Default_phys (2 Octet)
> +	Return Parameters:

Lets name it Selected_PHYs (4 Octets) here.

> +
> +	This command is used to set the default phy to the controller.
> +
> +	This will be stored and used for all the subsequent scanning
> +	and connection initiation.
> +
> +	The list of supported PHYs can be retrieved via the
> +	Get PHY Configuration command. Selecting unsupported PHYs will
> +	result in an Invalid Parameters	error.
> +
> +	This can be called at any point to change the preferred PHYs.
> +
> +	Default_phys is a bitmask with the following bits.
> +		0	LE 1M TX
> +		1	LE 1M RX
> +		2	LE 2M TX
> +		3	LE 2M RX
> +		4	LE CODED TX
> +		5	LE CODED RX

I am fine doing a reference to Get PHY configuration here.

> +
> +	This command generates a Command Complete event on success
> +	or a Command Status event on failure.
> +
> +	This command is only available for LE capable controllers.
> +	It will return Not Supported otherwise.
> +
> +	Possible errors:	Not Supported
> +				Invalid Parameters
> +				Invalid Index
> +
> +
> Command Complete Event
> ======================
> 
> @@ -3782,3 +3848,18 @@ Extended Controller Information Changed Event
> 
> 	The event will only be sent to management sockets other than the
> 	one through which the change was triggered.
> +
> +PHY Configuration Changed Event
> +===============================
> +
> +	Event Code:		0x0026
> +	Controller Index:	<controller id>
> +	Event Parameters:	Selected_phys (2 Octets)
> +
> +	This event indicates that default PHYs have been updated.
> +
> +	This event will only be used after Set PHY Configuration
> +	command has been used at least once.
> +
> +	The event will only be sent to management sockets other than the
> +	one through which the change was triggered.

Regards

Marcel

