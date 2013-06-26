Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jun 2013 22:49:58 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [RFC 1/2] gdbus: Add g_dbus_flush_properties()
Message-ID: <20130626194958.GA4727@x220.P-661HNU-F1>
References: <1366307424-19825-1-git-send-email-vinicius.gomes@openbossa.org>
 <CABBYNZJFT18e172brOH1QR2WCrZWEkxUsw3vwp8YDKCsYvRPQw@mail.gmail.com>
 <20130419133459.GA7044@echo>
 <20130424135855.GA18679@x220>
 <CAMOw1v5ef6Uwx5t32pMhzzb4gurLuf+K9-iXJmgfdyCAGH+Wjg@mail.gmail.com>
 <20130424183600.GA29925@x220>
 <CAMOw1v5PS46KSTEb-7mEySpucEQqB19=iDwvGKSJ3CHKEdJ0Ow@mail.gmail.com>
 <CA+A7VXV9sHvBDcP2XxrAGrVriv=FD6is90gauC-cVHnbjCHTXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CA+A7VXV9sHvBDcP2XxrAGrVriv=FD6is90gauC-cVHnbjCHTXg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Wed, Jun 26, 2013, João Paulo Rechi Vita wrote:
> >>> When we implemented the properties interface, the manner we talked
> >>> about doing this (if it was indeed needed) was mostly what Luiz is
> >>> saying now. I think I even sent a patch to this mailing list
> >>> containing this flag. You would add something like:
> >>>
> >>> G_DBUS_PROPERTY_FLAG_IMMEDIATE (or some better naming). Then
> >>> g_dbus_emit_property_changed() would check this flag, in which case
> >>> process_changes() would be called synchronously. I don't see why this
> >>> wouldn't solve your problem and it doesn't require an API change. For
> >>> the exceptional cases in which this is needed, we add such flag. And
> >>> if a property needs to be sent immediately in one place I think it
> >>> always will. Or am I missing something?
> >>
> >> The main point I was trying to present is that it would be nice if when
> >> you have code like:
> >>
> >>         foo();
> >>         bar();
> >>         baz();
> >>
> >> and each of those calls create a D-Bus message (property signal method
> >> call/return, etc) that needs to be sent, that you could count on the
> >> messages being sent in the same order that they happen in the code. This
> >> kind of intuitiveness would be nice to have regardless of whether we're
> >> dealing with a special case that really needs it or not.
> >
> > Any of the proposed solutions do this. Your solution involves not
> > marking the special cases, but on the other hand makes the special
> > cases the default and needs some more working on gdbus to cover all
> > the uses of dbus_connection_send_*
> >
> > I'm not saying it's not a good solution, bit I'm not sure it's the
> > best one neither.
> 
> Can we get back to this topic? This problem is still present in the
> master branch and affecting our support for HFP in oFono.

The last chat I had with Marcel about this was that he also preferred to
have a method call sending gdbus API that guarantees the ordering of
messages (including method calls, replies and signals). We don't have to
convert absolutely everything immediately to use the API but just the
critical places where the order is actually causing bad behavior right
now.

Technical detail-wise this is not completely trivial since the pending
signal handling is part of the gdbus context data for the local object
path that emits them, whereas method calls do not have any associated
local object path (they're tied to a *remote* object path), i.e. the
same gdbus context data can't be used. One option would be to track
pending method calls in the context data for the root path which is
available as the static "root" variable in gdbus/object.c. Another
technical detail that needs deciding is whether sending a method call
should cause a forceful sending of any pending signals, or whether the
call should also be put behind an idle callback.

Johan
