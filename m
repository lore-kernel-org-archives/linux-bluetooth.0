Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Alan Martinovic <alan.martinovic@senic.com>
Date: Thu, 7 Dec 2017 16:25:26 +0100
Message-ID: <CAOT_U5bjPoHRYdeOZp91JpwkqsDXxEx8o85NjJfKqAc6Y3h7kA@mail.gmail.com>
Subject: LE Create Connection always triggers LE Read Remote Used Features
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
For troubleshooting purposes I need to execute only:

LE Create Connection

 command and no other.
The d-bus interface doesn't provide this low level
functionality so I resulted to htctool.
The command translates to:

sudo hcitool -i hci1 cmd 08 000d 60 00 60 00 00 01 C2 49 C4 72 88 E0
00 18 00 28 00 00 00 2a 00 00 00 00 00

Which results in a correct command but triggers a
LE Read Remote Used Features
which is exactly what I want to avoid.

How to prevent the triggering?

Version:
Bluetooth monitor ver 5.47
= Note: Linux version 4.10.0-40-generic (x86_64)
= Note: Bluetooth subsystem version 2.22


btmon output:

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: E0:88:72:C4:49:C2 (Static)
        Own address type: Public (0x00)
        Min connection interval: 30.00 msec (0x0018)
        Max connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
@ RAW Close: hcitool
> HCI Event: LE Meta Event (0x3e) plen 19
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 1
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: E0:88:72:C4:49:C2 (Static)
        Connection interval: 50.00 msec (0x0028)
        Connection latency: 0 (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ MGMT Event: Device Connected (0x000b) plen 13
        LE Address: E0:88:72:C4:49:C2 (Static)
        Flags: 0x00000000
        Data length: 0
@ MGMT Event: Device Connected (0x000b) plen 13
        LE Address: E0:88:72:C4:49:C2 (Static)
        Flags: 0x00000000
        Data length: 0
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
        Handle: 1
> HCI Event: Command Status (0x0f) plen 4
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 1
        Reason: Connection Timeout (0x08)
