Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20121112192607.GA6300@x220.P-661HNU-F1>
References: <1352385015-2127-1-git-send-email-mikel.astiz.oss@gmail.com>
	<20121112172346.GA6267@x220.P-661HNU-F1>
	<20121112192607.GA6300@x220.P-661HNU-F1>
Date: Tue, 13 Nov 2012 11:44:03 +0100
Message-ID: <CANT-zCXe=1N0qPKENoEvawjOj8WFu41+w16yz0BC3FvOrtVxLQ@mail.gmail.com>
Subject: Re: [RFC v0 0/7] Manager/Adapter transition to ObjectManager
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Nov 12, 2012 at 8:26 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mikel,
>
>> > Mikel Astiz (7):
>> >   manager: Expose default adapter using property
>> >   manager: Remove redundant D-Bus signals
>> >   manager: Remove redundant Adapters property
>> >   adapter: Remove redundant D-Bus signals
>> >   adapter: Remove DevicesFound signal
>> >   adapter: Remove redundant Devices property
>> >   adapter: Remove FindDevice method from D-Bus API
>> >
>> >  doc/adapter-api.txt |  32 +--------
>> >  doc/manager-api.txt |  28 +-------
>> >  src/adapter.c       | 187 +---------------------------------------------------
>> >  src/manager.c       | 103 +++++++----------------------
>> >  4 files changed, 29 insertions(+), 321 deletions(-)
>>
>> All patches except 5/7 (which needs a bit more discussion) have been
>> applied. Thanks.
>
> I had to revert all of these since I didn't realize you hadn't updated
> the test scripts (all of which broke with these patches). Also, it seems
> the DefaultAdapter patch is also broken since I never saw that property
> (e.g. with test/get-managed-objects). Please send a new patch set once
> you've got the scripts converted and the DefaultAdapter patch fixed.
> Thanks.

You're right, we should keep the test scripts in sync all the time. I
tried to warn you about this in the cover-letter but no problem, I
will send v2 with the changes you suggest.

Regarding the DefaultAdapter property, it was working for me, but I
was using the Properties interface. The test script you mention is
indeed not reporting the property, but this is because the root object
is not a "managed object", and this property is associated to the
root. This is no real issue IMO but still, for convenience reasons: do
you think we should move the org.bluez.Manager interface to some other
object path such as /adapters? As a side effect, this could make it
possible that clients filter out signals (i.e. InterfacesAdded) based
on the object path.

Cheers,
Mikel
