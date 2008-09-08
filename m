Return-Path: <cyrus@holtmann.org>
From: Daniel Benoy <daniel@benoy.name>
To: "Support for Openmoko Device Owners" <support@lists.openmoko.org>
Subject: Intermittant bluetooth keyboard
Date: Mon, 8 Sep 2008 13:23:15 -0400
Cc: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809081323.15887.daniel@benoy.name>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I set up my bluetooth keyboard on my openmoko phone using the 'new' (In other words, not hidd, but still dbus) input interface, and it only works like 10% of the time.  That means when I turn it on it should connect and start working.  Unfortunately, it only works about 25% of the time, and I have to switch it off and on frequenly in order to get it to finally connect.  I get this output from hcidump -V when it doesn't work:

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0A:DF:00:24:59 class 0x002540 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0A:DF:00:24:59 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:0A:DF:00:24:59 type ACL encrypt 0x00
    Error: LMP Response Timeout

The difference in time between 'Accept Connection Request' and 'LMP Response Timeout' is about 3 seconds.  I was under the impression that LMP negociation was supposed to time out after 30 seconds?

Is there something I'm doing wrong?  Am I not interprating this correctly?

If it does work I get something like this:

> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:0A:DF:00:24:59 class 0x002540 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:0A:DF:00:24:59 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:DF:00:24:59

.
.
.

(And then link key request reply and so on it does its negociation and there you have it)
-- 
Daniel Benoy
http://daniel.benoy.name
