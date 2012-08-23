Return-Path: <cyrus@holtmann.org>
Message-ID: <1345707325.29868.403.camel@pohly-mobl1.fritz.box>
Subject: Re: PBAP + two-step download
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Jeremy Whiting <jpwhiting@kde.org>
Date: Thu, 23 Aug 2012 09:35:25 +0200
In-Reply-To: <CABBYNZL_P-if4JxM5K8jXvc86aJWXPfoY2xJAGpSV784XWABww@mail.gmail.com>
References: <1345651474.29868.344.camel@pohly-mobl1.fritz.box>
	 <CABBYNZL_P-if4JxM5K8jXvc86aJWXPfoY2xJAGpSV784XWABww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2012-08-23 at 01:13 +0300, Luiz Augusto von Dentz wrote:
> Hi Patrick,
> 
> On Wed, Aug 22, 2012 at 7:04 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > Hello!
> >
> > For IVI use cases, Mikel and I were discussing how a phone's address
> > book could be cached intelligently by an IVI head unit. The rough idea
> > is that first all contacts get pulled without PHOTO data. This data is
> > used to match the current phone address book with some potentially
> > cached local data. Then in a second step, the PHOTO data of all contacts
> > is requested (*). This is all done in the same PBAP session, so the
> > numbering of contacts is the same in both steps.
> >
> > The goal is to get the essential data (names, phone numbers) quickly and
> > then add pictures later on.
> 
> I think it is a good idea, but what about to download the full contact
> vcard only when it is to be displayed?

There are other use cases that depend on having all data locally, for
example merging address books from several different phones into a
single unified address book. Browsing that unified address book is
expected to include photo data, so loading that on demand isn't an
option.

What you describe is part of the plan, as fallback when the data is not
(yet) available locally.

>  When we connect we attempt to
> download the full phonebook which is cached for fast lookup but while
> ringing we can download the full vcard including the picture.

Even if we wanted to do it that way, it also wouldn't work at the moment
because the PullAll download doesn't include the information that is
necessary to get the full vcard later on. Any comments about my
proposals for fixing this (download into dir and/or add X- prop to
vcards)?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.


