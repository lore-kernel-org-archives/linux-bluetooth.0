Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: 6lowpan: Set the peer IPv6 address correctly
Date: Mon,  8 Sep 2014 12:11:44 +0300
Message-Id: <1410167505-30889-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1410167505-30889-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1410167505-30889-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The peer IPv6 address contained wrong U/L bit in the EUI-64 part.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 5532e6e..b229aed 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -671,6 +671,14 @@ static struct l2cap_chan *chan_open(struct l2cap_chan *pchan)
 	return chan;
 }
 
+static void set_ip_addr_bits(u8 addr_type, u8 *addr)
+{
+	if (addr_type == BDADDR_LE_PUBLIC)
+		*addr |= 0x02;
+	else
+		*addr &= ~0x02;
+}
+
 static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 					struct lowpan_dev *dev)
 {
@@ -693,6 +701,11 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 	memcpy(&peer->eui64_addr, (u8 *)&peer->peer_addr.s6_addr + 8,
 	       EUI64_ADDR_LEN);
 
+	/* IPv6 address needs to have the U/L bit set properly so toggle
+	 * it back here.
+	 */
+	set_ip_addr_bits(chan->dst_type, (u8 *)&peer->peer_addr.s6_addr + 8);
+
 	write_lock_irqsave(&devices_lock, flags);
 	INIT_LIST_HEAD(&peer->list);
 	peer_add(dev, peer);
-- 
1.8.3.1

