Return-Path: <cyrus@holtmann.org>
To: linux-bluetooth@vger.kernel.org
From: Mike <mailinglists@in-box.at>
Subject: Bluez with Raspberry Pi for BLE
Message-ID: <55F55C99.7070803@in-box.at>
Date: Sun, 13 Sep 2015 13:23:05 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am trying to get my RPi to work with BLE. I downloaded and compiled
bluez-5.34.tar.xz.

uname -a says: Linux raspberry 4.1.6-v7+ #810 SMP PREEMPT Tue Aug 18
15:32:12 BST 2015 armv7l GNU/Linux

My BLE-stick is recognized and hci0 is up and running. I can scan for
advertising peripherals with "sudo hcitool lescan". This works. But if I
try to connect to a peripheral I always get Connection refused (111). So
I looked at the output of hcidump and found that after the connection is
completed, I get disconnected by remote.

< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr 34:B1:F7:D4:FE:F3 type 0
    interval 4 window 4 initiator_filter 0
    own_bdaddr_type 0 min_interval 15 max_interval 15
    latency 0 supervision_to 3200 min_ce 1 max_ce 1
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 72, role master
      bdaddr 34:B1:F7:D4:FE:F3 (Public)
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
  0000: 48 00                                             H.
> HCI Event: Command Status (0x0f) plen 4
    LE Read Remote Used Features (0x08|0x0016) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Read Remote Used Features Complete
      status 0x00 handle 72
      Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 72 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 72 reason 0x16
    Reason: Connection Terminated by Local Host

I tried three different peripherals and I always get "Connection refused
(111)". Any ideas would be appreciated.

Best regards,
Mike
