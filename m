Return-Path: <echtler@fs.tum.de>
Date: Sun, 21 Dec 2003 13:48:53 +0100 (CET)
From: Florian Echtler <echtler@fs.tum.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Olivier Bornet <Olivier.Bornet@smartdata.ch>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-users] bthid cvs question
In-Reply-To: <1072007784.2684.45.camel@pegasus>
Message-ID: <Pine.NEB.4.58.0312211344550.20995@europa.fachschaften.tu-muenchen.de>
References: <Pine.LNX.4.44.0312091023470.6471-100000@speare5-1-11.nmt.edu>
 <1071020597.10655.4.camel@pegasus>  <20031210080259.GF26896@smartdata.ch>
 <1071065922.10655.60.camel@pegasus>  <Pine.NEB.4.58.0312202356540.10214@gaia.fachschaften.tu-muenchen.de>
  <1071969925.2684.5.camel@pegasus>  <Pine.NEB.4.58.0312211145020.12898@neptun.fachschaften.tu-muenchen.de>
 <1072007784.2684.45.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-devel.lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> you only have to connect to a Bluetooth mouse once. In all subsequent
> cases the mouse will connect to you. For the first connection you press
> the connect button under the mouse. Run "hcitool inq" and connect to the
> mouse. This is working every time.
Well, thanks for your reply - I've now found out where the problem
really was. I had simply enabled auth and encrypt in hcid.conf, and
AFAIK the MS devices are capable of none. Now they're working fine,
if only a bit insecure..

Thanks again, Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (NetBSD)

iD8DBQE/5Za97CzyshGvatgRAr4aAKCXlPYQhMJyniwFVVliiw+14LezIwCfYOdA
n3rMwBpDYbp6pN5/CStOq80=
=BBk+
-----END PGP SIGNATURE-----
