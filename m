Return-Path: <cyrus@holtmann.org>
From: "Bram Jansen" <bramsbox@gmail.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: max 16 hci devices on usb 2.0
Date: Sun, 17 Jan 2010 00:35:16 +0100
Message-ID: <BABDE7A517704C42BC70E146983535B6@radon>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I have a question regarding the connection of 16 hci devices to a linux box.
I've been looking around for quite some time and I was not able to find
something useful, therefore I hope anyone of you guys is able to point me in
the right direction.

We have used quite a few kernel versions to try to connect 16 hci devices to
one system with usb 2.0 enabled.
This gives a problem after 7 devices. Devices hci7-hci15 give timeouts and
errors after initializing.

We solved this problem by disabling ehci in the kernel, so the bluetooth had
to use usb 1.1 (ohci)
with these settings it works without any problems and all 16 hci devices are
initialized properly after insertion/boot

now there has come the need for usb 2.0 on the same system.

Is there a known solution for this issue?

Thanks in advance,

Regards,

Bram Jansen




