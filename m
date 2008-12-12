Return-Path: <cyrus@holtmann.org>
Message-ID: <49429EDF.4050900@tommie-lie.de>
Date: Fri, 12 Dec 2008 18:26:55 +0100
From: Thomas Liebetraut <thomas@tommie-lie.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: How to set link policy with Logitech diNovo dongle
References: <493D7110.1020508@tommie-lie.de>	 <1228765907.28839.95.camel@violet.holtmann.net>	 <493D9EA5.5000101@tommie-lie.de> <1229046523.22285.25.camel@violet.holtmann.net>
In-Reply-To: <1229046523.22285.25.camel@violet.holtmann.net>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

Marcel Holtmann schrieb:
> this is a serious problem. Please show me hciconfig -a of your dongle. I
> have never seen a dongle that doesn't support Default Link Policy.

Here is the output from hciconfig -a:
| thomas@Majestix:~/src/bluez-4.22$ hciconfig -a
| hci0:   Type: USB
|         BD Address: 00:07:61:19:49:79 ACL MTU: 192:8 SCO MTU: 64:8
|         UP RUNNING PSCAN
|         RX bytes:27144 acl:1558 sco:0 events:162 errors:0
|         TX bytes:1935 acl:59 sco:0 commands:68 errors:0
|         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
|         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
|         Link policy:
|         Link mode: SLAVE ACCEPT
|         Name: 'Majestix-0'
|         Class: 0x0a0104
|         Service Classes: Networking, Capturing
|         Device Class: Computer, Desktop workstation
|         HCI Ver: 1.1 (0x1) HCI Rev: 0x34e LMP Ver: 1.1 (0x1) LMP
Subver: 0x34e
|         Manufacturer: Cambridge Silicon Radio (10)

And the output from lsusb to identify the dongle:
thomas@Majestix:~$ lsusb
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 006: ID 046d:c707 Logitech, Inc. Bluetooth wireless hub
Bus 002 Device 005: ID 046d:c704 Logitech, Inc.
Bus 002 Device 004: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

The second Logitech device seems to be the USB HID adapter from the
exact same dongle.


Regards,
Thomas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklCnt8ACgkQxVmZpTAq4IglkwCfT9LYAKU8t79FYsp/iPzFb7J3
eQAAn1somnyLbLGDSd7kdCRBJf14PAOs
=GOg8
-----END PGP SIGNATURE-----
