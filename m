Return-Path: <cyrus@holtmann.org>
Message-ID: <4EEB0421.4030407@linux.intel.com>
Date: Fri, 16 Dec 2011 09:41:05 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v5 1/8] audio: Move tel drivers to DBus interface
References: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com> <1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com> <CABBYNZKyY40pn-Sm_VSxHLqzbrQ9q-63Sjwmf=kvh4Dy1x9-bw@mail.gmail.com> <4EE9D453.6020503@linux.intel.com> <CABBYNZL3sCMtSQ4bVetdA25wRmoFZz8BWhsZoRcf4WpcCpi54w@mail.gmail.com>
In-Reply-To: <CABBYNZL3sCMtSQ4bVetdA25wRmoFZz8BWhsZoRcf4WpcCpi54w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Le 15/12/2011 12:25, Luiz Augusto von Dentz a écrit :
> Hi Frederic,
>
> On Thu, Dec 15, 2011 at 1:04 PM, Frederic Danis
> <frederic.danis@linux.intel.com>  wrote:
>>>
>>>
>>> I thought we had agreed in having the transport implemented directly
>>> inside the agent, at least that was my proposal, otherwise it keeps
>>> bluetoothd in the middle of the communication. It may not seem obvious
>>> but we should target low latency as we are dealing with audio the
>>> events need to be propagated fast.
>>>
>>> So instead of MediaTransportPath, what I suggest is sending the
>>> endpoint itself e.g. string,object Endpoint Connection id and object
>>> path of the MediaEndpoint to be used. This means the agent e.g. oFono
>>> will have to create an object which implements
>>> org.bluez.MediaTransport and then call
>>> org.bluez.MediaEndpoint.SetConfiguration in the received object.
>>>
>>>
>>
>> If I understand correctly, passing Media Endpoint connection and path will
>> imply that the telephony agent will have to manage the SCO connection, which
>> means that we need to link the telephony agent with BlueZ libs.
>> As far as I understand, one of the goals is to remove telephony code from
>> BlueZ and bluetooth code from telephony daemon.
>> Am I wrong ?
>>
>> Passing the MediaTransport allows to keep bluetooth part in BlueZ daemon and
>> telephony part in telephony agent.
>
> I wonder how you gonna be able to synchronize things like volume
> changes then, because you can't depend on the signals since that don't
> have the information of who did it, and in this case both agent and
> endpoint will be talking to the same transport, besides imo having
> events propagated quickly is much more important here. Now you are
> right about SCO connections but that doesn't mean we cannot have
> bluetoothd to still handle it and pass it back to the agent similarly
> what we have done with ConnectFD in Serial.
>

I wrote flowcharts for SCO connections and some AT commands (AT+NREC, 
AT+VGS, ...) for the 2 approaches (side by side). This is available on 
http://pastebin.com/sLBj7kpW

As you can see, when passing Media Transport path in NewConnection 
method, the complexity is located during volume management.
I do not think that we can have synchronization problems if property 
changed signal is sent in all cases.

When moving MediaTransport to telephony agent (i.e. oFono), complexity 
moves to SCO connections, passing SCO fd through oFono to PulseAudio.
This will also imply to remove code from Media Transport, which will 
complicate this set of patches.
It will also break similarity between A2DP and HSP/HFP (currently both 
media transport code are in BlueZ, breaking that will set one transport 
in BlueZ, the other not).

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

