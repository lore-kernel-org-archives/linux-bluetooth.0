Return-Path: <echtler@fs.tum.de>
Date: Mon, 25 Oct 2004 10:37:03 +0200 (CEST)
From: Florian Echtler <echtler@fs.tum.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Disabling HID Boot Protocol
In-Reply-To: <1098676850.6465.76.camel@pegasus>
Message-ID: <Pine.LNX.4.61.0410250918550.25313@block.bubble>
References: <Pine.LNX.4.61.0410241307180.7693@block.bubble>
 <1098618588.6465.5.camel@pegasus>  <Pine.LNX.4.61.0410241829170.12604@block.bubble>
 <1098676850.6465.76.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > However, still no reaction from the multimedia keys, at least none
> > in hcidump. Perhaps I should try 2.6.9-mh1?
> You see nothing in hcidump, when you press them? That is strange. What
> are the first HIDP messages for the keyboard in hcidump?
The first HIDP thing the keyboard says after connection:

> ACL data: handle 0x002c flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      HIDP: Data: Input report
      01 00 00 2C 00 00 00 00 00 
> ACL data: handle 0x002c flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      HIDP: Data: Input report
      01 00 00 00 00 00 00 00 00 

I recorded a BT dump which shows the keyboard connecting and two
keypresses (Space and the mute button). If desired, I can send it
to you personally.

Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBfLsy7CzyshGvatgRAlE/AKCper8BaJ0etNXCu4Saa3SxMprNTwCgwSAf
aXZusBCfbu3mcSaNMSd+Ooc=
=+QKh
-----END PGP SIGNATURE-----
