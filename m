Return-Path: <echtler@fs.tum.de>
Date: Sun, 21 Dec 2003 11:52:33 +0100 (CET)
From: Florian Echtler <echtler@fs.tum.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid cvs question
In-Reply-To: <1071969925.2684.5.camel@pegasus>
Message-ID: <Pine.NEB.4.58.0312211145020.12898@neptun.fachschaften.tu-muenchen.de>
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
 <1071020597.10655.4.camel@pegasus>  <20031210080259.GF26896@smartdata.ch>
 <1071065922.10655.60.camel@pegasus>  <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
 <1071969925.2684.5.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > and I haven't noticed any glitches so far (connecting to the devices
> > still is kind of a hassle, but I guess MS is to blame for that).
> this is easy to solve. The problem is that if we don't have the device
> in our inquiry cache we use a pscan_rep_mode with the value 0x01 for
> connection setup, but Microsoft uses 0x02 by default. To solve the
> glitches with the initial connection is to do an inquiry first.
Do you mean by "hcitool inq <mouseaddr>"? Still doesn't work..
I can't even l2ping the bloody rodent, it's either "Host is down"
or "Function not implemented" (WTF?). Is there a tried-and-true command
sequence to get a freshly powered up mouse connected?

> > Final question: I patched the original bthid to allow me to control
> > xmms via the extra mouse/keyboard buttons. Would anyone be interested
> > if I ported this patch to the new bthid?
> Send it to the list.
I will, after I have everything finally up and running..

> Have you tried hotkeys? Last time I have tested it
> it works fine for me.
Not yet - I'll have a look at it, thanks.

Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (NetBSD)

iD8DBQE/5Xt37CzyshGvatgRAisuAJ0Uv2OVaYPUTOWTxBJpXJc87aZD3QCglRxL
7RGI5Gku0GNDPMAq5J5aTiw=
=tt6X
-----END PGP SIGNATURE-----
