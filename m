Return-Path: <cyrus@holtmann.org>
Message-ID: <1345724676.29868.459.camel@pohly-mobl1.fritz.box>
Subject: Re: PBAP + two-step download
From: Patrick Ohly <patrick.ohly@intel.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bluez <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Date: Thu, 23 Aug 2012 14:24:36 +0200
In-Reply-To: <CANT-zCV-SW9B9JOoYV506yK+tH5xDNKeMtXf98NBDVJxVHyO5w@mail.gmail.com>
References: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
	 <CABBYNZL_P-if4JxM5K8jXvc86aJWXPfoY2xJAGpSV784XWABww@mail.gmail.com>
	 <1345707325.29868.403.camel@pohly-mobl1.fritz.box>
	 <CABBYNZJGDM7jg8ETGJSQHXUzqx6Lui1Jj8DhSya0+b+xhNp9Ew@mail.gmail.com>
	 <1345716915.29868.426.camel@pohly-mobl1.fritz.box>
	 <CABBYNZJ0TSX53ZF5_SgamiLSMFLAsrcFYVGNNk=QbEExn-AC2A@mail.gmail.com>
	 <1345721323.29868.443.camel@pohly-mobl1.fritz.box>
	 <CANT-zCV-SW9B9JOoYV506yK+tH5xDNKeMtXf98NBDVJxVHyO5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-08-23 at 13:59 +0200, Mikel Astiz wrote:
> Hi,
> 
> On Thu, Aug 23, 2012 at 1:28 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > On Thu, 2012-08-23 at 14:06 +0300, Luiz Augusto von Dentz wrote:
> >> Hi Patrick,
> >>
> >> On Thu, Aug 23, 2012 at 1:15 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> >> > On Thu, 2012-08-23 at 11:15 +0300, Luiz Augusto von Dentz wrote:
> >> >> On Thu, Aug 23, 2012 at 10:35 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> >> >> > On Thu, 2012-08-23 at 01:13 +0300, Luiz Augusto von Dentz wrote:
> >> >> > Even if we wanted to do it that way, it also wouldn't work at the moment
> >> >> > because the PullAll download doesn't include the information that is
> >> >> > necessary to get the full vcard later on. Any comments about my
> >> >> > proposals for fixing this (download into dir and/or add X- prop to
> >> >> > vcards)?
> 
> This is a limitation in the PBAP specification, not the API.

Oops. I was assuming (without checking) that the information was
available at the protocol level and just getting thrown away when
returning it to the caller.

That of course renders the entire discussion mute, there's nothing in
obexd that can be done to make the two-step download more efficient.
Thanks for clarifying that.

> >> > I also don't expect it to work reliably, for example when there is a
> >> > "John Doe, Sr." and John Doe, Jr." in the same address book. Phone
> >> > number also isn't unique (might have been added to two different persons
> >> > who are sharing the same address and phone).
> >>
> >> Yep, but that is the general problem isn't it?
> >
> > Right, but that doesn't mean that we have to start using a method that
> > is prone to this problem when there are better alternatives, like using
> > a known contact number in the current session and requesting that
> > directly.
> 
> I don't see any problem here. Every single pass (with or without
> photos) would replace the previous cache. So being smart to match
> contacts is just about optimizing the number of writes to the
> database. We don't need to merge any contact at this point.

You are right, the second pass can simply use the same approach as the
first one, with photo data as additional information. My goal was to
optimize the second pass by limiting it to contacts which have photos
and not having to do the matching again.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


