Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2] doc: Add initial 6LoWPAN API definition
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150320102653.GA9209@t440s.lan>
Date: Fri, 20 Mar 2015 08:53:18 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <703E1FC0-6540-4678-AEC0-93802FC84E19@holtmann.org>
References: <1426761568-7649-1-git-send-email-johan.hedberg@gmail.com> <779A63F7-7FD6-4643-8D17-19541AA44489@holtmann.org> <20150320102653.GA9209@t440s.lan>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> +Read Controller Index List Command
>>> +==================================
>>> +
>>> +	Command Code:		0x0003
>>> +	Controller Index:	<non-controller>
>>> +	Command Parameters:
>>> +	Return Parameters:	Num_Controllers (2 Octets)
>>> +				Controller_Index[i] (2 Octets)
>>> +				Supported_Features[i] (4 Octets)
>>> +
>>> +	This command returns the list of currently known controllers
>>> +	that can be used for 6LoWPAN connections. Controllers added or
>>> +	removed after calling this command can be monitored using the
>>> +	Index Added and Index Removed events.
>>> +
>>> +	The Supported_Features is a bitmask with the following available
>>> +	bits:
>>> +
>>> +		0	Node Role Supported
>>> +		1	Router Role Supported
>>> +
>>> +	This command generates a Command Complete event on success or
>>> +	a Command Status event on failure.
>> 
>> so my preference is to keep command codes 0x0001 - 0x0003 exactly the
>> same as with what we have in the current GAP part of the API. That
>> means this should just return the list of controller indexes.
> 
> For 0x0001 and 0x0002 I agree, but I'm not convinced for the rest. If
> the information we need to return is rather simple we can avoid
> unnecessary messaging and context switches if we just include it along
> with the index. So I'd consider going with the "Extended" style index
> commands and events that we just recently introduced to the GAP channel
> as well.

the extended read index list is totally different here. Features do not belong in here. And this is actually more like Supported_Settings and Current_Settings.

> If we find that we need more information in the future we can always
> then add a Read Info command.

Not really. We add that from the start. Worked fine for a long time for us and I rather not break with a design that we know works.

>> This also means that event codes 0x0001 - 0x0005 kept exactly the
>> same.
> 
> For the index added event I'd still consider having simple info there.
> As for the HW error, that just makes no sense at all to me. We're
> operating purely on an L2CAP level here and that error is an HCI level
> detail. The kernel already handles that by resetting the controller so
> user space will either way get the appropriate "disconnected" events for
> the 6lowpan connection.

A client that only operates on the 6LoWPAN side of things still wants to know if a hardware error happened. Otherwise you end up having to open two sockets.

>> And that should be kept the same for any future channel we are
>> adding support for. The basic commands and events have served us
>> really well.
> 
> Just because it works well doesn't mean that we shouldn't think a bit
> whether we can do better, especially since we're operating in a slightly
> different context. We can't anymore change the GAP channel but we can
> try to get new ones right from the start. Considering providing some
> extra info along with the index is one example. That said, I don't have
> a super strong opinion either way - I was simply trying to keep this new
> interface as short & simple as possible.

Since I have written the 4th client that utilizes management style API now, I do have rather strong opinion here. Things that actually work very well are things you want to keep exactly that way.

>> With this in mind the first specific command would be the Read
>> Controller Info type command with 0x0004 that then. It will return the
>> list of Supported_Features and Current_Features and maybe some extra
>> information about the 6LoWPAN side of things. Doing it that way has
>> also served us well to communicate states across the clients easily.
> 
> I agree with having a similar supported vs current settings/features
> split, so I'll fix at least that for the next revision.
> 
>>> +Connect Command
>>> +===============
>>> +
>>> +	Command Code:		0x0004
>>> +	Controller Index:	<controller id>
>>> +	Command Parameters:	Address (6 Octets)
>>> +				Address_Type (1 Octet)
>>> +	Return Parameters:	Address (6 Octets)
>>> +				Address_Type (1 Octet)
>>> +				Network_Interface (16 Octets)
>> 
>> Kernel interfaces should return the 4 octet ifindex. Not the network
>> interface name. Also this is most likely pretty much wrong in the
>> connect context. Per controller you only have a single 6LoWPAN network
>> interface anyway. That sounds more like something that should be
>> generic in the read info details.
> 
> Not sure if you realized, but I took this straight from the BNEP ioctl
> where there's a "char device[16]" return parameter in the
> bnep_connadd_req struct. If the ifindex is a general convention in
> kernel APIs then I'm fine with that.

