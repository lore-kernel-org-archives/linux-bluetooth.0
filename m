Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 3/7] Bluetooth: Initial skeleton code for BT 6LoWPAN
Date: Wed, 30 Oct 2013 11:00:57 +0200
Message-Id: <1383123661-15087-4-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383123661-15087-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/l2cap.h |   1 +
 net/bluetooth/6lowpan.c       | 401 ++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/6lowpan.h       |  26 +++
 net/bluetooth/Makefile        |   2 +-
 net/bluetooth/l2cap_core.c    |  22 ++-
 5 files changed, 450 insertions(+), 2 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.c
 create mode 100644 net/bluetooth/6lowpan.h

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5132990..c28ac0d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -133,6 +133,7 @@ struct l2cap_conninfo {
 #define L2CAP_FC_L2CAP		0x02
 #define L2CAP_FC_CONNLESS	0x04
 #define L2CAP_FC_A2MP		0x08
+#define L2CAP_FC_6LOWPAN        0x3e
 
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
new file mode 100644
index 0000000..aff478b
--- /dev/null
+++ b/net/bluetooth/6lowpan.c
@@ -0,0 +1,401 @@
+/*
+   Copyright (c) 2013 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#include <linux/version.h>
+#include <linux/bitops.h>
+#include <linux/if_arp.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
+#include <net/ipv6.h>
+#include <net/ip6_route.h>
+#include <net/addrconf.h>
+
+#include <net/af_ieee802154.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+
+#include "../ieee802154/6lowpan.h" /* for the compression defines */
+
+#define IFACE_NAME_TEMPLATE "bt%d"
+
+/*
+ * The devices list contains those devices that we are acting
+ * as a proxy. The BT 6LoWPAN device is a virtual device that
+ * connects to the Bluetooth LE device. The real connection to
+ * BT device is done via l2cap layer. There exists one
+ * virtual device / one BT 6LoWPAN device. The list contains
+ * struct lowpan_dev elements.
+ */
+static LIST_HEAD(bt_6lowpan_devices);
+DEFINE_RWLOCK(net_dev_list_lock);
+
+struct lowpan_dev {
+	struct net_device *dev;
+	struct delayed_work delete_timer;
+	struct list_head list;
+};
+
+struct lowpan_info {
+	struct net_device *net;
+	struct l2cap_conn *conn;
+	uint16_t ifindex;
+	bdaddr_t myaddr;
+
+	/* peer addresses in various formats */
+	bdaddr_t addr;
+	unsigned char ieee802154_addr[IEEE802154_ADDR_LEN];
+	struct in6_addr peer;
+};
+
+struct lowpan_fragment {
+	struct sk_buff		*skb;		/* skb to be assembled */
+	u16			length;		/* length to be assemled */
+	u32			bytes_rcv;	/* bytes received */
+	u16			tag;		/* current fragment tag */
+	struct timer_list	timer;		/* assembling timer */
+	struct list_head	list;		/* fragments list */
+};
+
+#define DELETE_TIMEOUT msecs_to_jiffies(1)
+
+/* TTL uncompression values */
+static const u8 lowpan_ttl_values[] = {0, 1, 64, 255};
+
+static inline struct
+lowpan_info *lowpan_info(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
+
+/* print data in line */
+static inline void raw_dump_inline(const char *caller, char *msg,
+				   unsigned char *buf, int len)
+{
+#ifdef DEBUG
+	if (msg)
+		pr_debug("%s():%s: ", caller, msg);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
+		       16, 1, buf, len, false);
+#endif /* DEBUG */
+}
+
+/*
+ * print data in a table format:
+ *
+ * addr: xx xx xx xx xx xx
+ * addr: xx xx xx xx xx xx
+ * ...
+ */
+static inline void raw_dump_table(const char *caller, char *msg,
+				   unsigned char *buf, int len)
+{
+#ifdef DEBUG
+	if (msg)
+		pr_debug("%s():%s:\n", caller, msg);
+	print_hex_dump(KERN_DEBUG, "\t", DUMP_PREFIX_OFFSET,
+		       16, 1, buf, len, false);
+#endif /* DEBUG */
+}
+
+static int recv_pkt(struct sk_buff *skb, struct net_device *dev)
+{
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+/* Packet from BT LE device */
+int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct lowpan_dev *entry, *tmp;
+	struct net_device *dev = NULL;
+	int status = -ENOENT;
+
+	write_lock(&net_dev_list_lock);
+
+	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
+		if (lowpan_info(entry->dev)->conn == conn) {
+			dev = lowpan_info(entry->dev)->net;
+			break;
+		}
+	}
+
+	write_unlock(&net_dev_list_lock);
+
+	if (dev) {
+		status = recv_pkt(skb, dev);
+		BT_DBG("recv pkt %d", status);
+	}
+
+	return status;
+}
+
+static void do_send(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	BT_DBG("conn %p, skb %p len %d priority %u", conn, skb, skb->len,
+	       skb->priority);
+
+	return;
+}
+
+static int conn_send(struct l2cap_conn *conn,
+			void *msg, size_t len, u32 priority,
+			struct net_device *dev)
+{
+	struct sk_buff *skb = {0};
+
+	do_send(conn, skb);
+	return 0;
+}
+
+/* Packet to BT LE device */
+static int send_pkt(struct l2cap_conn *conn, const void *saddr,
+			const void *daddr, struct sk_buff *skb,
+			struct net_device *dev)
+{
+	raw_dump_table(__func__, "raw skb data dump before fragmentation",
+				skb->data, skb->len);
+
+	return conn_send(conn, skb->data, skb->len, 0, dev);
+}
+
+static netdev_tx_t xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	int err = -1;
+
+	pr_debug("ble 6lowpan packet xmit\n");
+
+	if (lowpan_info(dev)->conn)
+		err = send_pkt(lowpan_info(dev)->conn,
+				dev->dev_addr,
+				&lowpan_info(dev)->ieee802154_addr,
+				skb,
+				dev);
+	else
+		BT_DBG("ERROR: no BT LE 6LoWPAN device found");
+
+	dev_kfree_skb(skb);
+
+	if (err)
+		BT_DBG("ERROR: xmit failed (%d)", err);
+
+	return (err < 0) ? NET_XMIT_DROP : err;
+}
+
+static const struct net_device_ops netdev_ops = {
+	.ndo_start_xmit		= xmit,
+};
+
+static void setup(struct net_device *dev)
+{
+	dev->addr_len		= IEEE802154_ADDR_LEN;
+	dev->type		= ARPHRD_RAWIP;
+
+	dev->hard_header_len	= 0;
+	dev->needed_tailroom	= 0;
+	dev->mtu		= IPV6_MIN_MTU;
+	dev->tx_queue_len	= 0;
+	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT;
+	dev->watchdog_timeo	= 0;
+
+	dev->netdev_ops		= &netdev_ops;
+	dev->destructor		= free_netdev;
+}
+
+static struct device_type bt_type = {
+	.name	= "bluetooth",
+};
+
+static void set_addr(u8 *eui, u8 *addr, u8 addr_type)
+{
+	/* addr is the BT address in little-endian format */
+	eui[0] = addr[5];
+	eui[1] = addr[4];
+	eui[2] = addr[3];
+	eui[3] = 0xFF;
+	eui[4] = 0xFE;
+	eui[5] = addr[2];
+	eui[6] = addr[1];
+	eui[7] = addr[0];
+
+	eui[0] ^= 2;
+
+	if (addr_type == BDADDR_LE_PUBLIC)
+		eui[0] &= ~1;
+	else
+		eui[0] |= 1;
+}
+
+static void set_dev_addr(struct net_device *net, bdaddr_t *addr,
+			u8 addr_type)
+{
+	net->addr_assign_type = NET_ADDR_PERM;
+	set_addr(net->dev_addr, addr->b, addr_type);
+	net->dev_addr[0] ^= 2;
+}
+
+static void ifup(struct net_device *net)
+{
+	int status;
+
+	rtnl_lock();
+	if ((status = dev_open(net)) < 0)
+		BT_INFO("iface %s cannot be opened (%d)", net->name, status);
+	rtnl_unlock();
+}
+
+/*
+ * This gets called when BT LE 6LoWPAN device is connected. We then
+ * create network device that acts as a proxy between BT LE device
+ * and kernel network stack.
+ */
+int bt_6lowpan_add_conn(struct l2cap_conn *conn)
+{
+	struct net_device *net;
+	struct lowpan_info *dev;
+	struct lowpan_dev *entry;
+	struct inet6_dev *idev;
+	int status;
+
+	net = alloc_netdev(sizeof(struct lowpan_info), IFACE_NAME_TEMPLATE,
+								setup);
+	if (!net)
+		return -ENOMEM;
+
+	dev = netdev_priv(net);
+	dev->net = net;
+
+	memcpy(&dev->myaddr, &conn->hcon->src, sizeof(bdaddr_t));
+	memcpy(&dev->addr, &conn->hcon->dst, sizeof(bdaddr_t));
+
+	set_dev_addr(net, &dev->myaddr, conn->hcon->src_type);
+
+	dev->conn = conn;
+
+	net->netdev_ops = &netdev_ops;
+	SET_NETDEV_DEV(net, &conn->hcon->dev);
+	SET_NETDEV_DEVTYPE(net, &bt_type);
+
+	status = register_netdev(net);
+	if (status < 0) {
+		BT_INFO("register_netdev failed %d", status);
+		free_netdev(net);
+		return status;
+	}
+
+	BT_DBG("ifindex %d peer bdaddr %pMR my addr %pMR",
+		net->ifindex, &dev->addr, &dev->myaddr);
+	dev->ifindex = net->ifindex;
+	set_bit(__LINK_STATE_PRESENT, &net->state);
+
+	idev = in6_dev_get(net);
+	if (idev) {
+		idev->cnf.autoconf = 1;
+		idev->cnf.forwarding = 1;
+		idev->cnf.accept_ra = 2;
+
+		in6_dev_put(idev);
+	}
+
+	entry = kzalloc(sizeof(struct lowpan_dev), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->dev = net;
+
+	write_lock(&net_dev_list_lock);
+	INIT_LIST_HEAD(&entry->list);
+	list_add(&entry->list, &bt_6lowpan_devices);
+	write_unlock(&net_dev_list_lock);
+
+	ifup(net);
+
+	return 0;
+}
+
+static void delete_timeout(struct work_struct *work)
+{
+	struct lowpan_dev *entry = container_of(work, struct lowpan_dev,
+						delete_timer.work);
+
+	unregister_netdev(entry->dev);
+	kfree(entry);
+}
+
+int bt_6lowpan_del_conn(struct l2cap_conn *conn)
+{
+	struct lowpan_dev *entry, *tmp;
+	int status = -ENOENT;
+
+	write_lock(&net_dev_list_lock);
+
+	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
+		if (lowpan_info(entry->dev)->conn == conn) {
+			list_del(&entry->list);
+			status = 0;
+			break;
+		}
+	}
+
+	write_unlock(&net_dev_list_lock);
+
+	if (!status) {
+		INIT_DELAYED_WORK(&entry->delete_timer, delete_timeout);
+		schedule_delayed_work(&entry->delete_timer, DELETE_TIMEOUT);
+	}
+
+	return status;
+}
+
+static int device_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct lowpan_dev *entry, *tmp;
+
+	if (dev->type != ARPHRD_RAWIP)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+		write_lock(&net_dev_list_lock);
+		list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices,
+					list) {
+			if (entry->dev == dev) {
+				list_del(&entry->list);
+				kfree(entry);
+				break;
+			}
+		}
+		write_unlock(&net_dev_list_lock);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block bt_6lowpan_dev_notifier = {
+	.notifier_call = device_event,
+};
+
+int bt_6lowpan_init(void)
+{
+	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
+}
+
+void bt_6lowpan_cleanup(void)
+{
+	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
+}
diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
new file mode 100644
index 0000000..680eac8
--- /dev/null
+++ b/net/bluetooth/6lowpan.h
@@ -0,0 +1,26 @@
+/*
+   Copyright (c) 2013 Intel Corp.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 and
+   only version 2 as published by the Free Software Foundation.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+*/
+
+#ifndef __6LOWPAN_H
+#define __6LOWPAN_H
+
+#include <linux/skbuff.h>
+#include <net/bluetooth/l2cap.h>
+
+int bt_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb);
+int bt_6lowpan_add_conn(struct l2cap_conn *conn);
+int bt_6lowpan_del_conn(struct l2cap_conn *conn);
+int bt_6lowpan_init(void);
+void bt_6lowpan_cleanup(void);
+
+#endif /* __6LOWPAN_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 6a791e7..80cb215 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o
+	a2mp.o amp.o 6lowpan.o
 
 subdir-ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0cef677..c47215f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -40,6 +40,7 @@
 #include "smp.h"
 #include "a2mp.h"
 #include "amp.h"
