Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/5] Bluetooth LE 6LoWPAN
Date: Wed, 23 Oct 2013 09:52:39 +0300
Message-Id: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is 6LoWPAN code for BT LE as described in
http://tools.ietf.org/html/draft-ietf-6lowpan-btle-12

The code is not yet ready for prime time but is sent
in order to get discussion started.

The devices need to be setup manually in this version.
This is implemented in patch 5. That patch is just a
temporary one and will be eventually removed when the
devices can discover the 6LoWPAN service automatically.

Test usage:
You have two devices with BlueZ 5 stack in them
     device1  00:11:22:33:44:55
     device2  66:77:88:99:00:11

First add the desired devices manually into kernel
root@device1# echo 66:77:88:99:00:11 > /sys/kernel/debug/bluetooth/hci0/ble6lowpan
root@device2# echo 00:11:22:33:44:55 > /sys/kernel/debug/bluetooth/hci0/ble6lowpan

then connect the devices
root@device1# hciconfig hci0 leadv
root@device2# hcitool lecc 00:11:22:33:44:55

if the connection is established, then you can send IPv6 packets
between these two systems using the link local addresses

root@device1# ping6 fe80::6477:88ff:fe99:0011
root@device2# ping6 fe80::211:22ff:fe33:4455

the ble6lowpan0 interface is created and routes to peer are
automatically setup.

By default 6LoWPAN connection is not established between devices,
so you need to add the MAC addresses manually into the
/sys/kernel/debug/bluetooth/hci0/ble6lowpan file.
If you want to prevent further connections you can remove
MAC address from the debugfs file like this
echo "00:11:22:33:44:55 d" > /sys/kernel/debug/bluetooth/hci0/ble6lowpan
Rebooting or unloading the bluetooth kernel module will also clear the
settings from the kernel.


Areas of improvement:
- route setting could be done in user space
- ARP type is set to IEEE802154 but the transferred packets are actually
  not that type
- discovery of 6LoWPAN service needs be automatic
- split patches more, especially number 2 is a bit too big


Cheers,
Jukka


Jukka Rissanen (5):
  Bluetooth: Initial skeleton code for BT LE 6LoWPAN
  Bluetooth: Enable 6LoWPAN support for BT LE devices
  route: Exporting ip6_route_add() so that BLE 6LoWPAN can use it
  Bluetooth: Set route to peer for 6LoWPAN
  Bluetooth: Manually enable or disable 6lowpan between devices

 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/Makefile        |    2 +-
 net/bluetooth/ble_6lowpan.c   | 1714 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/ble_6lowpan.h   |   28 +
 net/bluetooth/hci_core.c      |    4 +
 net/bluetooth/l2cap_core.c    |   20 +-
 net/ipv6/route.c              |    1 +
 7 files changed, 1768 insertions(+), 2 deletions(-)
 create mode 100644 net/bluetooth/ble_6lowpan.c
 create mode 100644 net/bluetooth/ble_6lowpan.h

-- 
1.7.11.7

