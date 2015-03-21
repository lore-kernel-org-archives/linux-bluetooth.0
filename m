Return-Path: <cyrus@holtmann.org>
Date: Sat, 21 Mar 2015 13:17:54 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] doc: Add initial 6LoWPAN API definition
Message-ID: <20150321111754.GA29648@t440s>
References: <1426761568-7649-1-git-send-email-johan.hedberg@gmail.com>
 <779A63F7-7FD6-4643-8D17-19541AA44489@holtmann.org>
 <20150320102653.GA9209@t440s.lan>
 <703E1FC0-6540-4678-AEC0-93802FC84E19@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <703E1FC0-6540-4678-AEC0-93802FC84E19@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Mar 20, 2015, Marcel Holtmann wrote:
> >>> +Read Controller Index List Command
> >>> +==================================
> >>> +
> >>> +	Command Code:		0x0003
> >>> +	Controller Index:	<non-controller>
> >>> +	Command Parameters:
> >>> +	Return Parameters:	Num_Controllers (2 Octets)
> >>> +				Controller_Index[i] (2 Octets)
> >>> +				Supported_Features[i] (4 Octets)
> >>> +
> >>> +	This command returns the list of currently known controllers
> >>> +	that can be used for 6LoWPAN connections. Controllers added or
> >>> +	removed after calling this command can be monitored using the
> >>> +	Index Added and Index Removed events.
> >>> +
> >>> +	The Supported_Features is a bitmask with the following available
> >>> +	bits:
> >>> +
> >>> +		0	Node Role Supported
> >>> +		1	Router Role Supported
> >>> +
> >>> +	This command generates a Command Complete event on success or
> >>> +	a Command Status event on failure.
> >> 
> >> so my preference is to keep command codes 0x0001 - 0x0003 exactly the
> >> same as with what we have in the current GAP part of the API. That
> >> means this should just return the list of controller indexes.
> > 
> > For 0x0001 and 0x0002 I agree, but I'm not convinced for the rest. If
> > the information we need to return is rather simple we can avoid
> > unnecessary messaging and context switches if we just include it along
> > with the index. So I'd consider going with the "Extended" style index
> > commands and events that we just recently introduced to the GAP channel
> > as well.
> 
> the extended read index list is totally different here. Features do
> not belong in here. And this is actually more like Supported_Settings
> and Current_Settings.
> 
> > If we find that we need more information in the future we can always
> > then add a Read Info command.
> 
> Not really. We add that from the start. Worked fine for a long time
> for us and I rather not break with a design that we know works.

This really isn't that complex of an API that we should need to
speculate on what would work or not work (I think it's clear that both
options can result in working code). Anyway, I'm not gonna fight this
detail further as I don't have a strong opinion on it.

> >> This also means that event codes 0x0001 - 0x0005 kept exactly the
> >> same.
> > 
> > For the index added event I'd still consider having simple info there.
> > As for the HW error, that just makes no sense at all to me. We're
> > operating purely on an L2CAP level here and that error is an HCI level
> > detail. The kernel already handles that by resetting the controller so
> > user space will either way get the appropriate "disconnected" events for
> > the 6lowpan connection.
> 
> A client that only operates on the 6LoWPAN side of things still wants
> to know if a hardware error happened. Otherwise you end up having to
> open two sockets.

The user space app with the 6lowpan socket will either way get a
notification that the connection got dropped because we now days handle
HW errors cleanly on the kernel side. Trying to cram HCI details like
that here feels like a layer violation to me (not to mention it'd result
in weird kernel-side code where we need to expose this HCI event to
modules).

As for the HW error event to user-space through the GAP socket, we're
not even doing anything with it right now (nor do we need to since the
kernel takes care of it). And if you did want to do something with it
you'd still have an GAP socket somewhere, even though it's not
necessarily in the same app as the 6lowpan socket.

> >>> +Start Node Command
> >>> +==================
> >>> +
> >>> +	Command Code:		0x0005
> >>> +	Controller Index:	<controller id>
> >>> +	Command Parameters:
> >>> +	Return Parameters:
> >>> +
> >>> +	This command is used create a 6LoWPAN Node for a specified
> >>> +	controller.
> >>> +
> >>> +	This command generates a Command Complete event on success or
> >>> +	a Command Status event on failure.
> >>> +
> >>> +	Possible errors:	Busy
> >>> +				Invalid Index
> >>> +
> >>> +
> >>> +Stop Node Command
> >>> +=================
> >>> +
> >>> +	Command Code:		0x0006
> >>> +	Controller Index:	<controller id>
> >>> +	Command Parameters:
> >>> +	Return Parameters:
> >>> +
> >>> +	This command is used to stop a 6LoWPAN Node for a specified
> >>> +	controller.
> >>> +
> >>> +	This command generates a Command Complete event on success or
> >>> +	a Command Status event on failure.
> >>> +
> >>> +	Possible errors:	Rejected
> >>> +				Invalid Index
> >> 
> >> Generally I think Set Node and Set Router seems to be the more obvious
> >> commands here. And they could have then also returned the information
> >> about the changed Current_Features / Current_Settings.
> > 
> > I'm fine with Set Node, but I don't know what you'd expect Set Router to
> > do. In router role we actively initiate an L2CAP Connect Request,
> > whereas the Node role is just about having an L2CAP server around (for
> > the purposes of this API - you obviously also need to get the
> > advertising right).
> 
> And that is something that internally has to happen from the 6LoWPAN
> module to the core, but I consider that an internal detail.

I was actually thinking we'd let use space use the newly defined
advertising API for this instead of doing shortcuts in the kernel (which
also add complexity there since this would require extra inter-module
communication). This would be similar to how BR/EDR profiles need to
independently register an SDP record and start server L2CAP or RFCOMM
sockets.

I'm open to reconsidering this, but reusing the existing advertising API
will probably result in the simplest code both in user space and the
kernel (no extra stuff for the kernel and for user space I suspect we'll
either way have a simple way for bluetoothd plugins to register LE
UUIDs).

> >>> +	This event indicates that a successful 6LoWPAN connection has
> >>> +	been created to the remote device.
> >>> +
> >>> +	Possible values for the Address_Type parameter:
> >>> +		1	LE Public
> >>> +		2	LE Random
> >>> +
> >>> +	For devices using resolvable random addresses with a known
> >>> +	identity resolving key, the Address and Address_Type will
> >>> +	contain the identity information.
> >>> +
> >>> +	The Role parameter indicates which role the local system has for
> >>> +	the connection. The parameter has the following possible values:
> >>> +		0x00	Node
> >>> +		0x01	Router
> >> 
> >> Why local system? Don't we actually know that information. I am really
> >> not getting this event.
> > 
> > I put this info there so 3rd party apps (think btmon or 'btmgmt monitor'
> > can track what's happening). For a single user (bluetoothd) you're right
> > that this event would only be needed to notify of new connections when
> > we're in the Node role. For Router we'd know the new connection from a
> > successful Connect command response.
> 
> It is also all IP based. I do not even think this will make any difference.

Not sure what you're saying here. That it was a mistake of the IPSP spec
to define two separate roles, that in practice everyone is equal in
6lowpan? I don't think I agree with that.

Johan
