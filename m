Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Austin Riffle <ARiffle@efji.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
Subject: Operate on BlueZ provided file descriptor in C
Date: Thu, 10 Aug 2017 02:06:25 +0000
Message-ID: <4C851F03BEE04A418B7A2D283DDCAB5D27C95F71@EFJDFWMB01.EFJDFW.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

I am attempting to work with the org.bluez.Profile1 in BlueZ 5.44. When con=
necting with a new device via the NewConnection DBus method, we get a file =
descriptor to work with. I am fairly confused on what state this file descr=
iptor is in, and what I need to do in order to read/write from it. Simply c=
alling read/write does not behave as expected for me.

In the file test/test-profile, I see this line of python code:

self.fd =3D fd.take()

I am struggling to find the Linux C equivalent to the take method, as I bel=
ieve this is what I need to do to operate on the fd. Any advice on how to c=
onfigure this fd in Linux C code so I can read/write with the fd would be v=
ery helpful!

Thanks
Austin
This e-mail transmission, and any documents, files or previous e-mail messa=
ges attached to it, may contain confidential information. If you are not th=
e intended recipient, or a person responsible for delivering it to the inte=
nded recipient, you are hereby notified that any disclosure, distribution, =
review, copy or use of any of the information contained in or attached to t=
his message is STRICTLY PROHIBITED. If you have received this transmission =
in error, please immediately notify us by reply e-mail, and destroy the ori=
ginal transmission and its attachments without reading them or saving them =
to disk. Thank you.

