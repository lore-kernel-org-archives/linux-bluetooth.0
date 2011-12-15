Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4EE9D453.6020503@linux.intel.com>
References: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com>
	<1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com>
	<CABBYNZKyY40pn-Sm_VSxHLqzbrQ9q-63Sjwmf=kvh4Dy1x9-bw@mail.gmail.com>
	<4EE9D453.6020503@linux.intel.com>
Date: Thu, 15 Dec 2011 13:25:34 +0200
Message-ID: <CABBYNZL3sCMtSQ4bVetdA25wRmoFZz8BWhsZoRcf4WpcCpi54w@mail.gmail.com>
Subject: Re: [RFC v5 1/8] audio: Move tel drivers to DBus interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

On Thu, Dec 15, 2011 at 1:04 PM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
>>
>>
>> I thought we had agreed in having the transport implemented directly
>> inside the agent, at least that was my proposal, otherwise it keeps
>> bluetoothd in the middle of the communication. It may not seem obvious
>> but we should target low latency as we are dealing with audio the
>> events need to be propagated fast.
>>
>> So instead of MediaTransportPath, what I suggest is sending the
>> endpoint itself e.g. string,object Endpoint Connection id and object
>> path of the MediaEndpoint to be used. This means the agent e.g. oFono
>> will have to create an object which implements
>> org.bluez.MediaTransport and then call
>> org.bluez.MediaEndpoint.SetConfiguration in the received object.
>>
>>
>
> If I understand correctly, passing Media Endpoint connection and path will
> imply that the telephony agent will have to manage the SCO connection, which
> means that we need to link the telephony agent with BlueZ libs.
> As far as I understand, one of the goals is to remove telephony code from
> BlueZ and bluetooth code from telephony daemon.
> Am I wrong ?
>
> Passing the MediaTransport allows to keep bluetooth part in BlueZ daemon and
> telephony part in telephony agent.

I wonder how you gonna be able to synchronize things like volume
changes then, because you can't depend on the signals since that don't
have the information of who did it, and in this case both agent and
endpoint will be talking to the same transport, besides imo having
events propagated quickly is much more important here. Now you are
right about SCO connections but that doesn't mean we cannot have
bluetoothd to still handle it and pass it back to the agent similarly
what we have done with ConnectFD in Serial.

-- 
Luiz Augusto von Dentz
