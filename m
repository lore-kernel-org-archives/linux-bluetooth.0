Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] sco link help needed
Date: Wed, 25 Feb 2004 16:35:13 +0100
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Fred =?iso-8859-15?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
References: <4034CA08.50500@soft.uni-linz.ac.at> <200402251504.47809.mtortonesi@ing.unife.it> <1077719012.2919.94.camel@pegasus>
In-Reply-To: <1077719012.2919.94.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402251635.13917.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 25 February 2004 15:23, Marcel Holtmann wrote:
> Hi Mauro,
>
> > > the Bluetooth specification can be found under www.bluetooth.org and
> > > the links to the mailing list archives are at www.bluez.org.
> >
> > really, i was asking about the link to the url in the archives where i
> > can find the "comments from the CSR guys about SCO"...
>
> is it so hard to search through the archives? I did the search for you,
> but don't expect me to do it again. This is one of them
>
> 	http://article.gmane.org/gmane.linux.bluez.user/502

well, you knew just what to search. i have spent more than one hour searching 
for "sco" and "sco csr" on the sf.net archives (which, as you surely know, 
are not very fast, have thousands of messages and have a shameful uptime) 
without finding anything useful. if you had kindly told me "look for 
something like scotest" or "look for a message from steven singer" i could 
have find the mail you were referring to in a minute.

> > > You can send PCM audio over a SCO socket, but you can't expect that the
> > > PCM stream on the other side is byte by byte the same. It only sounds
> > > the same.
> >
> > i haven't tried, but i don't suppose that infinite series of zeros i get
> > on the receiver sounds just like art blakey's alamode. there is surely
> > something wrong in the transfer process. could it be the fact that my
> > hosts have an usb-uhci controller?
>
> Is the PCM mapping of both dongles set to HCI? 

how can i find this out? from the SCO MTU value?

[mauro@giskard mauro]$ /sbin/hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:0A:3A:51:13:1C ACL MTU: 192:8  SCO MTU: 64:8
        HCI 16.4

> What kernel version do you use?

2.4.25pre7 

-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
