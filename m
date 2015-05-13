Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] doc: Add command for limited discoverable procedure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1429552938-71139-1-git-send-email-marcel@holtmann.org>
Date: Wed, 13 May 2015 23:10:07 +0200
Message-Id: <EDD96938-FD05-4F4F-9131-AF578DF56B4B@holtmann.org>
References: <1429552938-71139-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> ---
> doc/mgmt-api.txt | 45 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 45 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 7a5d33f0f5c0..4b97aad3c6cb 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -2655,6 +2655,51 @@ Remove Advertising Command
> 				Invalid Index
> 
> 
> +Start Limited Discovery Command
> +===============================
> +
> +	Command Code:		0x0040
> +	Controller Index:	<controller id>
> +	Command Parameters:	Address_Type (1 Octet)
> +	Return Parameters:	Address_Type (1 Octet)
> +
> +	This command is used to start the process of discovering remote
> +	devices using the limited discovery procedure. A Device Found event
> +	will be sent for each discovered device.
> +
> +	Possible values for the Address_Type parameter are a bit-wise or
> +	of the following bits:
> +
> +		0	BR/EDR
> +		1	LE Public
> +		2	LE Random
> +
> +	By combining these e.g. the following values are possible:
> +
> +		1	BR/EDR
> +		6	LE (public & random)
> +		7	BR/EDR/LE (interleaved discovery)
> +
> +	The limited discovery uses active scanning for Low Energy scanning
> +	and will search for devices with the limited discoverabilty flag
> +	configured. On BR/EDR it uses LIAC and filters on the limited
> +	discoverabilty flag of the class of device.
> +
> +	When the discovery procedure starts the Discovery event will
> +	notify this similar to Start Discovery.

who is working on implementing this? We need this command to be included on our set of tools. I do not want to hack hcitool to pass qualification.

Regards

Marcel

