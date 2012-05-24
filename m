Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:37:23 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 3/8] Bluetooth: Add l2cap_chan->ops->ready()
Message-ID: <20120524113721.GS24715@aemeltch-MOBL1>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
 <1337821964-4618-4-git-send-email-gustavo@padovan.org>
 <20120524093958.GL24715@aemeltch-MOBL1>
 <20120524102342.GQ24715@aemeltch-MOBL1>
 <CAA37ikZvK=woaW_grv1t6PK0x0d3uz98MmjQL46z9PHPCJA0nA@mail.gmail.com>
 <20120524113018.GR24715@aemeltch-MOBL1>
 <CAA37ikZBekiH6Jn2yn4Mkm1BKvrW=rjD62doOkDH3CVUvwpRDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikZBekiH6Jn2yn4Mkm1BKvrW=rjD62doOkDH3CVUvwpRDA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

On Thu, May 24, 2012 at 08:31:15AM -0300, Ulisses Furquim wrote:
> Hi Andrei,
> 
> On Thu, May 24, 2012 at 8:30 AM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
> > Hi Ulisses,
> >
> > On Thu, May 24, 2012 at 08:17:23AM -0300, Ulisses Furquim wrote:
> >> >> > +   void                    (*ready) (void *data);
> >> >>
> >> >> Again, why void *data ?
> >> >
> >> > I mean here that for fixed channels we do not need this function at this
> >> > point since initialization is different.
> >>
> >> So? What do you mean? This needs to be generic, I think. It's an
> >> abstraction after all.
> >
> > Fixed channels do not have configuration phase, they are created
> > CONNECTED (at least A2MP).
> 
> And your proposal is?

Fox fixed channels ready is not defined (at least now) so we can just use
exact type, see my patch in a minute.

Best regards 
Andrei Emeltchenko 

