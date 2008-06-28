Return-Path: <cyrus@holtmann.org>
Message-ID: <87855ac60806281145h5a1e8b5as206369c7a63f9076@mail.gmail.com>
Date: Sat, 28 Jun 2008 12:45:41 -0600
From: "Arren Lex" <arrenlex@gmail.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <87855ac60806281140k3f915cb4i3a94a459d3c1542b@mail.gmail.com>
MIME-Version: 1.0
References: <87855ac60806281140k3f915cb4i3a94a459d3c1542b@mail.gmail.com>
Subject: [Bluez-devel] Regression: previously perfect dongle is now unusable.
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hey, all. I have a "RocketFish" branded USB bluetooth adapter, which
dmesg identifies thus:
input: Broadcom Corp BCM2045B3 ROM as /class/input/input9
input,hidraw3: USB HID v1.11 Keyboard [Broadcom Corp BCM2045B3 ROM] on
usb-0000:00:10.2-2.2
usb 4-2.3: new full speed USB device using uhci_hcd and address 7
usb 4-2.3: configuration #1 chosen from 1 choice
input: Broadcom Corp BCM2045B3 ROM as /class/input/input10
input,hidraw4: USB HID v1.11 Mouse [Broadcom Corp BCM2045B3 ROM] on
usb-0000:00:10.2-2.3

In Jan\Feb 2008, this dongle worked perfectly for me. It created hci0
when plugged in, and after issuing a "hciconfig hci0 reset" I was able
to search devices, use it to transfer data from my phone and even
control the mouse with my wiimote. However, I recently (mid-June 2008)
tried the dongle again, and now no hci devices are created at all, and
all of the commands fail.

I'm not sure where to start looking for the regression. Would it be in
the kernel? The library? The userspace tools? Does anyone have some
idea of what might have happened?

Thanks in advance.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
