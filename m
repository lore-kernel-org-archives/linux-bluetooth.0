Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B4535EE@DNCE02.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B453531@DNCE02.ent.ti.com>
	<CAJdJm_O0Ev=ykKC0d9AHTTA8EpO6yNxmaAzcgAadc_zrNzewyw@mail.gmail.com>
	<F0070FBC0FB3174D8D11444EB2D5B0260B4535EE@DNCE02.ent.ti.com>
Date: Wed, 21 Mar 2012 12:06:30 -0400
Message-ID: <CAJdJm_PDXifd-vYDj5AFcE_9+S1n9q2iVoQswPeVO79k1HJbdg@mail.gmail.com>
Subject: Re: RFC: GATT Client support for Included services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

2012/3/21 Ganir, Chen <chen.ganir@ti.com>:
> This was my meaning. When discovering primaries, we run the find_included on each one of the primaries. However, we do need to find some mechanism to allow us to avoid adding duplicates (a primary service which is included before the actual included primary is actually found on the server), and figure out how to add the secondary services, which will not be found by "discover_primary_services"

It should be simple to avoid duplicates because we always know the
start/end handles of the service being included. If they match an
existing service, we should not include them again.

If that turns out to be too expensive, it can also be delegated to
each profile. I.e. the HID profile probe() can trigger the included
service search because the profile definition mentions that included
services are allowed/required.

>> > In addition to that, we will need to add a list of included services
>> to each service, to point to any included services it may have. This
>> list must point to an already existing service structure, and cleanup
>> procedures must be updated to clear all lists referencing a service
>> when needed.
>>
>> For secondary services, it may actually need to allocate space for it
>> if it was not included yet.
>>
> What do you mean allocate space for it ? Where exactly ?

A secondary service will have its characteristics, we need to store
them somewhere, after we find them while looking for included
services.

>> > The "IncludedBy" In addition, a list of services including this
>> service will also be provided for clarity.
>>
>> I don't see this necessary, and it may become complex to keep all
>> these lists in sync. I suggest not having this "IncludedBy" for now.
>>
> I think that we will need that. For example, you will need to know which battery belongs to which HID Service, if included inside it.

I don't think there is a "belongs to" relationship here. Other
profiles (on a multi-profile context) may also use "share" the same
battery.

But wait, to which D-Bus interface are we talking here? Are you
proposing changes to the Generic Attribute API?

If not, I suppose a HID specific or Battery specific D-Bus interface
does not care about this GATT level information. E.g. for HID, you
want to see a "Batteries" property instead of service includes.

>> > Lizardo, Claudio - I'm waiting for your inputs before I start
>> implementing this and adding this functionality as a set of patches to
>> the ML.
>>
>> It would be nice if you could share your development tree as well
>> (publicly, if that's allowed by your company). Otherwise, I think we
>> have the potential to conflict on development :)
>>
> Lizardo, I think that once I start working on that, I can open a repository on github for sharing the work. I would prefer to start the base work, and then share the tree after I feel comfortable with the base code, if that’s ok. If you guys insist on doing it yourselves, let me know, and share your working tree so I can contribute as well.

We already started implementation (we will send a heads up here with
the branch to avoid duplicated effort). But it is currently focused on
the internal C API (extending the current service discovery
procedure). The D-Bus API is not covered.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
