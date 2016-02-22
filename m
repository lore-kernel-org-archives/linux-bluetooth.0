Return-Path: <Patrik.Flykt@linux.intel.com>
Message-ID: <1456146169.17625.70.camel@linux.intel.com>
Subject: Re: [RFC] doc: Add Management Interface IPSP API definitions
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 22 Feb 2016 15:02:49 +0200
In-Reply-To: <08B4C3A1-DC90-4D77-B4B0-B15AC0CF05F4@holtmann.org>
References: <1455797845-27533-1-git-send-email-patrik.flykt@linux.intel.com>
	 <08B4C3A1-DC90-4D77-B4B0-B15AC0CF05F4@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


	Hi,

On Fri, 2016-02-19 at 23:59 -0800, Marcel Holtmann wrote:
> > +Connect IPSP Command
> > +====================
> > +
> > +	Command Code:		0x0042
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +	Return Parameters:	Interface Index (4 Octets)
> > +				Address (6 Octets)
> > +				Address_Type (1 Octet)
> 
> I think you really want to swap this. Address + Type first and then
> Interface Index.

Ok.

> > +	This command is used to connect to a remote IPSP Node.
> > +
> > +	Possible values for the Address_Type parameter:
> > +		1	LE Public
> > +		2	LE Random
> > +
> > +	This command generates a Command Complete event on success
> > +	or failure.
> > +
> > +	Possible errors:	Busy
> > +				Refused
> > +				Invalid Parameters
> > +				Not Powered
> > +				Invalid Index
> > +				Already Connected
> > +
> > +
> > +Disconnect IPSP Command
> > +=======================
> > +
> > +	Command Code:		0x0043
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +	Return Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +
> > +	This command is used to disconnect from a remote IPSP device.
> > +
> > +	Possible values for the Address_Type parameter:
> > +		1	LE Public
> > +		2	LE Random
> 
> I actually prefer that we list 0 value as reserved like we have done
> for the other LE only commands.
> 
> In addition we might want to make clear that these commands are only
> supported if LE is actually enabled first.

Ok.

> > +Get IPSP Connections Command
> > +============================
> > +
> > +	Command Code:		0x0044
> > +	Controller Index:	<controller id>
> > +	Command Parameters:
> > +	Return Parameters:	Interface Index (4 Octets)
> > +				Connection_Count (2 Octets)
> > +				Address1 {
> > +					Address (6 Octets)
> > +					Address_Type (1 Octet)
> > +				}
> > +				Address2 { }
> > +				...
> 
> I would normally assume that the Get Connections one comes before the
> Connect / Disconnect commands.

Swapped order here.

> > +
> > +	This command is used to retrieve a list of currently connected
> > +	IPSP devices.
> > +
> > +	Possible values for the Address_Type parameter:
> > +		1	LE Public
> > +		2	LE Random
> > +
> > +	For devices using resolvable random addresses with a known
> > +	identity resolving key, the Address and Address_Type will
> > +	contain the identity information.
> > +
> > +	This command can only be used when the controller is powered.
> > +
> > +	This command generates a Command Complete event on success or
> > +	a Command Status event on failure.
> > +
> > +	Possible errors:	Invalid Parameters
> > +				Not Powered
> > +				Invalid Index
> > +
> > +
> > +Enable IPSP Server Command
> > +==========================
> > +
> > +	Command Code:		0x0045
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Enable (1 Octet)
> > +	Return Parameters:
> 
> Not a big fan of the command name. We never used the Enable Something
> term.

Is 'Set IPSP Node Role Command' ok?


> > +IPSP Connected Event
> > +====================
> > +
> > +	Event Code:		0x0025
> > +	Controller Index:	<controller id>
> > +	Event Parameters:	Interface Index (4 Octets)
> > +				Address (6 Octets)
> > +				Address_Type (1 Octet)
> 
> Same here. I think they are in the wrong order.

Ok.

> > +IPSP Disconnected Event
> > +=======================
> > +
> > +	Event Code:		0x0026
> > +	Controller Index:	<controller id>
> > +	Event Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +
> > +	This event indicates that the IPSP connection was lost to a
> > +	remote device.
> > +
> > +	Possible values for the Address_Type parameter:
> > +		1	LE Public
> > +		2	LE Random
> > +
> > +	For devices using resolvable random addresses with a known
> > +	identity resolving key, the Address and Address_Type will
> > +	contain the identity information.
> 
> I am not a huge fan of the IPSP in the commands and events. Can we
> find something better?

There was a discussion on naming in "Re: [RFC v3] doc: Add initial
Network Management API definition" on the mailing list last June that
ended a bit inconclusive. Meanwhile RFC 7668 has gravitated towards
using "6LowPAN techniques" to describe how IPv6 is transported over
BTLE, but the RFC itself is called "IPv6 over BLUETOOTH(R) Low Energy".

Then again include/net/bluetooth/l2cap.h defines a value called
L2CAP_PSM_IPSP.

Shall we continue using 6lowpan as before in RFC v3?


Cheers,

	Patrik
