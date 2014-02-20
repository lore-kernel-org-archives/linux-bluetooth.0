Return-Path: <cyrus@holtmann.org>
Message-ID: <1392893523.5772.2.camel@pohly-mobl1.fritz.box>
Subject: Re: [PATCH BlueZ 8/8] doc/obex-api: Update documentation
From: Patrick Ohly <patrick.ohly@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 20 Feb 2014 11:52:03 +0100
In-Reply-To: <CABBYNZL82SJPZws+b0syb0nx8OVHCwfB4Tr3cDem9JWBvy5oCQ@mail.gmail.com>
References: <1392393184-15266-1-git-send-email-luiz.dentz@gmail.com>
	 <1392393184-15266-8-git-send-email-luiz.dentz@gmail.com>
	 <1392714551.5951.275.camel@pohly-mobl1.fritz.box>
	 <CABBYNZ+-hu0G6cja-uBWPFuywj7S+bBDhitNoBhUnFnTFjYDcA@mail.gmail.com>
	 <1392742461.6118.25.camel@pohly-mobl1.fritz.box>
	 <CABBYNZL82SJPZws+b0syb0nx8OVHCwfB4Tr3cDem9JWBvy5oCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-02-19 at 19:11 +0200, Luiz Augusto von Dentz wrote:
> Hi Patrick,
> 
> On Tue, Feb 18, 2014 at 6:54 PM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > On Tue, 2014-02-18 at 11:30 +0200, Luiz Augusto von Dentz wrote:
> >> Hi Patrick,
> >>
> >> On Tue, Feb 18, 2014 at 11:09 AM, Patrick Ohly <patrick.ohly@intel.com> wrote:
> > I think I would prefer to *not* get errors when Suspend() is called on
> > an already suspended transfer or when Resume() is called on a running
> > transfer. The rationale is that the caller will typically only care
> > about the end result and not so much whether it was the one who
> > triggered the change. If we remove NotInProgress resp. InProgress errors
> > from the API, then such a caller can treat all errors as fatal problem,
> > without having to check the exact error.
> 
> Actually the NotInProgress error is for transfer queued, I guess for
> this case it makes sense to return an error since otherwise we would
> have to queue commands to be send when the transfer becomes active I
> believe this should probably be considered an error.

Agreed, if suspending can't be done, then an error needs to be returned.

It would be good to add information about the error to the
documentation, so that apps get at least some hint what they are
supposed to do in case of such an error (like aborting the queued
transfer (most likely) or waiting for it to start before suspending it
(seems a bit odd, but perhaps it is useful sometimes)).

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.



