Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: alex.aring@gmail.com
Subject: [PATCH 0/2] Bluetooth: 6lowpan: Fix multicast support
Date: Mon, 29 Sep 2014 16:37:24 +0300
Message-Id: <1411997846-23949-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

patch 1 implements similar issue that was done for IEEE 802.154
6LoWPAN in commit f19f4f9525cf32f9 ("ieee802154: 6lowpan: ensure
header compression does not corrupt ipv6 header") few days ago.
So we copy the skb before mangling the IPv6 headers in the packet
so that it does not get corrupted if sent to non-6lowpan interface,
like when sending multicast packet to more that one interface.

The multicast support was disabled for the interface so the
issue fixed in patch 1 is not really seen earlier. The patch 2
enables multicast support for the 6lowpan network interface.


Cheers,
Jukka


Jukka Rissanen (2):
  Bluetooth: 6lowpan: Ensure header compression does not corrupt IPv6
    header
  Bluetooth: 6lowpan: Enable multicast support

 net/bluetooth/6lowpan.c | 140 +++++++++++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 54 deletions(-)

-- 
1.8.3.1