And that is a clear mistake in the BNEP ioctl that we can not fix anymore. No need to repeat this mistake.

>> I spent a lot of time to explain the Address_Type parameters in the
>> other document, we might better actually copy that over here. And
>> clearly say which ones are supported and which ones reserved.
> 
> Sure.
> 
>>> +Start Node Command
>>> +==================
>>> +
>>> +	Command Code:		0x0005
>>> +	Controller Index:	<controller id>
>>> +	Command Parameters:
>>> +	Return Parameters:
>>> +
>>> +	This command is used create a 6LoWPAN Node for a specified
>>> +	controller.
>>> +
>>> +	This command generates a Command Complete event on success or
>>> +	a Command Status event on failure.
>>> +
>>> +	Possible errors:	Busy
>>> +				Invalid Index
>>> +
>>> +
>>> +Stop Node Command
>>> +=================
>>> +
>>> +	Command Code:		0x0006
>>> +	Controller Index:	<controller id>
>>> +	Command Parameters:
>>> +	Return Parameters:
>>> +
>>> +	This command is used to stop a 6LoWPAN Node for a specified
>>> +	controller.
>>> +
>>> +	This command generates a Command Complete event on success or
>>> +	a Command Status event on failure.
>>> +
>>> +	Possible errors:	Rejected
>>> +				Invalid Index
>> 
>> Generally I think Set Node and Set Router seems to be the more obvious
>> commands here. And they could have then also returned the information
>> about the changed Current_Features / Current_Settings.
> 
> I'm fine with Set Node, but I don't know what you'd expect Set Router to
> do. In router role we actively initiate an L2CAP Connect Request,
> whereas the Node role is just about having an L2CAP server around (for
> the purposes of this API - you obviously also need to get the
> advertising right).

And that is something that internally has to happen from the 6LoWPAN module to the core, but I consider that an internal detail.

>>> +Command Status Event
>>> +====================
>>> +
>>> +	Event Code:		0x0002
>>> +	Controller Index:	<controller id> or <non-controller>
>>> +	Event Parameters:	Command_Opcode (2 Octets)
>>> +				Status (1 Octet)
>>> +
>>> +	The command status event is used to indicate an early status for
>>> +	a pending command. In the case that the status indicates failure
>>> +	(anything else except success status) this also means that the
>>> +	command has finished executing.
>> 
>> I would include the Controller Error event to allow us to indicate
>> controller errors.
> 
> As I mentioned earlier the HW error really makes no sense at all to me,
> neither from the API perspective nor from the implementation.

See my comment above. If something goes wrong, you might want to know that this happened.

> 
>>> +Index Added Event
>>> +=================
>>> +
>>> +	Event Code:		0x0003
>>> +	Controller Index:	<controller id>
>>> +	Event Parameters:	Supported_Features (4 octets)
>>> +
>>> +	This event indicates that a new controller has been added to the
>>> +	system that can be used for 6LoWPAN.
>>> +
>>> +	The Supported_Features is a bitmask with the following available
>>> +	bits:
>>> +
>>> +		0	Node Role Supported
>>> +		1	Router Role Supported
>>> +
>>> +
>>> +Index Removed Event
>>> +===================
>>> +
>>> +	Event Code:		0x0004
>>> +	Controller Index:	<controller id>
>>> +	Event Parameters:
>>> +
>>> +	This event indicates that a 6LoWPAN-capable controller has been
>>> +	removed from the system.
>> 
>> As said above, these two I would have kept exactly as is with the
>> current interface. Just tell about the new index. That  has been
>> working out nicely.
> 
> I'd like to hear a good argument for why we wouldn't try to avoid the
> extra messaging and context switching by providing some basic info in
> addition to the index.

