Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [RFC v3] doc: Connection Parameters command and event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140408095622.GA21390@t440s.spectrum.wifi>
Date: Tue, 8 Apr 2014 07:35:54 -0700
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Message-Id: <BEB72C39-8137-4270-8C93-2634CC329AF9@holtmann.org>
References: <1396906610-3853-1-git-send-email-andre.guedes@openbossa.org> <03ACEBDE-F9B0-44F2-8466-CC578C37D8C1@holtmann.org> <20140408095622.GA21390@t440s.spectrum.wifi>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> +Load Connection Parameters Command
>>> +====================================
>>> +
>>> +	Command Code:		0x0031
>>> +	Controller Index:	<controller id>
>>> +	Command Parameters:	Params_Count (2 Octets)
>> 
>> 				Param_Count
>> 
>>> +				Params1 {
>> 
>> 				Param1
>>> +					Address (6 Octets)
>>> +					Address_Type (1 Octet)
>>> +					Min_Connection_Interval (2 Octets)
>>> +					Max_Connection_Interval (2 Octes)
>>> +					Connection_Latency (2 Octets)
>>> +					Supervision_Timeout (2 Octets)
>>> +				}
>>> +				Params2 {  }
>> 
>> 				Param2
>> 
>> It should be loading multiple sets of parameter. The specification
>> also talks about Connection Parameter as in singular set.
> 
> This would be very funny sounding English imo. The specification only
> uses singular for the HCI Commands and Event (where "Connection
> Parameter Request" does sound ok and doesn't mean that we're dealing
> with a single parameter). In the command and event descriptions the spec
> is pretty clear that we're dealing with multiple parameters, e.g.:
> 
> (from 7.8.31):
> 	"This indicates that the Host has accepted the remote device’s
> 	request to change connection parameters."
> 
> 	"The Interval_Min parameter shall not be greater than the
> 	Interval_Max parameter"
> 
> 	"The Timeout parameter shall..."o
> 
> (from 7.8.32):
> 	"This indicates that the Host has rejected the remote device’s
> 	request to change connection parameters."
> 
> (from 7.7.65.6):
> 	"This event indicates to the master’s Host or the slave’s Host
> 	that the remote device is requesting a change in the connection
> 	parameters."
> 
> So imo the spec is pretty clear that we're dealing with multiple
> parameters per device.
> 
> 
>>> +New Connection Parameters Event
>> 
>> 		Parameter
> 
> Nope. We're notifying user space of a new set of multiple parameters.
> Using the singular form here makes this sound quite funny. If you had
> just one parameter then we wouldn't even name the event like this but
> directly spell out which parameter is in question (e.g. "New Connection
> Latency Event").
> 
> If you don't believe me feel free to get another opinion from a native
> English speaker ;)

all of our commands are containing multiple parameters, but I do not like the wording of making it all plural. The notification event should be singular and the loading command should be plural. For me it is always a set of multiple individual parameters that make up the command and event.

Regards

Marcel

