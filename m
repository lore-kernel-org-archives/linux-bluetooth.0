Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 11 Mar 2009 15:51:28 -0700
Message-ID: <f9d2a5e10903111551h428ca9fekea7f6960c7666be9@mail.gmail.com>
Subject: btusb+slob
From: Russ Dill <russ.dill@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, discussion@beagleboard.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

After running into problems with btusb on my OMAP3 (arm) based Beagle
Board, I discovered that switching from SLOB to SLAB causes the
problems to go away. With SLOB:

Scanning ...
        05:16:CF:F7:04:20       n/a
        00:11:F6:05:79:95       ....R#w
        00:1A:8A:DB:E8:3D       ....R$w9
        00:16:CF:F7:04:20
        05:1A:8A:DB:E8:3D       n/a

Devices:
        hci0    00:00:00:00:A8:AE

Connections:
        < ACL 00:11:F6:05:79:95 handle 0 state 5 lm MASTER


With SLAB:

Scanning ...
        00:1A:8A:DB:E8:3D       SGH-T629

Devices:
	hci0	00:1B:DC:0F:A8:AE

Connections:
	< ACL 00:11:F6:05:79:95 handle 42 state 1 lm SLAVE

I have not been able to test on other architectures yet to determine
if it is another component in the chain (such as the usb OTG
controller) misbehaving with SLOB. This is with git latest (post
2.6.29-rc7) and a number of OMAP branches.
