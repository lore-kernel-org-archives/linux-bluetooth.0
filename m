Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1345721323.29868.443.camel@pohly-mobl1.fritz.box>
References: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
	<CABBYNZL_P-if4JxM5K8jXvc86aJWXPfoY2xJAGpSV784XWABww@mail.gmail.com>
	<1345707325.29868.403.camel@pohly-mobl1.fritz.box>
	<CABBYNZJGDM7jg8ETGJSQHXUzqx6Lui1Jj8DhSya0+b+xhNp9Ew@mail.gmail.com>
	<1345716915.29868.426.camel@pohly-mobl1.fritz.box>
	<CABBYNZJ0TSX53ZF5_SgamiLSMFLAsrcFYVGNNk=QbEExn-AC2A@mail.gmail.com>
	<1345721323.29868.443.camel@pohly-mobl1.fritz.box>
Date: Thu, 23 Aug 2012 13:59:47 +0200
Message-ID: <CANT-zCV-SW9B9JOoYV506yK+tH5xDNKeMtXf98NBDVJxVHyO5w@mail.gmail.com>
Subject: Re: PBAP + two-step download
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bluez <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Aug 23, 2012 at 1:28 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> On Thu, 2012-08-23 at 14:06 +0300, Luiz Augusto von Dentz wrote:
>> Hi Patrick,
>>
>> On Thu, Aug 23, 2012 at 1:15 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> > On Thu, 2012-08-23 at 11:15 +0300, Luiz Augusto von Dentz wrote:
>> >> On Thu, Aug 23, 2012 at 10:35 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
>> >> > On Thu, 2012-08-23 at 01:13 +0300, Luiz Augusto von Dentz wrote:
>> >> >>  When we connect we attempt to
>> >> >> download the full phonebook which is cached for fast lookup but while
>> >> >> ringing we can download the full vcard including the picture.

This would be too slow, adding a noticeable delay to the user.

>> >> > Even if we wanted to do it that way, it also wouldn't work at the moment
>> >> > because the PullAll download doesn't include the information that is
>> >> > necessary to get the full vcard later on. Any comments about my
>> >> > proposals for fixing this (download into dir and/or add X- prop to
>> >> > vcards)?

This is a limitation in the PBAP specification, not the API.

>> >> What about Search + Pull? If you have download the contact already you
>> >> have the name then you search by name, otherwise search by number,
>> >> with the response you can download the vcard with Pull.
>> >
>> > Isn't that very inefficient? One search request for each contact?
>>
>> It is, that why we need to download this info before hand, but since
>> we cannot depend on the contact handle being unique across the
>> sessions
>
> We don't - the two steps would be in the same PBAP session. In the
> future it might even work across sessions, once the Bluetooth consortium
> adds cross-session references (planned for 2013, as far as I know).

The vcard handled are stable within the session, but AFAIK there is no
link between the PullAll result and the vcard handles. Searching
doesn't solve anything because you still need to use PullAll
(individually pulling is too slow), so you still miss the link.

>> > I also don't expect it to work reliably, for example when there is a
>> > "John Doe, Sr." and John Doe, Jr." in the same address book. Phone
>> > number also isn't unique (might have been added to two different persons
>> > who are sharing the same address and phone).
>>
>> Yep, but that is the general problem isn't it?
>
> Right, but that doesn't mean that we have to start using a method that
> is prone to this problem when there are better alternatives, like using
> a known contact number in the current session and requesting that
> directly.

I don't see any problem here. Every single pass (with or without
photos) would replace the previous cache. So being smart to match
contacts is just about optimizing the number of writes to the
database. We don't need to merge any contact at this point.

Cheers,
Mikel
