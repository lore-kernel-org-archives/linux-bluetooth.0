Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 7/8] Bluetooth: Set route to peer for 6LoWPAN
Date: Fri,  8 Nov 2013 17:23:14 +0200
Message-Id: <1383924195-7936-8-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d33a32e..e70302a 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1395,6 +1395,38 @@ static void set_dev_addr(struct net_device *net, bdaddr_t *addr,
 	net->dev_addr[0] ^= 2;
 }
 
+static int add_peer_route(struct peer *dev, struct net_device *net,
+			bdaddr_t *addr, u8 addr_type)
+{
+	struct in6_addr peer_addr;
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
+	memset(&peer_addr, 0, sizeof(struct in6_addr));
+
+	/* RFC 2464 ch. 5 */
+	peer_addr.s6_addr[0] = 0xFE;
+	peer_addr.s6_addr[1] = 0x80;
+	set_addr((u8 *)&peer_addr.s6_addr + 8, addr->b, addr_type);
+
+	memcpy(&dev->eui64_addr, (u8 *)&peer_addr.s6_addr + 8, EUI64_ADDR_LEN);
+
+	BT_DBG("peer address %pI6c", (u8 *)&peer_addr.s6_addr);
+
+	cfg.fc_dst = dev->peer_addr = peer_addr;
+
+	return ip6_route_add(&cfg);
+}
+
 static void ifup(struct net_device *net)
 {
 	int err;
@@ -1492,6 +1524,11 @@ add_peer:
 	peer_add(dev, peer);
 	write_unlock(&devices_lock);
 
+	err = add_peer_route(peer, dev->net, &conn->hcon->dst,
+						conn->hcon->dst_type);
+	if (err < 0)
+		BT_INFO("Setting route failed %d", err);
+
 out:
 	return err;
 }
-- 
1.8.3.1

