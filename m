Return-Path: <daryl@vanvorst.org>
From: "Daryl Van Vorst" <daryl@vanvorst.org>
To: "'Marcel Holtmann'" <marcel@rvs.uni-bielefeld.de>, "'Max Krasnyansky'" <maxk@qualcomm.com>
Cc: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Subject: RE: [Bluez-devel] RE: Rfcomm qualification
Date: Thu, 14 Aug 2003 10:39:07 -0700
Message-ID: <000901c3628a$f6caca80$1a01010a@baked>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1059612533.1832.48.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

Is this in your 2.4.18-mh8 patch?

-Daryl.

> -----Original Message-----
> From: bluez-devel-admin@lists.sourceforge.net 
> [mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of 
> Marcel Holtmann
> Sent: July 30, 2003 5:49 PM
> To: Max Krasnyansky
> Cc: Daryl Van Vorst; BlueZ Mailing List
> Subject: Re: [Bluez-devel] RE: Rfcomm qualification
> 
> 
> Hi Max,
> 
> > >The session wide credits value is useless
> > No, it's not. 1.1 spec only mandates send PN for the _first_ DLC on 
> > that session. Which means that values negotiated in PN request are 
> > supposed to be applied to the subsequent DLCs.  So we still need 
> > session wide settings. We just need to update them when we get PN 
> > req/rsp, which don't do.
> > 
> > Check this out:
> > "
> > 6.5.1 Initial DLC Negotiation
> > The use of credit based flow control is a session characteristic. 
> > Thus, it has to be negotiated with the PN multiplexor 
> control command 
> > (see Section 5.5.3) before the first DLC is established. After the 
> > first successful negotiation and DLC establishment, all 
> DLCs will be 
> > flow controlled with this scheme. PN negotiation at subsequent DLC 
> > establish-ments is optional, but recommended, since it also 
> > establishes initial credit count values on both sides for 
> both sides. 
> > "
> 
> memory malfunction ;) I thought it was a per dlc value.
> 
> The attached patch sets the default values for session and 
> dlc credits to zero and put in RFCOMM_MAX_CREDITS only if we 
> receive a PN with 1.1 flow control.
> 
> What do you think?
> 
> Regards
> 
> Marcel
> 
> 
