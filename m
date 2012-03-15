Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 08/30] Bluetooth: A2MP: AMP Manager basic functions
Date: Thu, 15 Mar 2012 14:29:59 +0200
Message-Id: <1331814621-13905-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define AMP Manager and some basic functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |   30 +++++++++++++++++++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/a2mp.c             |   53 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |   15 ++++++++++
 4 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 include/net/bluetooth/a2mp.h

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
new file mode 100644
index 0000000..0fe8ddd
--- /dev/null
+++ b/include/net/bluetooth/a2mp.h
@@ -0,0 +1,30 @@
+/*
+   Copyright (c) 2010,2011 Code Aurora Forum.  All rights reserved.
+   Copyright (c) 2011,2012 Intel Corp.
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
+#ifndef __A2MP_H
+#define __A2MP_H
+
+struct amp_mgr {
+	struct list_head	list;
+	struct l2cap_conn	*l2cap_conn;
+	struct l2cap_chan	*a2mp_chan;
+	struct kref		kref;
+	__u8			ident;
+	unsigned long		flags;
+};
+
+void amp_mgr_get(struct amp_mgr *mgr);
+int amp_mgr_put(struct amp_mgr *mgr);
+
+#endif /* __A2MP_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 74dfefa..828fc7b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -319,6 +319,7 @@ struct hci_conn {
 
 	struct sk_buff_head data_q;
 	struct list_head chan_list;
+	struct list_head mgr_list;
 
 	struct delayed_work disc_work;
 	struct timer_list idle_timer;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 52bb7d8..66edcfa 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -14,6 +14,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
 
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
@@ -61,3 +62,55 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
 
 	return chan;
 }
+
+/* AMP Manager functions */
+void amp_mgr_get(struct amp_mgr *mgr)
+{
+	BT_DBG("mgr %p", mgr);
+
+	kref_get(&mgr->kref);
+}
+
+static void amp_mgr_destroy(struct kref *kref)
+{
+	struct amp_mgr *mgr;
+	mgr = container_of(kref, struct amp_mgr, kref);
+
+	BT_DBG("mgr %p", mgr);
+
+	kfree(mgr);
+}
+
+int amp_mgr_put(struct amp_mgr *mgr)
+{
+	BT_DBG("mgr %p", mgr);
+
+	return kref_put(&mgr->kref, &amp_mgr_destroy);
+}
+
+static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
+{
+	struct amp_mgr *mgr;
+
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return NULL;
+
+	BT_DBG("conn %p mgr %p", conn, mgr);
+
+	mgr->l2cap_conn = conn;
+
+	mgr->a2mp_chan = open_a2mp_chan(conn);
+	if (!mgr->a2mp_chan) {
+		kfree(mgr);
+		return NULL;
+	}
+
+	mgr->a2mp_chan->data = mgr;
+
+	list_add(&mgr->list, &conn->hcon->mgr_list);
+
+	kref_init(&mgr->kref);
+
+	return mgr;
+}
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2a96211..472cf32 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -43,6 +43,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
 
 static void hci_le_connect(struct hci_conn *conn)
 {
@@ -407,6 +408,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	INIT_LIST_HEAD(&conn->chan_list);
 
+	INIT_LIST_HEAD(&conn->mgr_list);
+
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
 	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
@@ -427,6 +430,16 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	return conn;
 }
 
+static void hci_amp_mgr_list_flush(struct hci_conn *conn)
+{
+	struct amp_mgr *mgr, *n;
+
+	BT_DBG("conn %p", conn);
+
+	list_for_each_entry_safe(mgr, n, &conn->mgr_list, list)
+		amp_mgr_put(mgr);
+}
+
 int hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -462,6 +475,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_chan_list_flush(conn);
 
+	hci_amp_mgr_list_flush(conn);
+
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
-- 
1.7.9.1

