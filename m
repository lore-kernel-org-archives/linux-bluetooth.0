Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] sco link help needed
Date: Wed, 25 Feb 2004 15:04:47 +0100
References: <4034CA08.50500@soft.uni-linz.ac.at> <200402251359.00791.mtortonesi@ing.unife.it> <1077715546.2919.77.camel@pegasus>
In-Reply-To: <1077715546.2919.77.camel@pegasus>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Fred =?iso-8859-15?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402251504.47809.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 25 February 2004 14:25, Marcel Holtmann wrote:
> Hi Mauro,
>
> > > Yes it have to. You should read the mailing list archive and search for
> > > comments from the CSR guys about SCO. And you can of course take the
> > > Bluetooth specification itself.
> >
> > could you please provide a url?
>
> the Bluetooth specification can be found under www.bluetooth.org and the
> links to the mailing list archives are at www.bluez.org.

really, i was asking about the link to the url in the archives where i can 
find the "comments from the CSR guys about SCO"...

> > i have been trying to transfer pcm data over a sco socket both using
> > scotest and other similar apps of mine, but the actual data tranferred
> > were only a bunch of random bytes, completely unrelated to the data sent.
> > moreover, the behaviour of sco links is very unreliable. in my tests i
> > have used several usb dongles with CSR chips (firmware versions ranging
> > from HCI 15.3 to HCI 16.4) and kernel versions from 2.4.22 to
> > 2.4.25-pre7.
> >
> > you have told us many times that there are strong limitations in what you
> > can do with sco sockets, but i still can't understand what are these
> > limitations. i have tried searching trough the archives but i couldn't
> > find anything interesting about this.
>
> How often must I repeat this? 

sorry, i happen to be a bit dumb sometimes ;-) but it seems that many others 
are experiencing problems with SCO. perhaps you could start writing something 
like a SCO readme?

> We are doing audio over SCO and no data 
> transfer. Even with transparent SCO as air coding the results on both
> ends must not be the same.
>
> > > Again, I can't follow what you are trying to achieve. The current
> > > socket interface for SCO fits not perfect, because it is audio only
> > > data.
> >
> > does this mean that you simply can't perform pcm audio transfers between
> > two bluez hosts by using sco sockets just like scotest does? if so, what
> > is the purpose of scotest, then?
>
> You can send PCM audio over a SCO socket, but you can't expect that the
> PCM stream on the other side is byte by byte the same. It only sounds
> the same.

i haven't tried, but i don't suppose that infinite series of zeros i get on 
the receiver sounds just like art blakey's alamode. there is surely something 
wrong in the transfer process. could it be the fact that my hosts have an 
usb-uhci controller?

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