+#include "6lowpan.h"
 
 bool disable_ertm;
 
@@ -6470,6 +6471,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 			l2cap_conn_del(conn->hcon, EACCES);
 		break;
 
+	case L2CAP_FC_6LOWPAN:
+		bt_6lowpan_recv(conn, skb);
+		break;
+
 	default:
 		l2cap_data_channel(conn, cid, skb);
 		break;
@@ -6507,6 +6512,11 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return exact ? lm1 : lm2;
 }
 
+static bool is_bt_6lowpan(void)
+{
+	return false;
+}
+
 void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
@@ -6515,8 +6525,12 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 	if (!status) {
 		conn = l2cap_conn_add(hcon);
-		if (conn)
+		if (conn) {
 			l2cap_conn_ready(conn);
+
+			if (hcon->type == LE_LINK && is_bt_6lowpan())
+				bt_6lowpan_add_conn(conn);
+		}
 	} else {
 		l2cap_conn_del(hcon, bt_to_errno(status));
 	}
@@ -6537,6 +6551,9 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
+	if (hcon->type == LE_LINK && is_bt_6lowpan())
+		bt_6lowpan_del_conn(hcon->l2cap_data);
+
 	l2cap_conn_del(hcon, bt_to_errno(reason));
 }
 
@@ -6814,11 +6831,14 @@ int __init l2cap_init(void)
 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
 					    NULL, &l2cap_debugfs_fops);
 
+	bt_6lowpan_init();
+
 	return 0;
 }
 
 void l2cap_exit(void)
 {
+	bt_6lowpan_cleanup();
 	debugfs_remove(l2cap_debugfs);
 	l2cap_cleanup_sockets();
 }
-- 
1.7.11.7

