Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] Bluetooth: Initial skeleton code for BT LE 6LoWPAN
Date: Wed, 23 Oct 2013 09:52:40 +0300
Message-Id: <1382511164-1989-2-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 include/net/bluetooth/l2cap.h |   1 +
 net/bluetooth/Makefile        |   2 +-
 net/bluetooth/ble_6lowpan.c   | 404 ++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/ble_6lowpan.h   |  27 +++
 net/bluetooth/l2cap_core.c    |  22 ++-
 5 files changed, 454 insertions(+), 2 deletions(-)
 create mode 100644 net/bluetooth/ble_6lowpan.c
 create mode 100644 net/bluetooth/ble_6lowpan.h

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3d922b9..645cd30 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -133,6 +133,7 @@ struct l2cap_conninfo {
 #define L2CAP_FC_L2CAP		0x02
 #define L2CAP_FC_CONNLESS	0x04
 #define L2CAP_FC_A2MP		0x08
+#define L2CAP_FC_6LOWPAN        0x3e
 
 /* L2CAP Control Field bit masks */
 #define L2CAP_CTRL_SAR			0xC000
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 6a791e7..a70625b 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,6 +10,6 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o
+	a2mp.o amp.o ble_6lowpan.o
 
 subdir-ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/ble_6lowpan.c b/net/bluetooth/ble_6lowpan.c
new file mode 100644
index 0000000..0fd3302
--- /dev/null
+++ b/net/bluetooth/ble_6lowpan.c
@@ -0,0 +1,404 @@
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
+#define IFACE_NAME_TEMPLATE "ble6lowpan%d"
+
+/*
+ * The devices list contains those devices that we are acting
+ * as a proxy. The BT LE 6LoWPAN device is a virtual device that
+ * connects to the Bluetooth LE device. The real connection to
+ * BT LE device is done via l2cap layer. There exists one
+ * virtual device / one BT LE 6LoWPAN device. The list contains
+ * struct ble_6lowpan_dev_record elements.
+ */
+static LIST_HEAD(ble_6lowpan_devices);
+DEFINE_RWLOCK(net_dev_list_lock);
+
+struct ble_6lowpan_dev_record {
+	struct net_device *dev;
+	struct delayed_work delete_timer;
+	struct list_head list;
+};
+
+struct ble_6lowpan_dev_info {
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
+ble_6lowpan_dev_info *ble_6lowpan_dev_info(const struct net_device *dev)
+{
+	return netdev_priv(dev);
+}
+
+/* print data in line */
+static inline void ble_6lowpan_raw_dump_inline(const char *caller, char *msg,
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
+static inline void ble_6lowpan_raw_dump_table(const char *caller, char *msg,
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
+static int ble_6lowpan_recv_pkt(struct sk_buff *skb, struct net_device *dev)
+{
+	kfree_skb(skb);
+	return NET_RX_DROP;
+}
+
+/* Packet from BT LE device */
+int ble_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	struct ble_6lowpan_dev_record *entry, *tmp;
+	struct net_device *dev = NULL;
+	int status = -ENOENT;
+
+	write_lock(&net_dev_list_lock);
+
+	list_for_each_entry_safe(entry, tmp, &ble_6lowpan_devices, list) {
+		if (ble_6lowpan_dev_info(entry->dev)->conn == conn) {
+			dev = ble_6lowpan_dev_info(entry->dev)->net;
+			break;
+		}
+	}
+
+	write_unlock(&net_dev_list_lock);
+
+	if (dev) {
+		status = ble_6lowpan_recv_pkt(skb, dev);
+		BT_DBG("recv pkt %d", status);
+	}
+
+	return status;
+}
+
+static void ble_6lowpan_do_send(struct l2cap_conn *conn, struct sk_buff *skb)
+{
+	BT_DBG("conn %p, skb %p len %d priority %u", conn, skb, skb->len,
+	       skb->priority);
+
+	return;
+}
+
+static int lowpan_conn_send(struct l2cap_conn *conn,
+			void *msg, size_t len, u32 priority,
+			struct net_device *dev)
+{
+	struct sk_buff *skb = {0};
+
+	ble_6lowpan_do_send(conn, skb);
+	return 0;
+}
+
+/* Packet to BT LE device */
+static int ble_6lowpan_send(struct l2cap_conn *conn, const void *saddr,
+			const void *daddr, struct sk_buff *skb,
+			struct net_device *dev)
+{
+	ble_6lowpan_raw_dump_table(__func__,
+				"raw skb data dump before fragmentation",
+				skb->data, skb->len);
+
+	return lowpan_conn_send(conn, skb->data, skb->len, 0, dev);
+}
+
+static netdev_tx_t ble_6lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	int err = -1;
+
+	pr_debug("ble 6lowpan packet xmit\n");
+
+	if (ble_6lowpan_dev_info(dev)->conn)
+		err = ble_6lowpan_send(ble_6lowpan_dev_info(dev)->conn,
+				dev->dev_addr,
+				&ble_6lowpan_dev_info(dev)->ieee802154_addr,
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
+static const struct net_device_ops ble_6lowpan_netdev_ops = {
+	.ndo_start_xmit		= ble_6lowpan_xmit,
+};
+
+static void ble_6lowpan_setup(struct net_device *dev)
+{
+	dev->addr_len		= IEEE802154_ADDR_LEN;
+	dev->type		= ARPHRD_IEEE802154;
+
+	dev->hard_header_len	= 0;
+	dev->needed_tailroom	= 0;
+	dev->mtu		= IPV6_MIN_MTU;
+	dev->tx_queue_len	= 0;
+	dev->flags		= IFF_RUNNING | IFF_POINTOPOINT;
+	dev->watchdog_timeo	= 0;
+
+	dev->netdev_ops		= &ble_6lowpan_netdev_ops;
+	dev->destructor		= free_netdev;
+}
+
+static struct device_type ble_type = {
+	.name	= "ble6lowpan",
+};
+
+static void set_addr(u8 *eui, u8 *addr)
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
+}
+
+static void set_dev_addr(struct net_device *net, bdaddr_t *addr)
+{
+	net->addr_assign_type = NET_ADDR_PERM;
+	set_addr(net->dev_addr, addr->b);
+	net->dev_addr[0] ^= 2;
+}
+
+static void ifup(struct net_device *net)
+{
+	int status;
+
+	rtnl_lock();
+	if ((status = dev_open(net)) < 0)
+		BT_INFO("iface %s cannot be opened (%d)", net->name,
+			status);
+	rtnl_unlock();
+}
+
+/*
+ * This gets called when BT LE 6LoWPan device is connected. We then
+ * create network device that acts as a proxy between BT LE device
+ * and kernel network stack.
+ */
+int ble_6lowpan_add_conn(struct l2cap_conn *conn)
+{
+	struct net_device *net;
+	struct ble_6lowpan_dev_info *dev;
+	struct ble_6lowpan_dev_record *entry;
+	int status;
+
+	net = alloc_netdev(sizeof(struct ble_6lowpan_dev_info),
+			IFACE_NAME_TEMPLATE, ble_6lowpan_setup);
+	if (!net)
+		return -ENOMEM;
+
+	dev = netdev_priv(net);
+	dev->net = net;
+
+	memcpy(&dev->myaddr, &conn->hcon->hdev->bdaddr, sizeof(bdaddr_t));
+	memcpy(&dev->addr, &conn->hcon->dst, sizeof(bdaddr_t));
+
+	set_dev_addr(net, &dev->myaddr);
+
+	dev->conn = conn;
+
+	net->netdev_ops = &ble_6lowpan_netdev_ops;
+	SET_NETDEV_DEV(net, &conn->hcon->dev);
+	SET_NETDEV_DEVTYPE(net, &ble_type);
+
+	status = register_netdev(net);
+	if (status < 0) {
+		BT_INFO("register_netdev failed %d", status);
+		free_netdev(net);
+		return status;
+	} else {
+		struct inet6_dev *idev;
+
+		BT_DBG("ifindex %d peer bdaddr %pMR my addr %pMR",
+			net->ifindex, &dev->addr, &dev->myaddr);
+		dev->ifindex = net->ifindex;
+		set_bit(__LINK_STATE_PRESENT, &net->state);
+
+		idev = in6_dev_get(net);
+		if (idev) {
+			idev->cnf.autoconf = 1;
+			idev->cnf.forwarding = 1;
+			idev->cnf.accept_ra = 2;
+
+			in6_dev_put(idev);
+		}
+
+		entry = kzalloc(sizeof(struct ble_6lowpan_dev_record),
+				GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->dev = net;
+
+		write_lock(&net_dev_list_lock);
+		INIT_LIST_HEAD(&entry->list);
+		list_add(&entry->list, &ble_6lowpan_devices);
+		write_unlock(&net_dev_list_lock);
+
+		ifup(net);
+	}
+
+	return 0;
+}
+
+static void delete_timeout(struct work_struct *work)
+{
+	struct ble_6lowpan_dev_record *entry = container_of(work,
+						struct ble_6lowpan_dev_record,
+						delete_timer.work);
+
+	unregister_netdev(entry->dev);
+	kfree(entry);
+}
+
+int ble_6lowpan_del_conn(struct l2cap_conn *conn)
+{
+	struct ble_6lowpan_dev_record *entry, *tmp;
+	int status = -ENOENT;
+
+	write_lock(&net_dev_list_lock);
+
+	list_for_each_entry_safe(entry, tmp, &ble_6lowpan_devices, list) {
+		if (ble_6lowpan_dev_info(entry->dev)->conn == conn) {
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
+static int ble_6lowpan_device_event(struct notifier_block *unused,
+				unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct ble_6lowpan_dev_record *entry, *tmp;
+
+	if (dev->type == ARPHRD_IEEE802154) {
+		switch (event) {
+		case NETDEV_UNREGISTER:
+			write_lock(&net_dev_list_lock);
+			list_for_each_entry_safe(entry, tmp,
+						&ble_6lowpan_devices,
+						list) {
+				if (entry->dev == dev) {
+					list_del(&entry->list);
+					kfree(entry);
+					break;
+				}
+			}
+			write_unlock(&net_dev_list_lock);
+			break;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block ble_6lowpan_dev_notifier = {
+	.notifier_call = ble_6lowpan_device_event,
+};
+
+int ble_6lowpan_init(void)
+{
+	int err;
+
+	err = register_netdevice_notifier(&ble_6lowpan_dev_notifier);
+
+	return err;
+}
+
+void ble_6lowpan_cleanup(void)
+{
+	unregister_netdevice_notifier(&ble_6lowpan_dev_notifier);
+}
diff --git a/net/bluetooth/ble_6lowpan.h b/net/bluetooth/ble_6lowpan.h
new file mode 100644
index 0000000..7975a55
--- /dev/null
+++ b/net/bluetooth/ble_6lowpan.h
@@ -0,0 +1,27 @@
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
+#ifndef __BLE_LOWPAN_H
+#define __BLE_LOWPAN_H
+
+#include <linux/skbuff.h>
+#include <net/bluetooth/l2cap.h>
+
+int ble_6lowpan_recv(struct l2cap_conn *conn, struct sk_buff *skb);
+int ble_6lowpan_add_conn(struct l2cap_conn *conn);
+int ble_6lowpan_del_conn(struct l2cap_conn *conn);
+int ble_6lowpan_init(void);
+void ble_6lowpan_cleanup(void);
+bool ble_6lowpan_is_enabled(struct hci_dev *hdev, bdaddr_t *dst);
+
+#endif /* __BLE_LOWPAN_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d52bd0d..fb1a49c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -40,6 +40,7 @@
 #include "smp.h"
 #include "a2mp.h"
 #include "amp.h"
+#include "ble_6lowpan.h"
 
 bool disable_ertm;
 
@@ -6500,6 +6501,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 			l2cap_conn_del(conn->hcon, EACCES);
 		break;
 
+	case L2CAP_FC_6LOWPAN:
+		ble_6lowpan_recv(conn, skb);
+		break;
+
 	default:
 		l2cap_data_channel(conn, cid, skb);
 		break;
@@ -6537,6 +6542,11 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return exact ? lm1 : lm2;
 }
 
+static bool is_ble_6lowpan(void)
+{
+	return false;
+}
+
 void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn;
@@ -6545,8 +6555,12 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
 
 	if (!status) {
 		conn = l2cap_conn_add(hcon);
-		if (conn)
+		if (conn) {
 			l2cap_conn_ready(conn);
+
+			if (hcon->type == LE_LINK && is_ble_6lowpan())
+				ble_6lowpan_add_conn(conn);
+		}
 	} else {
 		l2cap_conn_del(hcon, bt_to_errno(status));
 	}
@@ -6567,6 +6581,9 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 {
 	BT_DBG("hcon %p reason %d", hcon, reason);
 
+	if (hcon->type == LE_LINK && is_ble_6lowpan())
+		ble_6lowpan_del_conn(hcon->l2cap_data);
+
 	l2cap_conn_del(hcon, bt_to_errno(reason));
 }
 
@@ -6849,11 +6866,14 @@ int __init l2cap_init(void)
 	l2cap_debugfs = debugfs_create_file("l2cap", 0444, bt_debugfs,
 					    NULL, &l2cap_debugfs_fops);
 
+	ble_6lowpan_init();
+
 	return 0;
 }
 
 void l2cap_exit(void)
 {
+	ble_6lowpan_cleanup();
 	debugfs_remove(l2cap_debugfs);
 	l2cap_cleanup_sockets();
 }
-- 
1.7.11.7

