Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>,
   James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [Bluez-devel] sco link help needed
Date: Wed, 25 Feb 2004 13:59:00 +0100
Cc: Fred =?iso-8859-15?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
References: <4034CA08.50500@soft.uni-linz.ac.at> <40393D4D.5070908@superbug.demon.co.uk> <1077522938.2832.84.camel@pegasus>
In-Reply-To: <1077522938.2832.84.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402251359.00791.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>


On Monday 23 February 2004 08:55, Marcel Holtmann wrote:

> > The bluetooth chip should not have to worry about dropping packets, the
> > application should just send the chip packets when the chip wants them.
>
> Yes it have to. You should read the mailing list archive and search for
> comments from the CSR guys about SCO. And you can of course take the
> Bluetooth specification itself.

hi marcel, 

could you please provide a url?

i have been trying to transfer pcm data over a sco socket both using scotest 
and other similar apps of mine, but the actual data tranferred were only a 
bunch of random bytes, completely unrelated to the data sent. moreover, the 
behaviour of sco links is very unreliable. in my tests i have used several 
usb dongles with CSR chips (firmware versions ranging from HCI 15.3 to HCI 
16.4) and kernel versions from 2.4.22 to 2.4.25-pre7.

you have told us many times that there are strong limitations in what you can 
do with sco sockets, but i still can't understand what are these limitations. 
i have tried searching trough the archives but i couldn't find anything 
interesting about this.

> > I am only asking for changes to the SCO side of things due to it's real
> > time nature. Using network sockets for RFCOMM and bulk data transfers
> > that are not real time in nature is fine.
> >
> > Once we have proper real time SCO support, we can overlay the current
> > SCO file descriptor read/write model on top if you still need it.
>
> Again, I can't follow what you are trying to achieve. The current socket
> interface for SCO fits not perfect, because it is audio only data.

does this mean that you simply can't perform pcm audio transfers between two 
bluez hosts by using sco sockets just like scotest does? if so, what is the 
purpose of scotest, then?

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
