Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, aar@pengutronix.de,
	jukka.rissanen@linux.intel.com
Subject: [RFC 0/4] Fix BT 6lowpan point-to-point interface
Date: Mon, 20 Jun 2016 10:49:49 +0300
Message-Id: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


	Hi,

I made an effort some time ago to get the IPv6 ND messages working also
for Bluetooth Low Energy 6lowpan interfaces. The initial discovery was
that they get sent when the interface is not a point-to-point one. The
point-to-point interface flag is removed in patch 4/4.

In order to get the ND messages properly working, the MAC address for a
BTLE interface needs fixing, it's only 48 bits compared to the 64 bits
for 802.15.4. Patches 1/4 and 2/4 fix these common issues.

Patch 3/4, which is more hackish than the others, the patch uses an
array of length EUI64_ADDR_LEN to lowpan_header_decompress() in order
not to overwrite anything

These changes worked when tested against Zephyr, but that was on a
4.5.0-rc2 kernel. This time around I only forward-ported them to latest
and tested that they compiled successfully.

I hope these patches help with ND work moving forward in some way or
another.


Cheers,

	Patrik


Patrik Flykt (4):
  addrconf: Create EUI48 IPv6 addresses for BTLE 6LoWPAN
  6lowpan: Set MAC address lenght according to LOWPAN_LLTYPE
  bluetooth: Set 6 byte device addresses
  bluetooth: Do not set IFF_POINTOPOINT

 net/6lowpan/core.c      | 11 ++++++++++-
 net/bluetooth/6lowpan.c | 25 +++++++++++--------------
 net/ipv6/addrconf.c     |  4 ++++
 3 files changed, 25 insertions(+), 15 deletions(-)

-- 
2.8.1

