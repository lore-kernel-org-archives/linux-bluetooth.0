Return-Path: <cyrus@holtmann.org>
Message-ID: <48CBEB0B.7060900@pook.es>
Date: Sat, 13 Sep 2008 18:32:11 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
CC: linux-bluetooth@vger.kernel.org, bugme-daemon@bugzilla.kernel.org
Subject: Re: [Bugme-new] [Bug 11514] New: bluetooth headset works with 2.6.26,
 only hisses with 2.6.27-rc5
References: <bug-11514-10286@http.bugzilla.kernel.org/> <20080907040134.732f925c.akpm@linux-foundation.org>
In-Reply-To: <20080907040134.732f925c.akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 07/09/08 13:01, Andrew Morton wrote:

> A post-2.6.26 regression.

yes. I read the change log for 2.6.27-rc6 and it doesn't seem to address my
problem. Should I try it anyway?

I forgot to mention that my bluetooth dongle is a USB

ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)

# hciconfig  -a
hci0:	Type: USB
BD Address: 00:0C:41:E1:FF:30 ACL MTU: 192:8 SCO MTU: 64:8
UP RUNNING
RX bytes:3713306 acl:72248 sco:0 events:299153 errors:0
TX bytes:2985713 acl:109155 sco:0 commands:157763 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'kooka-0'
Class: 0x0a0000
Service Classes: Networking, Capturing
Device Class: Miscellaneous,
HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
Manufacturer: Cambridge Silicon Radio (10)


If I can help in finding a solution to this problem please let me know!

Stuart
