Return-Path: <echtler@fs.tum.de>
Date: Mon, 1 Nov 2004 16:44:16 +0100 (CET)
From: Florian Echtler <echtler@fs.tum.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS BT Keyboard problem solved
In-Reply-To: <1099321957.16247.104.camel@pegasus>
Message-ID: <Pine.LNX.4.61.0411011643110.22365@block.bubble>
References: <Pine.LNX.4.61.0411011023040.15228@block.bubble>
 <1099313202.16247.87.camel@pegasus>  <Pine.LNX.4.61.0411011606540.22365@block.bubble>
 <1099321957.16247.104.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > Well.. as it is at least 1.5 years old, I suppose it's the old
> > one, but I don't know for certain. Any way to find out?
> check with "hcitool info ..." if it says that it contains a CSR chip.

        Device Name: Microsoft Keyboard
        LMP Version: 1.1 (0x1) LMP Subversion: 0x1df
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xfb 0x0f 0x00 0x00 0x00 0x00 0x00

Looks like it does..

Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBhlnV7CzyshGvatgRAm1iAJ96V+/hkBMA18KkgzP0E/QGfK7KiwCg4qi0
DksFtQqFZMyP473gteHaLTs=
=RrcB
-----END PGP SIGNATURE-----
