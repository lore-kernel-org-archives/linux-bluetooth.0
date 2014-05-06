Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC] mgmt-api: Add support to get connection parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1398677161-14795-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Mon, 5 May 2014 19:40:37 -0700
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <D3820210-B72A-46E0-891C-506237D123F4@holtmann.org>
References: <1398677161-14795-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> Set Connection Parameters Change command and
> Connection Parameters Changed Event has been introduced.
> ---
> doc/mgmt-api.txt | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 87 insertions(+)
> 
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index cd5cd24..2408ba0 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1679,6 +1679,50 @@ Load Identity Resolving Keys Command
> 				Invalid Index
> 
> 
> +Set Connection Parameters Change Command
> +========================================
> +
> +	Command Code:		0x0031
> +	Controller Index:       <controller id>
> +	Command Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +				Parameters_count (2 Octet)
> +				Parameter1 {
> +					Type (1 Octet)
> +					Delta (1 Octet)
> +				}
> +				Parameter2 {  }
> +				...
> +
> +	Return Parameters:	Address (6 Octets)
> +				Address_Type (1 Octet)
> +
> +	This command is used to register for Connection Parameters Change
> +	Event.
> +
> +	Possible Parameter Type:
> +		0	TX Power
> +		1	RSSI
> +
> +	This command will trigger Connection Parameters Change event.
> +	Only changes greater or equal to Delta trigger subsequent Connection
> +	Parameters Change events.
> +
> +	Delta shall be greater and equal to 0.
> +	Delta equal to 0 disable parameter tracking.
> +
> +	Parameters set will be remembered during power down/up toggles and
> +	connection state toggles.
> +
> +	On new connection, Connection Parameters Change Event is sent.
> +
> +	This command generates a Command Complete event on success
> +	and on failure.
> +
> +	Possible errors:	Invalid Parameters
> +				Invalid Index

since we do not know if and when a proper controller based HCI command set will appear, what ever design might cause too many troubles. We also have to consider the cases of reboots where you want to reload the whole per-device configuration back into the kernel.

So for the time being we might just use a simple polling based API that bluetoothd then controls. And the only threshold configured via debugfs should be the interval the kernel keeps returning the previous value before it will ever request a new one. So that no matter what happens or whatever goes wrong, we can not overload the controller by requesting the same value over and over again.

This are actually not really connection parameters. You can not really configure them. They are more connection characteristics that are defined by the surroundings.

Get Connection Characteristics
==============================

	Command Code:		TBD
	Controller Index:	<controller id>
	Command Parameters:	Address (6 Octets)
				Address_Type (1 Octet)
	Return Parameters:	Address (6 Octets)
				Address_Type (1 Octet)
				RSSI (1 Octet)
				Flags (4 Octets)
				EIR_Data_Length (2 Octets)
				EIR_Data (0-65535 Octets)

I am on purpose re-using the return value from Device Found. Since that way we could actually include details like class of device or device name if we wanted to.

Maybe adding Request_Types (4 Octets) field to the command parameters to indicate if TX power or other values should be updated is a good idea as well. Better name than Request_Types might be needed for the parameter.

Even while polling is still horrible, but we have no other way, the one advantage we still get here is that all updates are send as a sequence of HCI commands. That way we wake up once, request all the updates and then go back to sleep. That is a lot better than if bluetoothd would wake up for one update, then for the other, then for the next one.

Regards

Marcel

