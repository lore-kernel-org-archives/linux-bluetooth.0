Return-Path: <daryl@wideray.com>
Errors-To: <daryl@wideray.com>
From: "Daryl Van Vorst" <daryl@wideray.com>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Rfcomm qualification
Date: Mon, 11 Aug 2003 09:43:52 -0700
Message-ID: <000c01c36027$bfdfc490$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
In-Reply-To: <1060121068.962.15.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Have you two worked out a solution for this one (see message below)?

Should I use the last patch you sent to test?

-Daryl.

> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@rvs.uni-bielefeld.de] 
> Sent: August 5, 2003 3:04 PM
> To: Max Krasnyansky
> Cc: Daryl Van Vorst; BlueZ Mailing List
> Subject: Re: [Bluez-devel] RE: Rfcomm qualification
> 
> 
> Hi Max,
> 
> > >The attached patch sets the default values for session and dlc 
> > >credits to zero and put in RFCOMM_MAX_CREDITS only if we 
> receive a PN 
> > >with 1.1 flow control.
> > >
> > >What do you think?
> > 
> > I don't like this:
> > 
> > @@ -746,7 +746,7 @@
> >         pn->ack_timer   = 0;
> >         pn->max_retrans = 0;
> >  
> > -       if (d->credits) {
> > +       if (cr || d->credits) {
> > 
> > 
> > This basically means that we'll always request CFC even if 
> the other 
> > side explicitly told us that they don't support it. Which is kinda 
> > dumb :).
> 
> I know exactly what you mean and I don't like it either. But 
> my general purpose of this patch was not to introduce another 
> "state" of credits. And btw. credits is a uint at the moment.
> 
> What do you thing about using session->flags and once we 
> received a positive CFC acknowledgment we set a session wide flag?
> 
> > Here is what I would do (no time for the patch sory).
> > When session is created set s->credits to -1. Replace above if() 
> > statement
> > with
> >         if (s->credits < 0) {
> 
> I think only
> 
> 	if (s->credits != 0) {
> 
> will work in this case ;)
> 
> > Also rfcomm_apply_pn() needs to set d->credits only once at 
> the end of 
> > the function.
> 
> This depends on how strict we want to go with the RFCOMM 
> spec. It says that if one dlc requests CFC all other dlc's 
> should go with CFC, too. I like to give the dlc the chance to 
> deactivate or activate CFC even if session default CFC 
> setting says otherwise. But maybe this feature is non-sense - 
> I have to think about it in more detail.
> 
> Regards
> 
> Marcel
> 
> 
> 
