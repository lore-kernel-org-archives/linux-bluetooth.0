Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 6/7] Bluetooth: Set route to peer for 6LoWPAN
Date: Wed, 30 Oct 2013 11:01:00 +0200
Message-Id: <1383123661-15087-7-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 1cba7fd..4ec3813 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1372,6 +1372,39 @@ static void set_dev_addr(struct net_device *net, bdaddr_t *addr,
 	net->dev_addr[0] ^= 2;
 }
 
+static int add_peer_route(struct lowpan_info *dev, struct net_device *net,
+			bdaddr_t *addr, u8 addr_type)
+{
+	struct in6_addr peer;
+	struct fib6_config cfg = {
+		.fc_table	= RT6_TABLE_MAIN,
+		.fc_metric	= IP6_RT_PRIO_ADDRCONF,
+		.fc_ifindex	= net->ifindex,
+		.fc_dst_len	= 128,
+		.fc_flags	= RTF_ADDRCONF | RTF_UP |
+					RTF_PREF(ICMPV6_ROUTER_PREF_MEDIUM),
+		.fc_nlinfo.portid = 0,
+		.fc_nlinfo.nlh = NULL,
+		.fc_nlinfo.nl_net = dev_net(net),
+	};
+
+	memset(&peer, 0, sizeof(struct in6_addr));
+
+	/* RFC 2464 ch. 5 */
+	peer.s6_addr[0] = 0xFE;
+	peer.s6_addr[1] = 0x80;
+	set_addr((u8 *)&peer.s6_addr + 8, addr->b, addr_type);
+
+	memcpy(&dev->ieee802154_addr, (u8 *)&peer.s6_addr + 8,
+						IEEE802154_ADDR_LEN);
+
+	BT_DBG("peer address %pI6c", (u8 *)&peer.s6_addr);
+
+	cfg.fc_dst = dev->peer = peer;
+
+	return ip6_route_add(&cfg);
+}
+
 static void ifup(struct net_device *net)
 {
 	int status;
@@ -1448,6 +1481,10 @@ int bt_6lowpan_add_conn(struct l2cap_conn *conn)
 
 	ifup(net);
 
+	if ((status = add_peer_route(dev, net, &dev->addr,
+						conn->hcon->dst_type)) < 0)
+		BT_INFO("Setting route failed %d", status);
+
 	return 0;
 }
 
-- 
1.7.11.7

