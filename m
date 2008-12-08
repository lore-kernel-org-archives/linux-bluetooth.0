Return-Path: <cyrus@holtmann.org>
Message-ID: <493D9EA5.5000101@tommie-lie.de>
Date: Mon, 08 Dec 2008 23:24:37 +0100
From: Thomas Liebetraut <thomas@tommie-lie.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: How to set link policy with Logitech diNovo dongle
References: <493D7110.1020508@tommie-lie.de> <1228765907.28839.95.camel@violet.holtmann.net>
In-Reply-To: <1228765907.28839.95.camel@violet.holtmann.net>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

Marcel Holtmann schrieb:
> However to be sure what is going on you have to run "hcidump -X -V" and
> you can set the link policy manually via "hciconfig hci0 lp".
Using "hciconfig hci0 lp RSWITCH,SNIFF" results in
| Can't set link policy on hci0: Connection timed out (110)
And I get this output from hcidump when issuing this command:
| HCI sniffer - Bluetooth packet analyzer ver 1.42
| device: hci0 snap_len: 1028 filter: 0xffffffff
| < HCI Command: Write Default Link Policy Settings (0x02|0x000f) plen 2
|     policy 0x05
|     Link policy: RSWITCH SNIFF
| > HCI Event: Command Status (0x0f) plen 4
|     Write Default Link Policy Settings (0x02|0x000f) status 0x01 ncmd 1
|     Error: Unknown HCI Command

I hope I find some time tomorrow to play around with other versions of
bluez-utils.


Regards,
Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkk9nqQACgkQxVmZpTAq4Ij3xgCfZryUQ0LkvPvTiwcMdKEcSOdl
RSAAn38IZwNpeLCQ0mF+Rn5o+i+UPP2N
=zpxU
-----END PGP SIGNATURE-----
