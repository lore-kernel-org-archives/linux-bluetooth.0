Return-Path: <cyrus@holtmann.org>
Message-ID: <1385398409.3423.25.camel@nuvo>
Subject: Crasher during remote initiated pairing
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 25 Nov 2013 17:53:29 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

I have a particularly stubborn device, the TomTom Go Remote that tries
to connect to my computer as soon as it's turned on, even when I've
removed the pairing on the computer side.

With GNOME's Bluetooth wizard open, I receive an out of the blue request
for pairing, I pass it the expected PIN code (0000), I then find that
the wizard doesn't work as I expected and turn it off. bluetoothd
promptly crashes:

Program received signal SIGSEGV, Segmentation fault.
0x00007f0cf9ffde24 in agent_auth_cb (agent=<optimized out>, derr=0x7fffab655920, user_data=0x7f0cfb2e0020) at src/adapter.c:4370
4370		struct service_auth *auth = adapter->auths->head->data;
(gdb) p adapter
$1 = (struct btd_adapter *) 0x7f0cfb2e0020
(gdb) p adapter->auths
$2 = (GQueue *) 0x7f0cfb2d1240
(gdb) p adapter->auths->head
$3 = 0x0

Some missing NULL checks?

I imagine that this should be reproduceable using simple-agent and
making it exit after replying to RequestPinCode.

This happens with 5.10 and 5.11:
https://retrace.fedoraproject.org/faf/problems/1353319/

Cheers

