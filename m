Return-Path: <mtortonesi@ing.unife.it>
From: Mauro Tortonesi <mtortonesi@ing.unife.it>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] sco link help needed
Date: Wed, 25 Feb 2004 16:46:10 +0100
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
   Fred =?iso-8859-15?q?Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
References: <4034CA08.50500@soft.uni-linz.ac.at> <200402251635.13917.mtortonesi@ing.unife.it> <1077723452.2919.112.camel@pegasus>
In-Reply-To: <1077723452.2919.112.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200402251646.10544.mtortonesi@ing.unife.it>
List-ID: <bluez-devel.lists.sourceforge.net>

On Wednesday 25 February 2004 16:37, Marcel Holtmann wrote:

> > > Is the PCM mapping of both dongles set to HCI?
> >
> > how can i find this out? from the SCO MTU value?
> >
> > [mauro@giskard mauro]$ /sbin/hciconfig hci0 revision
> > hci0:   Type: USB
> >         BD Address: 00:0A:3A:51:13:1C ACL MTU: 192:8  SCO MTU: 64:8
> >         HCI 16.4
>
> No. Use "hciconfig hci0 revision" (as root). It must be set to HCI.

in fact, it is set to HCI.


-- 
Aequam memento rebus in arduis servare mentem...

Mauro Tortonesi                 mtortonesi@ing.unife.it
                                mauro@deepspace6.net
                                mauro@ferrara.linux.it
Deep Space 6 - IPv6 with Linux  http://www.deepspace6.net
Ferrara Linux User Group        http://www.ferrara.linux.it
