Return-Path: <echtler@fs.tum.de>
Date: Sun, 24 Oct 2004 18:34:26 +0200 (CEST)
From: Florian Echtler <echtler@fs.tum.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Disabling HID Boot Protocol
In-Reply-To: <1098618588.6465.5.camel@pegasus>
Message-ID: <Pine.LNX.4.61.0410241829170.12604@block.bubble>
References: <Pine.LNX.4.61.0410241307180.7693@block.bubble>
 <1098618588.6465.5.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > I'm using a MS Bluetooth Optical Desktop and would like to
> > use the hotkeys again. I have kernel 2.6.8.1-mh1 and bluez-utils
> > 2.10.. According to the mailing list archives, this version of 
> > hidp.ko should already support report mode, however, I couldn't
> > find any description on how to enable it. I suppose it's necessary
> > to pass the correct "-b <subclass>" parameter to hidd?
> the subclass parameter is only for overriding the value if the SDP
> records are wrong. Check with hidd and if it tells you something about
> boot mode then you are in boot mode, otherwise it uses report mode
> automaticly. So what does "hidd --show" say?

[root@block:~][0] $ hidd --show
00:50:F2:7E:DF:AE Microsoft Five Button Mouse [045e:007c] connected 
00:50:F2:80:47:83 Microsoft Bluetooth keyboard [045e:007b] connected 
[root@block:~][0] $ 

However, still no reaction from the multimedia keys, at least none
in hcidump. Perhaps I should try 2.6.9-mh1?

Yours, Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBe9mW7CzyshGvatgRAsnvAKComCd+EGpK3YRTCAPsn5+sxkeqJwCgiLDE
0hxcmtAPslHkYKjqF6vKS6I=
=jXGa
-----END PGP SIGNATURE-----
