Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 03/18] Bluetooth: A2MP: AMP Manager basic functions
Date: Thu, 24 May 2012 14:38:13 +0300
Message-Id: <1337859508-32274-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define AMP Manager and some basic functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |   30 +++++++++++++++++++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/a2mp.c             |   54 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_conn.c         |    4 +++
 4 files changed, 89 insertions(+)
 create mode 100644 include/net/bluetooth/a2mp.h

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
new file mode 100644
index 0000000..ff47540
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
+	struct l2cap_conn	*l2cap_conn;
+	struct l2cap_chan	*a2mp_chan;
+	struct kref		kref;
+	__u8			ident;
+	__u8			handle;
+	unsigned long		flags;
+};
+
+void amp_mgr_get(struct amp_mgr *mgr);
+int amp_mgr_put(struct amp_mgr *mgr);
+
+#endif /* __A2MP_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d584a47..6e64b76 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -332,6 +332,7 @@ struct hci_conn {
 	void		*l2cap_data;
 	void		*sco_data;
 	void		*smp_conn;
+	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d1574f5..ea900fb 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -15,6 +15,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
 
 static struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
@@ -65,3 +66,56 @@ static struct l2cap_chan *a2mp_chan_open(struct l2cap_conn *conn)
 
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
+	struct amp_mgr *mgr = container_of(kref, struct amp_mgr, kref);
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
+	struct l2cap_chan *chan;
+
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		return NULL;
+
+	BT_DBG("conn %p mgr %p", conn, mgr);
+
+	mgr->l2cap_conn = conn;
+
+	chan = a2mp_chan_open(conn);
+	if (!chan) {
+		kfree(mgr);
+		return NULL;
+	}
+
+	mgr->a2mp_chan = chan;
+	chan->data = mgr;
+
+	conn->hcon->amp_mgr = mgr;
+
+	kref_init(&mgr->kref);
+
+	return mgr;
+}
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8163ee1..111e549 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -28,6 +28,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/a2mp.h>
 
 static void hci_le_connect(struct hci_conn *conn)
 {
@@ -411,6 +412,9 @@ int hci_conn_del(struct hci_conn *conn)
 
 	hci_chan_list_flush(conn);
 
+	if (conn->amp_mgr)
+		amp_mgr_put(conn->amp_mgr);
+
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
-- 
1.7.9.5

