Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/5] Bluetooth: Set route to peer for 6LoWPAN
Date: Wed, 23 Oct 2013 09:52:43 +0300
Message-Id: <1382511164-1989-5-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 net/bluetooth/ble_6lowpan.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/bluetooth/ble_6lowpan.c b/net/bluetooth/ble_6lowpan.c
index 5b3ebe1..44d65b3 100644
--- a/net/bluetooth/ble_6lowpan.c
+++ b/net/bluetooth/ble_6lowpan.c
@@ -1344,6 +1344,39 @@ static void set_addr(u8 *eui, u8 *addr)
 	eui[0] ^= 2;
 }
 
+static int add_peer_route(struct ble_6lowpan_dev_info *dev,
+			struct net_device *net, bdaddr_t *addr)
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
+	set_addr((u8 *)&peer.s6_addr + 8, addr->b);
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
 static void set_dev_addr(struct net_device *net, bdaddr_t *addr)
 {
 	net->addr_assign_type = NET_ADDR_PERM;
@@ -1428,6 +1461,9 @@ int ble_6lowpan_add_conn(struct l2cap_conn *conn)
 		write_unlock(&net_dev_list_lock);
 
 		ifup(net);
+
+		if ((status = add_peer_route(dev, net, &dev->addr)) < 0)
+			BT_INFO("Setting route failed %d", status);
 	}
 
 	return 0;
-- 
1.7.11.7

