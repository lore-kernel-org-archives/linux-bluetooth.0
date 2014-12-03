Return-Path: <cyrus@holtmann.org>
Message-ID: <547EF951.8060007@gmx.de>
Date: Wed, 03 Dec 2014 12:51:45 +0100
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH]     Bluetooth: Add support for Broadcom BCM20702A0 in
 Fuijitsu Lifebook E751
References: <8967C48B-00C1-43E8-A8EC-C41642288122@holtmann.org> <1417546017-25257-1-git-send-email-harv@gmx.de> <EC8200AB-98BA-4C4B-AC07-E6AA51DE284B@holtmann.org>
In-Reply-To: <EC8200AB-98BA-4C4B-AC07-E6AA51DE284B@holtmann.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

> Actually there is a generic catch all entry for vendor 0x0489
> already.
> 
> /* Foxconn - Hon Hai */ { USB_VENDOR_AND_INTERFACE_INFO(0x0489,
> 0xff, 0x01, 0x01) },
> 
> So I prefer that we enable BTUSB_BCM_PATCHRAM support in a generic
> way instead of just for every single product id.

I have seen the other patch from Wen-chien Jesse Sung that does
exactly this. But while I would prefer this way too I doubt that all
firmware files come from the same place as these are vendor specific
things. Mine i.e. was from a Fuijitsu support URL. So the commit
message can not provide sources for firmware download in these generic
way.

You decide

Harvey

- -- 
I am root. If you see me laughing, you'd better have a backup!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlR++UsACgkQi5aqmLBUSgmteQCeIeOrd2k74tJmJTuVI40MbFce
6iUAnA62Ko4iz8rcdu7fZhbll5pGP124
=AEXI
-----END PGP SIGNATURE-----
