Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 9 Aug 2010 16:21:34 +0300
Message-ID: <AANLkTimt4CN6Oegrnf3Z5mhb0L7QLiiaPdHCSdp=rLTw@mail.gmail.com>
Subject: Workaround for buggy BT dongles
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We have experienced L2CAP disconnections with A-Link BT dongles (lsusb
shows Broadcom Corp. BCM2046B1 chip).

There is race condition in a controller so that sometimes "L2CAP
Connect Req" is received after "HCI Encryption Change":
...
2308 *REF*                                                   HCI_EVT
Simple Pairing Complete
2309 0.089720                                                HCI_EVT
Link Key Notification
2310 0.126607                                                L2CAP
Rcvd Connection Request
2311 0.126721                                                L2CAP
Sent Connection Response
2312 0.127278                                                HCI_EVT
Encrypt Change
...

This is correct behavior since all non-SDP connections shall be
encrypted for SSP devices.

If we send "L2CAP Connect Request" with a little delay the problem
disappears (this is of course too hackish way).

Shall we address this problem? I do not see good way of dealing with the chip.

Regards,
Andrei
