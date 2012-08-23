Return-Path: <cyrus@holtmann.org>
Message-ID: <1345721323.29868.443.camel@pohly-mobl1.fritz.box>
Subject: Re: PBAP + two-step download
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Date: Thu, 23 Aug 2012 13:28:43 +0200
In-Reply-To: <CABBYNZJ0TSX53ZF5_SgamiLSMFLAsrcFYVGNNk=QbEExn-AC2A@mail.gmail.com>
References: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
	 <CABBYNZL_P-if4JxM5K8jXvc86aJWXPfoY2xJAGpSV784XWABww@mail.gmail.com>
	 <1345707325.29868.403.camel@pohly-mobl1.fritz.box>
	 <CABBYNZJGDM7jg8ETGJSQHXUzqx6Lui1Jj8DhSya0+b+xhNp9Ew@mail.gmail.com>
	 <1345716915.29868.426.camel@pohly-mobl1.fritz.box>
	 <CABBYNZJ0TSX53ZF5_SgamiLSMFLAsrcFYVGNNk=QbEExn-AC2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-08-23 at 14:06 +0300, Luiz Augusto von Dentz wrote:
> Hi Patrick,
> 
> On Thu, Aug 23, 2012 at 1:15 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > On Thu, 2012-08-23 at 11:15 +0300, Luiz Augusto von Dentz wrote:
> >> On Thu, Aug 23, 2012 at 10:35 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> >> > On Thu, 2012-08-23 at 01:13 +0300, Luiz Augusto von Dentz wrote:
> >> >>  When we connect we attempt to
> >> >> download the full phonebook which is cached for fast lookup but while
> >> >> ringing we can download the full vcard including the picture.
> >> >
> >> > Even if we wanted to do it that way, it also wouldn't work at the moment
> >> > because the PullAll download doesn't include the information that is
> >> > necessary to get the full vcard later on. Any comments about my
> >> > proposals for fixing this (download into dir and/or add X- prop to
> >> > vcards)?
> >>
> >> What about Search + Pull? If you have download the contact already you
> >> have the name then you search by name, otherwise search by number,
> >> with the response you can download the vcard with Pull.
> >
> > Isn't that very inefficient? One search request for each contact?
> 
> It is, that why we need to download this info before hand, but since
> we cannot depend on the contact handle being unique across the
> sessions

We don't - the two steps would be in the same PBAP session. In the
future it might even work across sessions, once the Bluetooth consortium
adds cross-session references (planned for 2013, as far as I know).

> > I also don't expect it to work reliably, for example when there is a
> > "John Doe, Sr." and John Doe, Jr." in the same address book. Phone
> > number also isn't unique (might have been added to two different persons
> > who are sharing the same address and phone).
> 
> Yep, but that is the general problem isn't it?

Right, but that doesn't mean that we have to start using a method that
is prone to this problem when there are better alternatives, like using
a known contact number in the current session and requesting that
directly.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


