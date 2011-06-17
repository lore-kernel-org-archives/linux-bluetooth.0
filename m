Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8DCFA6B89B9E70418E47A2348D55495A4781711C@banasiexm01.ASIA.ROOT.PRI>
References: <4df91d74.0b73650a.190f.17ad@mx.google.com>
	<1308175855.2196.7.camel@aeonflux>
	<BANLkTikuyizJeF9xhAo22dv8LJ+JxeTskg@mail.gmail.com>
	<1308191356.2196.9.camel@aeonflux>
	<8DCFA6B89B9E70418E47A2348D55495A478165D6@banasiexm01.ASIA.ROOT.PRI>
	<BANLkTimiLXWNfv=hwzDTMd7U8nphUSvMQg@mail.gmail.com>
	<8DCFA6B89B9E70418E47A2348D55495A4781711C@banasiexm01.ASIA.ROOT.PRI>
Date: Fri, 17 Jun 2011 08:10:18 -0400
Message-ID: <BANLkTimXg6_3f25sXCtZ_YU3VoWUayqbFQ@mail.gmail.com>
Subject: Re: GATT and GATT based Profiles architecture - Query
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ajay Pillai <Ajay.Pillai@csr.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ajay,

On Fri, Jun 17, 2011 at 5:30 AM, Ajay Pillai <Ajay.Pillai@csr.com> wrote:
> I saw another post from you which seemed to indicate that the GATT DBUS API is not
> meant to be used extensively in systems for implementing profiles or for general App integration.
> (Please correct me if I interpreted wrong)

The current API implementation (documented in doc/attribute-api.txt)
is not suitable for implementing external profiles, correct.

> However this information coupled with the tightly coupled nature of the GATT based profiles (as derived from your reply) in BlueZ, is giving
> me an impression that the current development direction in BlueZ can severely curb the freedom of device implementers
> to use the capability of GATT. (not sure if you have discussed this before an concluded, in which case I would be interested to be pointed to another post)

If these implementers create a BlueZ plugin (in C), they have the full
power of BlueZ GATT stack. Of course, there are the licensing
requirements (I suppose).

> The way I see it is that the pace of profile spec ratification in the SIG or the pace of development of profiles in BlueZ will probably be too slow
> for the larger community of device manufacturers and Application developers for platforms like Android.
> Besides, the usecases being addressed by the profiles in pipeline would probably be only a fraction of the real potential of GATT, which device manufacturers might want to tap into.

I agree. But note that currently we lack use cases which justify a
complete GATT API over D-Bus. Feel free to discuss your own use cases,
and propose an API for them.

> This makes me think that more focus needs to be given to the GATT DBUS API, than what is implied by your earlier post.

So far we have been focusing on implementing officially adopted
profiles, the current D-Bus API was proposed and implemented at a time
when there were no actual GATT profiles, and so far it has been used
for testing purposes.

> Do you have plans for making the GATT DBUS API more feature complete?

At least on the team I work, there are no plans for that. But I wanted
to bring up the discussion anyway, thus my e-mail.

> Do you see problems in including GATT Servers too in it?
> Are you open to stronger contributions to the GATT DBUS API? ( I am interested to do that)

I believe we are always open to discussions and contributions :). But
before you begin implementing your proposal, I'd suggest discussing a
draft API first on this list. I'm sure there are other parties
interested on helping on that as well.

> You posted earlier:
>>To be able to implement a full GATT profile externally (client role),
>>we would need to expose the full GATT (or even ATT) stack over D-Bus.
>>For instance, have methods for each GATT operation, and signals for
>>notifications/indications.
>
>>Is that really what we want? If yes, the Attribute API could have to
>>be severely redesigned. It was not (and currently still not is)
>>intended for that.
> Could you elaborate what is the scope of this redesign?

If you take a look on doc/attribute-api.txt on BlueZ source, you might
identify some limitations already (assuming you already have some use
cases in mind):

* There are no way to access custom characteristic descriptors (only
presentation format and user description descriptors are currently
exposed). This is a major limitation if you want to access custom
descriptors.
* No D-Bus API e.g. the server side (only client side) for managing
the Attribute server
* Notifications/indications are registered per server, not per
characteristic (this might be a limitation or not)
* Currently no way to handle cases where new services/characteristics
are added "on the fly" on the server side (i.e. suport for the
"Service Changed" GATT characteristic). Idea: new services or
characteristics could be announced as D-Bus signals.

> I am interested to know if system integrators can have a mutually exclusive choice between external profiles using BlueZ GATT and BlueZ built-in profiles.

They could coexist just fine. But for that to work, the attribute
server database needs to be managed by BlueZ, which would allocate
attribute handles as necessary. Also note that UUIDs would need to be
allocated for proprietary profiles (not sure how BT SIG handles that).

Also consider contributing to the officially adopted profiles (once
they are actually adopted). I really hope we don't see multiple
implementations of an adopted GATT profile.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
