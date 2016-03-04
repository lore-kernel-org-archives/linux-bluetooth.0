Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [RFC v3] doc: Add Management Interface Network API definitions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457091512-21270-1-git-send-email-patrik.flykt@linux.intel.com>
Date: Fri, 4 Mar 2016 09:27:17 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4C4D637A-1741-449B-BDF0-35CE1088988B@holtmann.org>
References: <1457091512-21270-1-git-send-email-patrik.flykt@linux.intel.com>
To: Patrik Flykt <Patrik.Flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrik,

> ---
> v3: added interface index to 'Network' block, removed Nework_Role parameter
>    and dropped text about LE being enabled.
> 
> doc/doc.txt      |   0
> doc/mgmt-api.txt | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 142 insertions(+)
> create mode 100644 doc/doc.txt
> 
> diff --git a/doc/doc.txt b/doc/doc.txt
> new file mode 100644
> index 0000000..e69de29
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 731a088..6317255 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2801,6 +2801,107 @@ Start Limited Discovery Command
> 				Invalid Index
> 
> 
> +Get Networks Command
> +====================
> +
> +	Command Code:		0x0042
> +	Controller Index:	<controller id>
> +	Command Parameters:
> +	Return Parameters:	Connection_Count (2 Octets)
> +				Network1 {
> +					Address (6 Octets)
> +					Address_Type (1 Octet)
> +					Interface Index (4 Octets)
> +				}
> +				Network2 { }
> +				...
> +
> +	This command is used to retrieve a list of BTLE network
> +	connections. A pre-requisite is that LE is supported
> +	by the controller, otherwise this command will return a
> +	"not supported" response.
> +
> +	Possible values for the Address_Type parameter:
> +		0	Reserved
> +		1	LE Public
> +		2	LE Random
> +
> +	For devices using resolvable random addresses with a known
> +	identity resolving key, the Address and Address_Type will
> +	contain the identity information.
> +
> +	This command can only be used when the controller is powered.
> +
> +	This command generates a Command Complete event on success or
> +	a Command Status event on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Not Supported
> +				Invalid Index
> +
> +
> +Add Network Command
> +===================
> +
> +	Command Code:		0x0043
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Interface Index (4 Octets)

actually we have a bit of an issue here. So my understanding is that this command does not necessarily connects right away. If it is similar to Add Device, then you add your remote device here and at some point in the future if the device is found, it might get connected. If it gets connected it will also establish IPSP or BNEP.

So first of all, we are operating under the assumption that Add Network does not really do any trigger of scanning or advertising. We let that one be handled by Add Device and Add Advertising. This is just for the network side of things to decide if we establish the network layer.

The second problem here is really if the above is what we want, that the Interface Index will not be available at this point in time. Yes, for IPSP we can just create it at this point and have it available in the system, but for BNEP this is not going to work. That interface is only available once you actually connected. Unless we also want to change that and create the BNEP interface ahead of time and mark it has LOWER_DOWN (meaning no link).

In any case, we should keep a Type or Mode parameter here to select between IPSP and BNEP. Even while currently they are clearly limited to the address type, but in theory, there is nothing stopping us to run IPSP over BR/EDR or a new future IPv6 / 6LoWPAN solution coming up that might be connection-less.

And no matter what we should have a note here that mentions Add Device and Add Advertising to be used to handle the connection parts of the establishment.

Regards

Marcel

