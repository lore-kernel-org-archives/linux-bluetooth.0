Return-Path: <cyrus@holtmann.org>
Message-ID: <4EF99954.9000409@linux.intel.com>
Date: Tue, 27 Dec 2011 11:09:24 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v5 1/8] audio: Move tel drivers to DBus interface
References: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com> <1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com> <CABBYNZKyY40pn-Sm_VSxHLqzbrQ9q-63Sjwmf=kvh4Dy1x9-bw@mail.gmail.com> <4EE9D453.6020503@linux.intel.com> <CABBYNZL3sCMtSQ4bVetdA25wRmoFZz8BWhsZoRcf4WpcCpi54w@mail.gmail.com> <4EEB0421.4030407@linux.intel.com> <CABBYNZJzczoFhUzvz3wJ5Ssxc8t191UFB7H8ckTygtDXWpNObA@mail.gmail.com> <4EEB5D07.1010104@linux.intel.com> <CABBYNZJQF2yDtcXc01i_UUjUx-KUC5r-BFLe-sNMqY0ajYsWGA@mail.gmail.com>
In-Reply-To: <CABBYNZJQF2yDtcXc01i_UUjUx-KUC5r-BFLe-sNMqY0ajYsWGA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Le 17/12/2011 11:15, Luiz Augusto von Dentz a écrit :
>>> Good work putting this together, probably we should add this to the
>>> documentation, btw this already shows us the latency won't be that
>>> great with this solution.
>>
>>
>> Thanks
>> Which solution is not great ? both ?
>
> Both have problems, endpoint add extra round trips per connection
> which can be a problem for audio transfer/SCO reconnections.

OK, So I will continue with "Transport path" proposal.

>> Currently, if I take volume speaker as sample, BlueZ sends
>> SpeakerGainChanged signal on reception of SetSpeakerGain method call (user
>> action on the phone) or AT+VGS command (user action on headset).
>>
>> This signal should only be sent by the Media Transport object, i.e. :
>>   - for "Transport path" proposal, this signal should be moved
>>         from headset.c to transport.c.
>>   - for "Media Endpoint" proposal, this signal should be moved
>>         to the Media Transport of the telephony agent.
>>
>> I do not understand why a ping-pong effect should start (no application
>> should react to SpeakerGainChanged signal by a SetSpeakerGain method call).
>
> Yep, IMO the gains/volume need to be moved to transport, btw both
> agent and endpoint need to react to events such as volume change, the
> agent need to send AT+VG commands and the endpoint notify the
> application when the volume change completes.

In case of Telephony agent implementing the Audio Gateway part of 
HSP/HFP, it will send a +VG unsolicited result, which will not get reply 
from the Headset.
So, endpoint will not be able to notify the application when the volume 
change completes.

> Now, I don't think it is impossible to handle this it is just tricky
> and we cannot detect errors easily, but volume changes is already
> tricky (see PulseAudio), so I think it might be fine to try this first
> and see the results.

OK

>> Not yet, but your are right this test should be removed.
>> We must make it possible to set Noise Reduction, Echo Cancellation, speaker
>> or microphone gain values before the audio is connected.
>> Those values should be stored in the Media Transport object.
>
> Whenever you give the transport object you have to give permission to
> the agent, but don't simplify let any process changes those values.

OK, I will add Telephony agent to the test.

>>> True, but are you sure the agent wont have to deal directly with the
>>> SCO connection? Afaik there were some AT commands to do the audio
>>> transfer, although for HFP it seems to be directly by
>>> connecting/disconnecting SCO.
>>>
>>
>> My understanding is that BlueZ/oFono are not involved in decision to set-up
>> or not the SCO connection, this decision should be taken by PulseAudio or a
>> policy manager component, and SCO connection will be performed on Acquire
>> method called by PulseAudio.
>
> Audio transfer is both ways, but apparently there is no AT command for
> triggering it, iirc it was part of HSP spec, but I don't think we have
> to worry too much about HSP nowadays.

OK

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

