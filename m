Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC v2] doc: Connection Parameters command and event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <533F1FE4.1020104@openbossa.org>
Date: Fri, 4 Apr 2014 14:55:33 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B9C95212-8058-4E28-816D-2F0034C74064@holtmann.org>
References: <1396523885-3705-1-git-send-email-andre.guedes@openbossa.org> <0264824E-D1B3-48E4-A56B-D932C8B9A82D@holtmann.org> <533F1FE4.1020104@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

>>> doc/mgmt-api.txt | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>> 1 file changed, 88 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>>> index 78f0bd2..a2c65db 100644
>>> --- a/doc/mgmt-api.txt
>>> +++ b/doc/mgmt-api.txt
>>> @@ -995,7 +995,8 @@ Unpair Device Command
>>> 	Return Parameters:	Address (6 Octets)
>>> 				Address_Type (1 Octet)
>>> 
>>> -	Removes all keys associated with the remote device.
>>> +	Removes all keys and connection parameters associated with the remote
>>> +	device.
>>> 
>>> 	Possible values for the Address_Type parameter:
>>> 		0	BR/EDR
>>> @@ -1668,6 +1669,62 @@ Load Identity Resolving Keys Command
>>> 				Invalid Index
>>> 
>>> 
>>> +Load Connection Parameters Command
>>> +====================================
>>> +
>>> +	Command Code:		0x0031
>>> +	Controller Index:	<controller id>
>>> +	Command Parameters:	Params_Count (2 Octets)
>>> +				Params1 {
>>> +					Address (6 Octets)
>>> +					Address_Type (1 Octet)
>>> +					Auto_Connect_Option (1 Octet)
>> 
>> the one thing that I wonder is if we want to include this auto connect option here. I currently lean towards leaving this out and instead provide a different command that sets the auto-connect list.
>> 
>> As I said before, the link-loss re-connect option is something I rather see set via a socket option. I think that just makes more sense. You are connect, and you want to be re-connect if anything forces a disconnect.
> 
> I'm Ok with removing the auto connect option from this command and discussing more about the best way to set it (another mgmt command or a new socket option).

what we need to look into a little bit is what profiles/services require and auto-connect. So something like HID comes to mind. I think that goes along the lines also with remote-wakeup features.

My current thinking is Add Auto Connection Devices with array of Address and Address_Type and Remove Auto Connection Devices with the same array.

And the link-loss feature just becomes a socket option. Which means that profiles/services that just need a link-loss support, can do it from the application. And for systems services like HID, we do the auto-connect control in the daemon.

> So I'll remove it from the next version.
> 
>>> +					Min_Connection_Interval (2 Octets)
>>> +					Max_Connection_Interval (2 Octes)
>>> +					Connection_Latency (2 Octets)
>>> +					Supervision_Timeout (2 Octets)
>>> +				}
>>> +				Params2 {  }
>>> +				...
>>> +	Return Parameters:
>>> +
>>> +	This command is used load connection parameters from several LE devices
>>> +	into kernel. It is only supported on controllers with LE support.
>>> +
>>> +	The provided Address and Address_Type are the identity of a device. So
>>> +	either its public address or static random address. Unresolvable random
>>> +	addresses and resolvable random addresses are not valid and will be
>>> +	rejected.
>>> +
>>> +	Possible values for the Address_Type parameter:
>>> +		0	Reserved (not in use)
>>> +		1	LE Public
>>> +		2	LE Random
>> 
>> What I wonder is if we should include BR/EDR here as well. Since the link supervision timeout is something we could allow modification on BR/EDR while keeping connection interval and latency at zero.
>> 
>> In the past there have been discussions about link supervision timeout being configurable and not just using the default value and hoping the remote side would adjust it.
> 
> I would prefer to leave this out by now and focus on LE only. Once LE connection parameters are working fine, we can extend this command to handle BR/EDR parameters also.

We do not have to do it right away. It might be enough to do this only via socket options since you always have sockets with BR/EDR. LE with GATT on a fixed channel is rather special.

>>> +
>>> +	Possible values for the Auto_Connect_Option parameter:
>>> +		0	Disabled
>>> +		1	Always
>>> +		2	Link Loss
>>> +
>>> +	The 'Always' option configures the kernel to always re-establish the
>>> +	connection, no matter the reason the connection was terminated. The
>>> +	'Link Loss' option configures the kernel to re-establish the connection
>>> +	only in case the connection was terminated due to a link loss.
>>> +
>>> +	The Min_Connection_Interval, Max_Connection_Interval, Connection_Latency
>>> +	and Supervision_Timeout parameters should be configured as described in
>>> +	Core 4.1 spec, Vol 2, 7.8.12.
>>> +
>>> +	This command can be used when the controller is not powered.
>>> +
>>> +	This command generates a Command Complete event on success or
>>> +	a Command Status event on failure.
>>> +
>>> +	Possible errors:	Invalid Parameters
>>> +				Invalid Index
>>> +				Not Supported
>>> +
>>> +
>>> Command Complete Event
>>> ======================
>>> 
>>> @@ -2257,3 +2314,33 @@ New Signature Resolving Key Event
>>> 
>>> 	The provided Address and Address_Type are the identity of
>>> 	a device. So either its public address or static random address.
>>> +
>>> +
>>> +New Connection Parameters Event
>>> +===============================
>>> +
>>> +	Event Code:		0x001a
>>> +	Controller Index:	<controller id>
>>> +	Event Parameters:	Address (6 Octets)
>>> +				Address_Type (1 Octet)
>>> +				Connection_Interval (2 Octets)
>> 
>> This should be min and max connection interval. The actually chosen one by the controller is pretty irrelevant to us. We want to know what we have to load back into the kernel after next reboot.
> 
> The "HCI Connection Update" event reports only the value chosen by the controller (see description on page 1222). However, we can save the min and max values from Connection Update Procedure and use them in this mgmt event.
> 
> I'll fix this in the next version.

And one thing we should do here as well. Add a Store_Hint parameters similar to what we do with all of our keys. That will allow the kernel to communicate parameters without them being loaded on next reboot.

This becomes important when we end up sending this out for resolvable or unresolvable addresses where we do not have an identity address. There is pretty much no point for userspace to store the values.

Regards

Marcel

