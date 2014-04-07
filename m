Return-Path: <cyrus@holtmann.org>
Message-ID: <5343227A.2080601@openbossa.org>
Date: Mon, 07 Apr 2014 19:11:06 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v3] doc: Connection Parameters command and event
References: <1396906610-3853-1-git-send-email-andre.guedes@openbossa.org> <03ACEBDE-F9B0-44F2-8466-CC578C37D8C1@holtmann.org>
In-Reply-To: <03ACEBDE-F9B0-44F2-8466-CC578C37D8C1@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 04/07/2014 06:49 PM, Marcel Holtmann wrote:
> Hi Andre,
>
>> doc/mgmt-api.txt | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> index cd5cd24..6a536d8 100644
>> --- a/doc/mgmt-api.txt
>> +++ b/doc/mgmt-api.txt
>> @@ -1006,7 +1006,8 @@ Unpair Device Command
>> 	Return Parameters:	Address (6 Octets)
>> 				Address_Type (1 Octet)
>>
>> -	Removes all keys associated with the remote device.
>> +	Removes all keys and connection parameters associated with the remote
>> +	device.
>>
>> 	Possible values for the Address_Type parameter:
>> 		0	BR/EDR
>> @@ -1679,6 +1680,52 @@ Load Identity Resolving Keys Command
>> 				Invalid Index
>>
>>
>> +Load Connection Parameters Command
>> +====================================
>> +
>> +	Command Code:		0x0031
>> +	Controller Index:	<controller id>
>> +	Command Parameters:	Params_Count (2 Octets)
>
> 				Param_Count
>
>> +				Params1 {
>
> 				Param1
>> +					Address (6 Octets)
>> +					Address_Type (1 Octet)
>> +					Min_Connection_Interval (2 Octets)
>> +					Max_Connection_Interval (2 Octes)
>> +					Connection_Latency (2 Octets)
>> +					Supervision_Timeout (2 Octets)
>> +				}
>> +				Params2 {  }
>
> 				Param2
>
> It should be loading multiple sets of parameter. The specification also talks about Connection Parameter as in singular set.
>
>> +				...
>> +	Return Parameters:
>> +
>> +	This command is used to load connection parameters from several LE
>> +	devices into kernel. It is only supported on controllers with LE
>> +	support.
>> +
>> +	The provided Address and Address_Type are the identity of a device. So
>> +	either its public address or static random address. Unresolvable random
>> +	addresses and resolvable random addresses are not valid and will be
>> +	rejected.
>> +
>> +	Possible values for the Address_Type parameter:
>> +		0	Reserved (not in use)
>> +		1	LE Public
>> +		2	LE Random
>> +
>> +	The Min_Connection_Interval, Max_Connection_Interval, Connection_Latency
>> +	and Supervision_Timeout parameters should be configured as described in
>> +	Core 4.1 spec, Vol 2, 7.8.12.
>> +
>> +	This command can be used when the controller is not powered.
>> +
>> +	This command generates a Command Complete event on success or
>> +	a Command Status event on failure.
>> +
>> +	Possible errors:	Invalid Parameters
>> +				Invalid Index
>> +				Not Supported
>> +
>> +
>> Command Complete Event
>> ======================
>>
>> @@ -2268,3 +2315,35 @@ New Signature Resolving Key Event
>>
>> 	The provided Address and Address_Type are the identity of
>> 	a device. So either its public address or static random address.
>> +
>> +
>> +New Connection Parameters Event
>
> 		Parameter
>
>> +===============================
>> +
>> +	Event Code:		0x001a
>> +	Controller Index:	<controller id>
>> +	Event Parameters:	Store_Hint (1 Octet)
>
> 				Param {
>
>> +				Address (6 Octets)
>> +				Address_Type (1 Octet)
>> +				Min_Connection_Interval (2 Octets)
>> +				Max_Connection_Interval (2 Octes)
>> +				Connection_Latency (2 Octets)
>> +				Supervision_Timeout (2 Octets)
>
> 				}
>
> To match this up on how we designed the other events.
>
>> +
>> +	This event indicates the new LE connection parameters set by GAP
>> +	Connection Parameter Update Procedure.
>> +
>> +	The Store_Hint parameter indicates whether the host is expected
>> +	to store the connection parameters persistently or not.
>> +
>> +	This event is sent only if the new parameters are different from the
>> +	parameters the user has configured (See Load Connection Parameters
>> +	Command) or if there is no parameters configured for that device.
>> +
>> +	Possible values for the Address_Type parameter:
>> +		0	Reserved (not in use)
>> +		1	LE Public
>> +		2	LE Random
>> +
>> +	The Connection_Interval, Connection_Latency and Supervision_Timeout
>> +	parameters are encoded as described in Core 4.1	spec, Vol 2, 7.7.65.3.
>> —
>
> Besides these minor details, looks good to me.

I'm fixing these minor details and re-sending this RFC.

> The only question that I still have is if we need to take into account different parameters based on if we are slave or master. So similar to the long term keys, where we have two types of keys. One for each direction.
>
> Since we are planning to support LE peripheral role more and more, I think this is important to consider before we make this API official. It should not stop you to get the initial patches written and submitted for review, but it is something I like to get figured out before we merge anything.

Sure, I'll also think about how to support peripheral role in this API.

Additionally, I'll start writing patches to implement this API.

Best regards,

Andre
