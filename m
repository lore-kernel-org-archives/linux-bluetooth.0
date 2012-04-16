Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B47E6C9@DNCE05.ent.ti.com>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B47E6C9@DNCE05.ent.ti.com>
Date: Mon, 16 Apr 2012 07:52:22 -0400
Message-ID: <CAJdJm_M7SCU3XyF6mJT2p-4f6tTFf==cAVojSFEXOJO7aXgKGQ@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ] LE Broadcaster/Observer API proposal
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Mon, Apr 16, 2012 at 4:03 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> On Broadcaster, multiple applications cannot broadcast the same Adv.
>> data type.
>
> This looks a bit problematic. What if two applications wish to broadcast services ? Or Service Solicitation ? or Service Data ? This could lead to problems.

Ok, we will clarify this on the document. Actually the "single
instance" verification is only applied to some AD types. It is not a
general rule.

> In addition, what about TX Power, or Flags - which module is responsible for sending this data ? Will it be public for any application, or will you have some kind of allowed Advertising packets for external application, and some reserved for system ?

As described on the Observer API, an application can filter which adv.
it is interested on, and its callback will only be called when that AD
type is present on the received adv. data. I don't think there is a
need currently to prevent certain AD types from being "observable".

> Are you planning to support duplicate filtering ?

Yes, but this cannot be enabled while device is in Observer mode. But
it is very useful for Central role to avoid overhead of adv. data
flood to userspace.

> What are you planning to do if the Advertising data exceeds the MAX ADV Data size ? Will you split the data somehow to multiple advertising packets ? What is the logic behind such a split ?

For now, there will be no split, the API will return some error if the
adv. data field is full. We can either pre-calculate the necessary
space for the data as it is registered by the Broadcaster application
(easier), or let the mgmt API return error if it cannot append more
data.

I think it is hard to build this logic inside BlueZ. I can't find any
reference on the Core spec how to properly do this split. So for now
applications will need to do this (e.g. using timers).

> How will you allow a user to select whether the data is to be sent over Advertising or Scan Response ?

We can have a separate boolean "BroadcasterScannable" adapter property
to handle this. It can be boolean because Broadcasters can only use
scannable (0x02) or non-connectable (0x03) adv. types.

Maybe it is interesting to add a new "bool scannable" parameter to
RegisterBroadcaster as well, this way, some application can quickly
alternate between scannable/non-scannable adv. by just toggling the
BroadcasterScannable property. What do you think?

> How will you allow a user or system to configure scan parameters for observer or advertising parameters for broadcasters ?

Some parameters can be inferred. Others will need adapter properties.
We need to verify case by case. New properties can be proposed as
necessary.

But I think this is a broader topic, because it is also a missing
feature for Central role as well. We need a separate discussion just
for the scan/advertising parameters topic. For instance, currently we
don't have a way to switch from the "fast connection" parameters
currently hard coded on the kernel.

> I'm guessing you will need to add more D-BUS Api's, or at least allow setting those parameters in the main.conf file ?

Yes. The selection between main.conf or Adapter properties needs to be
on a case by case. This initial proposal is to outline the base
architecture.

>> Note that this proposal does not describe the necessary mgmt API
>> changes. This
>> will come once we agree on the higher level D-Bus API. But it should be
>> expected that new commands for enabling/disabling observer/broadcaster
>> modes
>> and setting adv. data will be necessary, as well as modifying the
>> current
>> kernel code that ignores non-connectable advertising (which are used by
>> Observers).
> I also think you need to add PropertyChanged for Broadcasting, since you will need to stop broadcasting when connecting to a device, or when the power is turned off for example. In addition, you will need to figure out a way to synchronize all the GAP LE roles, according to what is allowed or disallowed.

Yes, we will add a few more information on this on the next version.

Thanks for your comments!
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
