Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Jul 2015 13:56:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v3] doc: Add initial Network Management API definition
Message-ID: <20150716105630.GA16648@t440s.lan>
References: <1434962366-10791-1-git-send-email-johan.hedberg@gmail.com>
 <AAEF3A5A-CAFE-4C19-AFA6-A3BC9A8527B3@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AAEF3A5A-CAFE-4C19-AFA6-A3BC9A8527B3@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jun 29, 2015, Marcel Holtmann wrote:
> > +Read Controller Information Command
> > +===================================
> > +
> > +	Command Code:		0x0004
> > +	Controller Index:	<controller id>
> > +	Command Parameters:
> > +	Return Parameters:	Address (6 Octets)
> > +				Address_Type (6 Octets)
> > +				Supported_Settings (4 Octets)
> > +				Current_Settings (4 Octets)
> > +				6LoWPAN_Interface_Index (4 Octets)
> > +
> > +	This command is used to retreive the current state and basic
> > +	information of a controller. It is typically used right after
> > +	getting the response to the Read Controller Index List command
> > +	or an Index Added event.
> > +
> > +	Current_Settings and Supported_Settings is a bitmask with
> > +	currently the following available bits:
> > +
> > +		0	6LoWPAN
> > +		1	6LoWPAN Server (Node)
> > +
> > +	The 6LoWPAN_Interface_Index parameter value is only valid if the
> > +	6LoWPAN settings bit is set in the Current_Settings, otherwise
> > +	it should be ignored.
> 
> I have no idea what this is going to do. I wonder if should really
> have this in this command. Especially since the index might be even
> there if it is not enabled yet. This sound more like a parameter that
> should be returned by an individual command or when enabling the
> 6LoWPAN support.

When we're acting as initiator there's no "enable" command as such but
just the connect command. Should then the connect command return the
interface index? IIRC I had that in my very early drafts/ideas of this
API. For the acceptor (Node) role we do have an "enable" command
however.

> > +Connect 6LoWPAN Command
> > +=======================
> > +
> > +	Command Code:		0x0005
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +	Return Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +
> > +	This command is used to connect to a remote 6LoWPAN Node.
> 
> Same as above, we might better just call this IPSP or Connect Internet
> Protocol.

Sure (I'd go with IPSP)

> One additional thing could be that we just return the interface index
> this new connection is using. I think that could be beneficial.
> Especially if we would actually create the 6lo interface for each
> controller on demand. Which might makes sense in case we only ever
> have client connections.

Yes, we'd need to do that if it's not going to be in the Read Info
response.

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
> 
> Don't we miss an already connected error here?

Do we want that? We could also be "friendly" and simply return the
information for the existing connection instead of an error.

> > +Get 6LoWPAN Connections Command
> > +===============================
> > +
> > +	Command Code:		0x0007
> > +	Controller Index:	<controller id>
> > +	Command Parameters:
> > +	Return Parameters:	Connection_Count (2 Octets)
> > +				Address1 {
> > +					Address (6 Octets)
> > +					Address_Type (1 Octet)
> > +				}
> > +				Address2 { }
> > +				...
> 
> We could include the interface index here. Since you really want to
> know the interface index and what connections belong to it.

Sure, though right now it'd be the same for each connection as this is a
per-adapter command.

> > +Enable 6LoWPAN Server Command
> > +=============================
> > +
> > +	Command Code:		0x0008
> > +	Controller Index:	<controller id>
> > +	Command Parameters:	Enable (1 Octet)
> > +	Return Parameters:	Current_Settings (4 Octets)
> 
> As mentioned above, I might have included the interface index here.

Sure, though would we still keep the Current_Settings there? (I'd guess
yes so one can track that this has been enabled or not).

> > +	This command is used start a 6LoWPAN Server (Node rols) on a
> > +	specified controller.
> > +
> > +	This command generates a Command Complete event on success or
> > +	a Command Status event on failure.
> > +
> > +	Possible errors:	Busy
> > +				Invalid Index
> 
> Since this does enable and disable, I think this should be rather
> called Set Internet Protocol Gateway or something similar. I am even
> fine with using the terms client and server.

This is actually the Node and not a Gateway/Router. With IPSP it's the
Node side that has the L2CAP server and the Router is the one that
initiates a connection to it. Anyway, since a device can act in both
roles I'd just keep "Server".

> I think we also want this command to start advertising. So it should
> grab an instance in the multi-advertising feature and add the IPSP
> service. Might be also an option to the command to selective choose if
> it advertises. Maybe as 0x02 option.

Here we run into trouble since we've specified the multi-advertising so
that there's a single user-space daemon that manages the instance
numbers. Simplest solution would be to let the user space bluetoothd
plugin (the network one, I suppose) manage this through the existing
multi-advertising mgmt API.


> > +6LoWPAN Connected Event
> > +=======================
> > +
> > +	Event Code:		0x0007
> > +	Controller Index:	<controller id>
> > +	Event Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +
> > +	This event indicates that a successful 6LoWPAN connection has
> > +	been created to the remote device.
> > +
> > +	For devices using resolvable random addresses with a known
> > +	identity resolving key, the Address and Address_Type will
> > +	contain the identity information.
> 
> This would also be a good candidate for including the interface index.

Sure.

> > +6LoWPAN Disconnected Event
> > +==========================
> > +
> > +	Event Code:		0x0008
> > +	Controller Index:	<controller id>
> > +	Event Parameters:	Address (6 Octets)
> > +				Address_Type (1 Octet)
> > +				Reason (1 Octet)
> > +
> > +	This event indicates that the 6LoWPAN connection was lost to a
> > +	remote device.
> > +
> > +	Possible values for the Address_Type parameter:
> > +		1	LE Public
> > +		2	LE Random
> > +
> > +	For devices using resolvable random addresses with a known
> > +	identity resolving key, the Address and Address_Type will
> > +	contain the identity information.
> > +
> > +	Possible values for the Reason parameter:
> > +		0	Unspecified
> > +		1	Connection timeout
> > +		2	Connection terminated by local host
> > +		3	Connection terminated by remote host
> 
> I wonder what we are doing with this reason. The core API had some
> good uses for this. I am not sure this one is a good one.

I can't think of any good uses. I'll remove it.

> The way I am seeing this is that we should have an automatic mode to
> connect to all IPSP service we find. Which of course means we keep
> scanning in the background. And another one where the kernel scans and
> connects to known device. So something similar to Add Device where
> userspace that includes known devices and then the kernel will connect
> them when found. We could include a limited to only connect to n
> device. So by default only 1 IPSP device and when disconnected, it
> tries to find another one.

Maybe, but we should consider this kind of policy from the perspective
of both roles (node vs server). Would we e.g. at some point want to do
directed advertising to a specified Router when we're acting as Node.

Johan
