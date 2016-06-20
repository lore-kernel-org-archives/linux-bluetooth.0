Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org, aar@pengutronix.de,
	jukka.rissanen@linux.intel.com
Subject: [RFC 3/4] bluetooth: Set 6 byte device addresses
Date: Mon, 20 Jun 2016 10:49:52 +0300
Message-Id: <1466408993-3808-4-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1466408993-3808-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set BTLE MAC addresses that are 6 bytes long and not 8 bytes
that are used in other places with 6lowpan.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
This patch needs to be cleaned up but worksforme.
---
 net/bluetooth/6lowpan.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d020299..2dddb2b 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -80,6 +80,8 @@ struct lowpan_btle_dev {
 	struct delayed_work notify_peers;
 };
 
+static void set_addr(u8 *eui, u8 *addr, u8 addr_type);
+
 static inline struct lowpan_btle_dev *
 lowpan_btle_dev(const struct net_device *netdev)
 {
@@ -272,9 +274,10 @@ static int give_skb_to_upper(struct sk_buff *skb, struct net_device *dev)
 static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 			   struct l2cap_chan *chan)
 {
-	const u8 *saddr, *daddr;
+	const u8 *saddr;
 	struct lowpan_btle_dev *dev;
 	struct lowpan_peer *peer;
+	unsigned char eui64_daddr[EUI64_ADDR_LEN];
 
 	dev = lowpan_btle_dev(netdev);
 
@@ -285,9 +288,9 @@ static int iphc_decompress(struct sk_buff *skb, struct net_device *netdev,
 		return -EINVAL;
 
 	saddr = peer->eui64_addr;
-	daddr = dev->netdev->dev_addr;
+	set_addr(&eui64_daddr[0], chan->src.b, chan->src_type);
 
-	return lowpan_header_decompress(skb, netdev, daddr, saddr);
+	return lowpan_header_decompress(skb, netdev, &eui64_daddr, saddr);
 }
 
 static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
@@ -681,13 +684,6 @@ static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
 	BT_DBG("type %d addr %*phC", addr_type, 8, eui);
 }
 
-static void set_dev_addr(struct net_device *netdev, bdaddr_t *addr,
-		         u8 addr_type)
-{
-	netdev->addr_assign_type = NET_ADDR_PERM;
-	set_addr(netdev->dev_addr, addr->b, addr_type);
-}
-
 static void ifup(struct net_device *netdev)
 {
 	int err;
@@ -795,7 +791,7 @@ static struct l2cap_chan *add_peer_chan(struct l2cap_chan *chan,
 static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 {
 	struct net_device *netdev;
-	int err = 0;
+	int i, err = 0;
 
 	netdev = alloc_netdev(LOWPAN_PRIV_SIZE(sizeof(struct lowpan_btle_dev)),
 			      IFACE_NAME_TEMPLATE, NET_NAME_UNKNOWN,
@@ -803,7 +799,9 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_btle_dev **dev)
 	if (!netdev)
 		return -ENOMEM;
 
-	set_dev_addr(netdev, &chan->src, chan->src_type);
+	netdev->addr_assign_type = NET_ADDR_PERM;
+	for (i = 0; i < sizeof(chan->src); i++)
+		netdev->dev_addr[i] = chan->src.b[sizeof(chan->src) - 1 - i];
 
 	netdev->netdev_ops = &netdev_ops;
 	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
-- 
2.8.1

