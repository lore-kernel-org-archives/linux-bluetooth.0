Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1dfb024e0904171446l9484216p6bcfcca7405720d4@mail.gmail.com>
References: <1dfb024e0904171446l9484216p6bcfcca7405720d4@mail.gmail.com>
Date: Fri, 17 Apr 2009 15:57:49 -0600
Message-ID: <1dfb024e0904171457h78cb51d4me9274a9592536c5e@mail.gmail.com>
Subject: Why only one inquiry response when using BT2.1 inquiring BT2.0?
From: Thanit Sara <sara.thanit@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ps. sorry if this e-mail is duplicated. I tried sending a couple times
but it said delivery failed, so I try again.

Dear Sir/Madam

In Inquiry result with RSSI mode, I am wondering why when using
Bluetooth (BT) dongle version 2.1 to inquire BT version 2.0, there is
only one inquiry response back? On the other hand, when using version
2.1 to inquire version 2.1 there are multiple response as it's
supposed to be.

According to the core specification, it should act the same way when
using 2.0 to inquire both 2.0 and 2.1 in which I always got multiple
inquiry responses from the same device.

If anyone could tell me what is going on or I miss-understood
something here, please kindly guide me. I use BlueZ and kernel
versions as following.

bluez-libs-3.36-1.fc9.i386

bluez-utils-3.36-3.fc9.i386

bluez-hcidump-1.41-1.fc9.i386

fedora 9, kernel version: 2.6.27.21-78.2.41.fc9.i686

Should I get more than one inquiry response from the same device??

Best regards,

TS.

Below is the script showing when using BT 2.1 to inquire 2.0; and 2.0
to inquire 2.0 & 2.1 respectively.

**************************************************************************

The first case: BT 2.1 inquired for BT 2.0

[root@thanit ~]# hciconfig hci0 inqmode 1

[root@thanit ~]# hciconfig hci0 inqmode

hci0: Type: USB

BD Address: 00:0A:3A:87:A9:F2 ACL MTU: 1021:8 SCO MTU: 64:1

Inquiry mode: Inquiry with RSSI

[root@thanit ~]# hcitool inq

Inquiring ...

00:1B:59:BB:B6:2B clock offset: 0x6c61 class: 0x5a0204

Another terminal window shows “hcidumps”

[root@thanit ~]# hcidump -V

HCI sniffer - Bluetooth packet analyzer ver 1.41

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0

> HCI Event: Command Complete (0x0e) plen 5

Read Inquiry Mode (0x03|0x0044) ncmd 1

status 0x00 mode 2

< HCI Command: Write Inquiry Mode (0x03|0x0045) plen 1

mode 1

> HCI Event: Command Complete (0x0e) plen 4

Write Inquiry Mode (0x03|0x0045) ncmd 1

status 0x00

< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0

> HCI Event: Command Complete (0x0e) plen 5

Read Inquiry Mode (0x03|0x0044) ncmd 1

status 0x00 mode 1

< HCI Command: Inquiry (0x01|0x0001) plen 5

lap 0x9e8b33 len 8 num 0

> HCI Event: Command Status (0x0f) plen 4

Inquiry (0x01|0x0001) status 0x00 ncmd 1

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x6c61 class 0x5a0204 rssi
-43   <------- only one response here

> HCI Event: Inquiry Complete (0x01) plen 1

status 0x00

*********************************************************************

The first case: BT 2.1 inquired for BT 2.0

[root@ttt ~]# hciconfig hci0

hci0: Type: USB

BD Address: 00:17:9A:3F:2E:1A ACL MTU: 1017:8 SCO MTU: 64:0

UP RUNNING PSCAN

RX bytes:945 acl:0 sco:0 events:24 errors:0

TX bytes:347 acl:0 sco:0 commands:24 errors:0

[root@ttt ~]# hciconfig hci0 inqmode

hci0: Type: USB

BD Address: 00:17:9A:3F:2E:1A ACL MTU: 1017:8 SCO MTU: 64:0

Inquiry mode: Inquiry with RSSI

[root@ttt ~]# hcitool inq

Inquiring ...

00:1B:59:BB:B6:2B clock offset: 0x2b74 class: 0x5a0204

Another terminal window shows “hcidumps”

[root@ttt ~]# hcidump -V

HCI sniffer - Bluetooth packet analyzer ver 1.41

device: hci0 snap_len: 1028 filter: 0xffffffff

< HCI Command: Read Inquiry Mode (0x03|0x0044) plen 0

> HCI Event: Command Complete (0x0e) plen 5

Read Inquiry Mode (0x03|0x0044) ncmd 1

status 0x00 mode 1

< HCI Command: Inquiry (0x01|0x0001) plen 5

lap 0x9e8b33 len 8 num 0

> HCI Event: Command Status (0x0f) plen 4

Inquiry (0x01|0x0001) status 0x00 ncmd 1

> HCI Event: Inquiry Result with RSSI (0x22) plen 15        <<<----Many responses---->>>>

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b74 class 0x5a0204 rssi -37

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b73 class 0x5a0204 rssi -35

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b73 class 0x5a0204 rssi -36

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b72 class 0x5a0204 rssi -35

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b74 class 0x5a0204 rssi -35

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b74 class 0x5a0204 rssi -40

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b73 class 0x5a0204 rssi -39

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b73 class 0x5a0204 rssi -39

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b72 class 0x5a0204 rssi -39

> HCI Event: Inquiry Result with RSSI (0x22) plen 15

bdaddr 00:1B:59:BB:B6:2B mode 1 clkoffset 0x2b74 class 0x5a0204 rssi -38

> HCI Event: Inquiry Complete (0x01) plen 1

status 0x00

*********************************************************************
