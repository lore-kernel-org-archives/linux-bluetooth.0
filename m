Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: patrik.flykt@linux.intel.com, aar@pengutronix.de
Subject: [PATCH 0/5] Bluetooth: 6LoWPAN: Fix lladdr length
Date: Thu,  9 Feb 2017 16:55:46 +0200
Message-Id: <20170209145551.12747-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These patches fixes lladdr length to be 6 bytes long and not 8 which cause
neighbor advertisement to be sent with wrong lladdr including FF:FE filler
bytes for eui64.

Note: This does not fix some of the existing crashes which I hope to address
in a different set.

Alexander Aring (2):
  6lowpan: iphc: override l2 packet information
  ipv6: addrconf: fix 48 bit 6lowpan autoconfiguration

Luiz Augusto von Dentz (1):
  6lowpan: Use netdev addr_len to determine lladdr len

Patrik Flykt (2):
  bluetooth: Set 6 byte device addresses
  6lowpan: Set MAC address lenght according to LOWPAN_LLTYPE

 net/6lowpan/core.c      | 11 ++++++++++-
 net/6lowpan/iphc.c      | 25 ++++++++++++++++++++++--
 net/bluetooth/6lowpan.c | 52 +++++++++++++------------------------------------
 net/ipv6/addrconf.c     | 17 +++++++++++-----
 4 files changed, 58 insertions(+), 47 deletions(-)

-- 
2.9.3

