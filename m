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
Date: Thu, 23 Aug 2012 14:57:16 +0300
Message-ID: <CABBYNZLg00LmmqxZz6awynFXG1+H7eZBjnVPNnr5KKu1dtfBHA@mail.gmail.com>
Subject: Re: PBAP + two-step download
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

On Thu, Aug 23, 2012 at 2:28 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
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
>> >> >
>> >> > Even if we wanted to do it that way, it also wouldn't work at the moment
>> >> > because the PullAll download doesn't include the information that is
>> >> > necessary to get the full vcard later on. Any comments about my
>> >> > proposals for fixing this (download into dir and/or add X- prop to
>> >> > vcards)?
>> >>
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

I suppose this will also mean contacts/handle updates will also have
to be supported. Anyway it is not ready now so we can't really depend
on that.

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

Well it seems that your method is also error prone, because there is
still a chance the contact handle has been invalidated, removed or
something like that which can cause Pull to fail. Anyway when I said
it is the general problem I was referring to number or name mapping to
multiple contacts and that doesn't matter if you resolve then locally
or search first to only then pull with handles found, the fact is you
can find more than one matching regardless of method you use.

-- 
Luiz Augusto von Dentz
