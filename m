Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	linux-wpan@vger.kernel.org,
	kernel@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 0/4] ieee802154: mrf24j40 cleanups and 6lowpan fix
Date: Wed, 24 Sep 2014 12:21:29 +0200
Message-Id: <1411554093-14976-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this patches series contains cleanups for the mrf24j40 driver of the 802.15.4 subsystem.
Also one patch to fix a 802.15.4 6LoWPAN bug if we replace the IPv6 header with 6LoWPAN
header on a shared skb data buffer.

- Alex

Simon Vincent (1):
  ieee802154: 6lowpan: ensure header compression does not corrupt ipv6
    header

Varka Bhadram (3):
  mrf24j40: fix Missing a blank line after declarations
  mrf24j40: remove unnecessary return statement
  mrf24j40: use pr_* / dev_* instead of printk()

 drivers/net/ieee802154/mrf24j40.c |  19 +++---
 net/ieee802154/6lowpan_rtnl.c     | 125 +++++++++++++++++++++++++++-----------
 2 files changed, 99 insertions(+), 45 deletions(-)

-- 
2.1.0
