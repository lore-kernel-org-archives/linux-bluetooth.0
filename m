Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] Bluetooth: 6lowpan: Add connect/disconnect management commands
Date: Thu, 18 Dec 2014 14:23:52 +0200
Message-Id: <1418905432-19793-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow user space to connect and disconnect a 6lowpan connection via
management interface.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/mgmt.h |  15 +++++++
 net/bluetooth/6lowpan.c      |  17 ++++++-
 net/bluetooth/6lowpan.h      |  18 ++++++++
 net/bluetooth/mgmt.c         | 103 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+), 2 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.h

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 95c34d5..ae69822 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -507,6 +507,14 @@ struct mgmt_cp_start_service_discovery {
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
+#define MGMT_OP_6LOWPAN_CONNECT		0x003B
+#define MGMT_OP_6LOWPAN_DISCONNECT	0x003C
+struct mgmt_cp_6lowpan_info {
+	uint8_t addr_type;
+	bdaddr_t bdaddr;
+} __packed;
+#define MGMT_6LOWPAN_INFO_SIZE		7
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
@@ -689,3 +697,10 @@ struct mgmt_ev_new_conn_param {
 #define MGMT_EV_UNCONF_INDEX_REMOVED	0x001e
 
 #define MGMT_EV_NEW_CONFIG_OPTIONS	0x001f
+
+#define MGMT_EV_6LOWPAN_CONNECTED	0x0020
+#define MGMT_EV_6LOWPAN_DISCONNECTED	0x0021
+struct mgmt_ev_6lowpan_conn_param {
+	struct mgmt_addr_info addr;
+	uint32_t ifindex;
+} __packed;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index bdcaefd..c72d05c 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -26,9 +26,12 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/mgmt.h>
 
 #include <net/6lowpan.h> /* for the compression support */
 
+#include "6lowpan.h"
+
 #define VERSION "0.1"
 
 static struct dentry *lowpan_psm_debugfs;
@@ -912,6 +915,10 @@ static inline void chan_ready_cb(struct l2cap_chan *chan)
 
 	add_peer_chan(chan, dev);
 	ifup(dev->netdev);
+
+	mgmt_send_6lowpan_event(dev->hdev, chan->conn->hcon,
+				MGMT_EV_6LOWPAN_CONNECTED,
+				dev->netdev->ifindex);
 }
 
 static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan *pchan)
@@ -970,6 +977,10 @@ static void chan_close_cb(struct l2cap_chan *chan)
 			BT_DBG("chan %p orig refcnt %d", chan,
 			       atomic_read(&chan->kref.refcount));
 
+			mgmt_send_6lowpan_event(dev->hdev, chan->conn->hcon,
+						MGMT_EV_6LOWPAN_DISCONNECTED,
+						dev->netdev->ifindex);
+
 			l2cap_chan_put(chan);
 			break;
 		}
@@ -1078,7 +1089,7 @@ static struct l2cap_chan *chan_get(void)
 	return pchan;
 }
 
