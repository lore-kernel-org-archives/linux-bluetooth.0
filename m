Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121111131921.GA4405@x220>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1352385015-2127-6-git-send-email-mikel.astiz.oss@gmail.com>
	<20121111131921.GA4405@x220>
Date: Mon, 12 Nov 2012 09:45:44 +0100
Message-ID: <CANT-zCU0mUgMRoNxO3Gg_jOb3ivzUqvoN6PyrGsbWvuWKbvFOQ@mail.gmail.com>
Subject: Re: [RFC v0 5/7] adapter: Remove DevicesFound signal
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Sun, Nov 11, 2012 at 2:19 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
> On Thu, Nov 08, 2012, Mikel Astiz wrote:
>> ObjectManager reports the D-Bus interfaces of all known devices,
>> including the ones detected during discovery. Therefore this signal is
>> not required.
>> ---
>>  doc/adapter-api.txt |  13 ++-----
>>  src/adapter.c       | 102 ++--------------------------------------------------
>>  2 files changed, 4 insertions(+), 111 deletions(-)
>
> If you look at the commit history you'll see that this signal was added
> after the introduction of object manager and was part of the patches
> that removed the old DeviceFound signal.

I didn't realize this was such a late addition. I guess I should have
opened the discussion before, sorry for that.

> You're right in that our original plan was to replace the device
> discovery completely with ObjectManager signals but that turned out to
> be infeasible in practice. Even the python script for doing discovery
> ended up being quite complex (meaning most other languages would be even

The ObjectManager approach might make our clients more complex but I
don't think this should be very strong argument to introduce
duplication in our APIs. I would suggest we consider compensating this
using utility libraries, since you have very similar problems
everywhere in the D-Bus API, for example with Adapter.FindDevice.

Unless there is some performance gain, we should IMO keep our APIs as
compact as possible, specially for the 5.0 release, where we could
extend the API in later versions.

> worse) and we didn't get any signals for discovered devices that already
> existed in the bluetoothd object hierarchy (since nothing changes for
> them from an ObjectManager perspective).

I agree this second point would be a strong enough argument. However,
can't we solve this problem in a nicer and more orthogonal
property-oriented way?

I can think of a solution that might fit and would also be useful for
other use-cases: we could add a property to each device which holds a
timestamp representing when this particular devices was "seen"
(discovered or connected-to) for the last time. A discovery client
would have to check the timestamp range he is interested in. I could
write some code if there is any interest.

Having said that, I'm not completely against the DevicesFound
approach, but I guess this would be the moment to consider other
approaches as well.

> Due to these issues we decided to reintroduce a dedicated signal for
> device discovery and at the same time fix the bottle neck we've seen
> during the past years where the high frequency of signals in a busy
> environment (e.g. UPF) consumes a lot of resources.

I can't imagine how DevicesFound could remove any D-Bus bottleneck
since it's a duplicated signal. As I understand, ObjectManager would
emit the InterfaceAdded signals in any case, so I don't see any real
benefit here.

> The DevicesFound signal is emitted once a second and contains all
> devices found since the last period. If no device was found during the
> last period the signal is sent as soon as the first device is found.
> There's also an (adjustable through a define, right now 5) maximum size
> for the list length which forces the signal to be sent as soon as the
> limit is reached.

The only gain I can think of is in case we had a client that listens
to DevicesAdded but is not interested in ObjectManager/Properties
signals. However this seems unlikely and even insignificant, since
most of the clients would anyway be waking up every time an interface
is added, right?

Cheers,
Mikel