Because you will do that anyway. There is nothing to save here. This makes it simpler. The information you need come in a simple call. And if you call it with giving --index to it, then you still get the same info.

>> We might actually want to move the whole common set of parameters into
>> a common document that provides the basics and these common commands
>> and events. Then each individual document can focus on its part.
> 
> Yep, that would make sense, as long as we can agree on what the common
> part is :)
> 
>>> +6LoWPAN Connected Event
>>> +=======================
>>> +
>>> +	Event Code:		0x0005
>>> +	Controller Index:	<controller id>
>>> +	Event Parameters:	Address (6 Octets)
>>> +				Address_Type (1 Octet)
>>> +				Role (1 Octet)
>>> +				Interface_Name (16 Octets)
>> 
>> The interface makes really no sense here. That is fixed and always the
>> same for the controller id. These information need to be provided
>> differently in the common info set.
> 
> I was thinking that it'd give some future flexibility if we end up
> splitting this up into one interface per connection at some point, but
> I'm fine with putting this in the controller info part of the API.
> 
> Btw, do we expect to have a single interface per controller even when
> the controller is acting simultaneously in router and node roles?

That is how 6LoWPAN is defined. It is an IP level thing. All connections feed into the same netdev.

> 
>>> +	This event indicates that a successful 6LoWPAN connection has
>>> +	been created to the remote device.
>>> +
>>> +	Possible values for the Address_Type parameter:
>>> +		1	LE Public
>>> +		2	LE Random
>>> +
>>> +	For devices using resolvable random addresses with a known
>>> +	identity resolving key, the Address and Address_Type will
>>> +	contain the identity information.
>>> +
>>> +	The Role parameter indicates which role the local system has for
>>> +	the connection. The parameter has the following possible values:
>>> +		0x00	Node
>>> +		0x01	Router
>> 
>> Why local system? Don't we actually know that information. I am really
>> not getting this event.
> 
> I put this info there so 3rd party apps (think btmon or 'btmgmt monitor'
> can track what's happening). For a single user (bluetoothd) you're right
> that this event would only be needed to notify of new connections when
> we're in the Node role. For Router we'd know the new connection from a
> successful Connect command response.

It is also all IP based. I do not even think this will make any difference.

>>> +6LoWPAN Disconnected Event
>>> +==========================
>>> +
>>> +	Event Code:		0x0006
>>> +	Controller Index:	<controller id>
>>> +	Event Parameters:	Address (6 Octets)
>>> +				Address_Type (1 Octet)
>>> +				Role (1 Octet)
>>> +				Reason (1 Octet)
>>> +
>>> +	This event indicates that the 6LoWPAN connection was lost to a
>>> +	remote device.
>>> +
>>> +	Possible values for the Address_Type parameter:
>>> +		1	LE Public
>>> +		2	LE Random
>>> +
>>> +	For devices using resolvable random addresses with a known
>>> +	identity resolving key, the Address and Address_Type will
>>> +	contain the identity information.
>>> +
>>> +	The Role parameter indicates which role the local system has for
>>> +	the connection. The parameter has the following possible values:
>>> +		0x00	Node
>>> +		0x01	Router
>>> +
>>> +	Possible values for the Reason parameter:
>>> +		0	Unspecified
>>> +		1	Connection timeout
>>> +		2	Connection terminated by local host
>>> +		3	Connection terminated by remote host
>> 
>> The obvious missing event is when Current_Features change or the
>> service as node or router has been activated. We really want to
>> communicate this kind of information.
> 
> Agreed. I'll add that.

Regards

Marcel

