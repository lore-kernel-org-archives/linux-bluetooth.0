Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Fri, 2 Nov 2012 10:55:22 +0100
Message-ID: <CAGm1_kva5xN1K0aDwvhaLBqW0qNCtdpQxp-ipzVRpLUD7XBVYw@mail.gmail.com>
Subject: Cybertan MM230-M issue
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm using this WLAN-BT-combo card with linux 3.2 and TI am335x based
board. WLAN (88W8686/B1 (Marvell) ) is working, but Bluetooth
(BC4ROM/21e (CSR)) only partly.

I can connect to the card via hciattach ttyO5 bcsp and then I can
bring it up and enable pscan. But hcitool scan delivers nothing.

I get following values via bccmd:

Chip revision: 0x0030 (BC4-ROM)
Build name: odj_4hci_rom_bt2.0_21e_0604241634_encr128 2006-04-24

bccmd -t BCSP -d /dev/ttyO5 -b 115200 enabletx returns with error:
Can't execute command: No such device or address (6)

Any idea how to get the card working?

Regards,
Yegor
