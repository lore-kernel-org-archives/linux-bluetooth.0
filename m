Return-Path: <cyrus@holtmann.org>
Message-ID: <4EEB5D07.1010104@linux.intel.com>
Date: Fri, 16 Dec 2011 16:00:23 +0100
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v5 1/8] audio: Move tel drivers to DBus interface
References: <1323853510-5195-1-git-send-email-frederic.danis@linux.intel.com> <1323853510-5195-2-git-send-email-frederic.danis@linux.intel.com> <CABBYNZKyY40pn-Sm_VSxHLqzbrQ9q-63Sjwmf=kvh4Dy1x9-bw@mail.gmail.com> <4EE9D453.6020503@linux.intel.com> <CABBYNZL3sCMtSQ4bVetdA25wRmoFZz8BWhsZoRcf4WpcCpi54w@mail.gmail.com> <4EEB0421.4030407@linux.intel.com> <CABBYNZJzczoFhUzvz3wJ5Ssxc8t191UFB7H8ckTygtDXWpNObA@mail.gmail.com>
In-Reply-To: <CABBYNZJzczoFhUzvz3wJ5Ssxc8t191UFB7H8ckTygtDXWpNObA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,

Le 16/12/2011 11:35, Luiz Augusto von Dentz a écrit :
> Hi Frederic,
>
> On Fri, Dec 16, 2011 at 10:41 AM, Frederic Danis
> <frederic.danis@linux.intel.com>  wrote:
>>
>> I wrote flowcharts for SCO connections and some AT commands (AT+NREC,
>> AT+VGS, ...) for the 2 approaches (side by side). This is available on
>> http://pastebin.com/sLBj7kpW
>
> Good work putting this together, probably we should add this to the
> documentation, btw this already shows us the latency won't be that
> great with this solution.

Thanks
Which solution is not great ? both ?

>> As you can see, when passing Media Transport path in NewConnection method,
>> the complexity is located during volume management.
>> I do not think that we can have synchronization problems if property changed
>> signal is sent in all cases.
>
> What do you mean by all cases, it has to be emitted in all cases and
> that is the problem, you don't know if the signal is a notification
> caused by calling SetProperty or someone else has changed the value.
> This became clear in the case of AT+VGS,AT+VGM, if you handle the
> signal its going to cause a ping-pong effect, obviously there are ways
> to ignore like checking if the value has really changed, but we have
> to be careful here since we had this type of problem in harmattan when
> the values changed too quickly it creates a loop.

Currently, if I take volume speaker as sample, BlueZ sends 
SpeakerGainChanged signal on reception of SetSpeakerGain method call 
(user action on the phone) or AT+VGS command (user action on headset).

This signal should only be sent by the Media Transport object, i.e. :
   - for "Transport path" proposal, this signal should be moved
	from headset.c to transport.c.
   - for "Media Endpoint" proposal, this signal should be moved
	to the Media Transport of the telephony agent.

I do not understand why a ping-pong effect should start (no application 
should react to SpeakerGainChanged signal by a SetSpeakerGain method call).

> Btw, Im not so sure this currently works because you should only be
> able to set something if you have acquired the fd, have you changed
> that so the agent can also do it?

Not yet, but your are right this test should be removed.
We must make it possible to set Noise Reduction, Echo Cancellation, 
speaker or microphone gain values before the audio is connected.
Those values should be stored in the Media Transport object.

>> When moving MediaTransport to telephony agent (i.e. oFono), complexity moves
>> to SCO connections, passing SCO fd through oFono to PulseAudio.
>> This will also imply to remove code from Media Transport, which will
>> complicate this set of patches.
>> It will also break similarity between A2DP and HSP/HFP (currently both media
>> transport code are in BlueZ, breaking that will set one transport in BlueZ,
>> the other not).
>
> True, but are you sure the agent wont have to deal directly with the
> SCO connection? Afaik there were some AT commands to do the audio
> transfer, although for HFP it seems to be directly by
> connecting/disconnecting SCO.
>

My understanding is that BlueZ/oFono are not involved in decision to 
set-up or not the SCO connection, this decision should be taken by 
PulseAudio or a policy manager component, and SCO connection will be 
performed on Acquire method called by PulseAudio.

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Centre
frederic.danis@intel.com                              Intel Corporation

