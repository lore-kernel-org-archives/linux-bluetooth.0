Return-Path: <cyrus@holtmann.org>
From: "Ganir, Chen" <chen.ganir@ti.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC PATCH BlueZ] LE Broadcaster/Observer API proposal
Date: Tue, 17 Apr 2012 05:40:08 +0000
Message-ID: <F0070FBC0FB3174D8D11444EB2D5B0260B481B1E@DNCE05.ent.ti.com>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B0260B47E6C9@DNCE05.ent.ti.com>
 <CAJdJm_M7SCU3XyF6mJT2p-4f6tTFf==cAVojSFEXOJO7aXgKGQ@mail.gmail.com>
In-Reply-To: <CAJdJm_M7SCU3XyF6mJT2p-4f6tTFf==cAVojSFEXOJO7aXgKGQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lizardo,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Monday, April 16, 2012 2:52 PM
> To: Ganir, Chen
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: [RFC PATCH BlueZ] LE Broadcaster/Observer API proposal
> 
> Hi Chen,
> 
> On Mon, Apr 16, 2012 at 4:03 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> >> On Broadcaster, multiple applications cannot broadcast the same Adv.
> >> data type.
> >
> > This looks a bit problematic. What if two applications wish to
> broadcast services ? Or Service Solicitation ? or Service Data ? This
> could lead to problems.
> 
> Ok, we will clarify this on the document. Actually the "single
> instance" verification is only applied to some AD types. It is not a
> general rule.
> 
I suppose you need to specify exactly what types of advertising is supported, and how many advertisers may advertise the same data, and appropriate error code for a scenario when a user tries to advertise information which is already advertised by someone else.


> > In addition, what about TX Power, or Flags - which module is
> responsible for sending this data ? Will it be public for any
> application, or will you have some kind of allowed Advertising packets
> for external application, and some reserved for system ?
> 
> As described on the Observer API, an application can filter which adv.
> it is interested on, and its callback will only be called when that AD
> type is present on the received adv. data. I don't think there is a
> need currently to prevent certain AD types from being "observable".
> 
I was talking about the broadcaster role here. Flags AD is a GAP LE advertising which is supposed to be advertised in the Advertising data by the system (the flags should be set according to the system properties). In addition, you have the name (short/long), or TX Power, or Services or Manufacturer data, which usually describe the system and not a specific profile. We may have to split the functionality between the Broadcaster API (Profile specific advertising) and Adapter (GAP LE System advertising).

> > Are you planning to support duplicate filtering ?
> 
> Yes, but this cannot be enabled while device is in Observer mode. But
> it is very useful for Central role to avoid overhead of adv. data
> flood to userspace.
This is also very useful as observer role. Let's say you are observing for a sensor value. You would wither like to know the exact value periodically or would like to see only changed advertising. You may want to add this functionality to the API.

> 
> > What are you planning to do if the Advertising data exceeds the MAX
> ADV Data size ? Will you split the data somehow to multiple advertising
> packets ? What is the logic behind such a split ?
> 
> For now, there will be no split, the API will return some error if the
> adv. data field is full. We can either pre-calculate the necessary
> space for the data as it is registered by the Broadcaster application
> (easier), or let the mgmt API return error if it cannot append more
> data.
> 
> I think it is hard to build this logic inside BlueZ. I can't find any
> reference on the Core spec how to properly do this split. So for now
> applications will need to do this (e.g. using timers).
> 
I did not find this kind of logic in the specs as well. What if we build a splitting mechanism, and see how it works in IOP Tests? Maybe we need to get more feedback from the SIG or other LE peripheral/Broadcasters developers?

> > How will you allow a user to select whether the data is to be sent
> over Advertising or Scan Response ?
> 
> We can have a separate boolean "BroadcasterScannable" adapter property
> to handle this. It can be boolean because Broadcasters can only use
> scannable (0x02) or non-connectable (0x03) adv. types.
> 
What I meant here is that the user can select if the name of the device should appear in the advertising data, or in the scan response data, but the user can not select which advertising method is used. The only way to invoke the SCAN RSP is by an observer/central doing active scanning.

> Maybe it is interesting to add a new "bool scannable" parameter to
> RegisterBroadcaster as well, this way, some application can quickly
> alternate between scannable/non-scannable adv. by just toggling the
> BroadcasterScannable property. What do you think?
> 
Look above. The user has no control over this, and he does not need to know the details of the advertising method.

> > How will you allow a user or system to configure scan parameters for
> observer or advertising parameters for broadcasters ?
> 
> Some parameters can be inferred. Others will need adapter properties.
> We need to verify case by case. New properties can be proposed as
> necessary.
> 
> But I think this is a broader topic, because it is also a missing
> feature for Central role as well. We need a separate discussion just
> for the scan/advertising parameters topic. For instance, currently we
> don't have a way to switch from the "fast connection" parameters
> currently hard coded on the kernel.
> 
I agree. This needs more discussion and needs to be more flexible.

> > I'm guessing you will need to add more D-BUS Api's, or at least allow
> setting those parameters in the main.conf file ?
> 
> Yes. The selection between main.conf or Adapter properties needs to be
> on a case by case. This initial proposal is to outline the base
> architecture.
> 
Ok.

> >> Note that this proposal does not describe the necessary mgmt API
> >> changes. This
> >> will come once we agree on the higher level D-Bus API. But it should
> be
> >> expected that new commands for enabling/disabling
> observer/broadcaster
> >> modes
> >> and setting adv. data will be necessary, as well as modifying the
> >> current
> >> kernel code that ignores non-connectable advertising (which are used
> by
> >> Observers).
> > I also think you need to add PropertyChanged for Broadcasting, since
> you will need to stop broadcasting when connecting to a device, or when
> the power is turned off for example. In addition, you will need to
> figure out a way to synchronize all the GAP LE roles, according to what
> is allowed or disallowed.
> 
> Yes, we will add a few more information on this on the next version.
> 
> Thanks for your comments!


> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil



Thanks,
Chen Ganir

