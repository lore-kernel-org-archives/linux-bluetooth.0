Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 10/34] Bluetooth: A2MP: AMP Manager basic functions
Date: Thu, 19 Jan 2012 11:19:59 +0200
Message-Id: <1326964823-26747-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define AMP Manager and some basic functions.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |   30 +++++++++++++++++++++++++
 net/bluetooth/a2mp.c         |   49 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)
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
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 52bb7d8..247a543 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -14,6 +14,7 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
 
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
@@ -61,3 +62,51 @@ static struct l2cap_chan *open_a2mp_chan(struct l2cap_conn *conn)
 
 	return chan;
 }
+
+/* AMP Manager functions */
+void amp_mgr_get(struct amp_mgr *mgr)
+{
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
+	return kref_put(&mgr->kref, &amp_mgr_destroy);
+}
+
+struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
+{
+	struct amp_mgr *mgr;
+
+	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
+	if (!mgr)
+		goto finished;
+
+	BT_DBG("conn %p mgr %p", conn, mgr);
+
+	mgr->l2cap_conn = conn;
+
+	mgr->a2mp_chan = open_a2mp_chan(conn);
+	if (!mgr->a2mp_chan) {
+		kfree(mgr);
+		mgr = NULL;
+		goto finished;
+	}
+
+	mgr->a2mp_chan->data = mgr;
+
+	kref_init(&mgr->kref);
+
+finished:
+	return mgr;
+}
-- 
1.7.4.1