-static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
+int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 {
 	struct l2cap_chan *pchan;
 	int err;
@@ -1096,8 +1107,9 @@ static int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(bt_6lowpan_connect);
 
-static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
+int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 {
 	struct lowpan_peer *peer;
 
@@ -1113,6 +1125,7 @@ static int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bt_6lowpan_disconnect);
 
 static struct l2cap_chan *bt_6lowpan_listen(void)
 {
diff --git a/net/bluetooth/6lowpan.h b/net/bluetooth/6lowpan.h
new file mode 100644
index 0000000..3886003
--- /dev/null
+++ b/net/bluetooth/6lowpan.h
@@ -0,0 +1,18 @@
+/*
+   Copyright (c) 2014 Intel Corp.
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
+int bt_6lowpan_connect(bdaddr_t *addr, u8 dst_type);
+int bt_6lowpan_disconnect(struct l2cap_conn *conn, u8 dst_type);
+
+void mgmt_send_6lowpan_event(struct hci_dev *hdev, struct hci_conn *conn,
+			     u8 event_type, uint32_t ifindex);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 23a0ca5..0542742 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -33,6 +33,7 @@
 #include <net/bluetooth/mgmt.h>
 
 #include "smp.h"
+#include "6lowpan.h"
 
 #define MGMT_VERSION	1
 #define MGMT_REVISION	8
@@ -94,6 +95,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_EXTERNAL_CONFIG,
 	MGMT_OP_SET_PUBLIC_ADDRESS,
 	MGMT_OP_START_SERVICE_DISCOVERY,
+	MGMT_OP_6LOWPAN_CONNECT,
+	MGMT_OP_6LOWPAN_DISCONNECT,
 };
 
 static const u16 mgmt_events[] = {
@@ -126,6 +129,8 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_UNCONF_INDEX_ADDED,
 	MGMT_EV_UNCONF_INDEX_REMOVED,
 	MGMT_EV_NEW_CONFIG_OPTIONS,
+	MGMT_EV_6LOWPAN_CONNECTED,
+	MGMT_EV_6LOWPAN_DISCONNECTED,
 };
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
@@ -5827,6 +5832,102 @@ unlock:
 	return err;
 }
 
+static int connect_6lowpan(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 len)
+{
+#ifdef CONFIG_BT_6LOWPAN
+	struct mgmt_cp_6lowpan_info *cp = data;
+	struct hci_conn *hcon;
+	int err;
+
+	BT_DBG("");
+
+	if (!bdaddr_type_is_valid(cp->addr_type))
+		return cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	if (cp->addr_type == BDADDR_BREDR)
+		return cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+	if (!hcon) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
+				 MGMT_STATUS_NO_RESOURCES);
+		goto failed;
+	}
+
+	err = bt_6lowpan_connect(&cp->bdaddr, cp->addr_type);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+#else
+	return cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_CONNECT,
+			  MGMT_STATUS_NOT_SUPPORTED);
+#endif
+}
+
+static int disconnect_6lowpan(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+#ifdef CONFIG_BT_6LOWPAN
+	struct mgmt_cp_6lowpan_info *cp = data;
+	struct hci_conn *hcon;
+	int err;
+
+	BT_DBG("");
+
+	if (!bdaddr_type_is_valid(cp->addr_type))
+		return cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	if (cp->addr_type == BDADDR_BREDR)
+		return cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	hci_dev_lock(hdev);
+
+	hcon = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->bdaddr);
+	if (!hcon) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
+				 MGMT_STATUS_NOT_CONNECTED);
+		goto failed;
+	}
+
+	err = bt_6lowpan_disconnect((struct l2cap_conn *)hcon->l2cap_data,
+				    cp->addr_type);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+#else
+	return cmd_status(sk, hdev->id, MGMT_OP_6LOWPAN_DISCONNECT,
+			  MGMT_STATUS_NOT_SUPPORTED);
+#endif
+}
+
+void mgmt_send_6lowpan_event(struct hci_dev *hdev, struct hci_conn *conn,
+			     u8 event_type, uint32_t ifindex)
+{
+#ifdef CONFIG_BT_6LOWPAN
+	struct mgmt_ev_6lowpan_conn_param ev;
+
+	BT_DBG("%s 6lowpan %s", hdev->name,
+	       event_type == MGMT_EV_6LOWPAN_CONNECTED ? "connected" :
+							 "disconnected");
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev.ifindex = ifindex;
+
+	mgmt_event(event_type, hdev, &ev, sizeof(ev), NULL);
+#endif
+}
+EXPORT_SYMBOL_GPL(mgmt_send_6lowpan_event);
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -5892,6 +5993,8 @@ static const struct mgmt_handler {
 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
 	{ start_service_discovery,true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
+	{ connect_6lowpan,        false, MGMT_6LOWPAN_INFO_SIZE },
+	{ disconnect_6lowpan,     false, MGMT_6LOWPAN_INFO_SIZE },
 };
 
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
-- 
1.8.3.1

