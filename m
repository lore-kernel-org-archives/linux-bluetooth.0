Return-Path: <cyrus@holtmann.org>
Message-ID: <4C4E4333.9090707@Atheros.com>
Date: Tue, 27 Jul 2010 07:53:47 +0530
From: Suraj <suraj@Atheros.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Suraj Sumangala <Suraj.Sumangala@Atheros.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Jothikumar Mothilal <Jothikumar.Mothilal@Atheros.com>
Subject: Re: [RFC v2] Bluetooth: Provide access to reassembled Rx packets
References: <1280126094-18004-1-git-send-email-suraj@atheros.com>	 <1280157203.2621.48.camel@localhost.localdomain>	 <4C4DD292.60001@Atheros.com> <1280184169.2621.63.camel@localhost.localdomain>
In-Reply-To: <1280184169.2621.63.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 7/27/2010 4:12 AM, Marcel Holtmann wrote:
> Hi Suraj,
>
>>>> Provide the HCI transport driver access to reassembled Rx packets before
>>>> sending to Host.
>>>
>>> you still haven't answered my question on why you want this. It makes no
>>> sense to me to relay all packets back to the driver. That is just a
>>> waste of CPU cycles.
>>
>> The requirement is simple. The driver need to know the status of certain
>> vendor specific commands by checking the parameters of Command complete
>> events.
>
> then implement something that handles vendor specific commands and
> events properly. This proposal is insane and will not get merged.
>
>> We also have a requirements to verify the status of HCI RESET command to
>> update power management feature.
>
> Then implement something that can track the status of HCI reset
> properly.

Is there any option for the transport driver to get status of certain 
commands from the HCI core?

if it is not there, can you advice how that can be done efficiently?

>
>> If you are concerned about CPU cycle, we can limit this only for HCI
>> events and not for ACL/SCO packets.
>>
>> Please do let me know if you think there is an alternate way so that the
>> HCI transport driver can access to HCI events.
>
> So first of all, lets make something perfectly clear. All Bluetooth
> drivers are _transport_ drivers. They don't need to know what they are
> transporting. And in addition you should not look into the packets that
> you are sending or receiving. The Bluetooth core does that HCI packet
> parsing.
If that is the case, should we be implementing something similar to the 
way HCI_LL protocol does it? By defining custom packet types and parsing 
it to get board specific information?

>
> This is how I want it and how this is going to stay. Everything else is
> an insane approach and cost every single driver overhead. In addition
> the lifetime rules of SKBs become more and more complicated. That is a
> pretty bad thing. It will result in excessive memory usage and will
> cause problems.
>
> Regards
>
> Marcel
>
>

Regards
Suraj
