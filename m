Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 10/19] Bluetooth: AMP: Physical link struct definitions
Date: Fri, 29 Jun 2012 17:46:43 +0300
Message-Id: <1340981212-21709-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Define physical link structure. Physical links are managed by AMP
manager inside mgr structure.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    3 +
 include/net/bluetooth/pal.h  |   44 ++++++++++++++
 net/bluetooth/Makefile       |    2 +-
 net/bluetooth/a2mp.c         |    6 ++
 net/bluetooth/pal.c          |  135 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 include/net/bluetooth/pal.h
 create mode 100644 net/bluetooth/pal.c

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index ec77ddc..012f573 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -26,6 +26,9 @@ struct amp_mgr {
 	__u8			ident;
 	__u8			handle;
 	unsigned long		flags;
+
+	struct list_head	phy_links;
+	struct mutex		phy_links_lock;
 };
 
 struct a2mp_cmd {
diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
new file mode 100644
index 0000000..28bfc7e
--- /dev/null
+++ b/include/net/bluetooth/pal.h
@@ -0,0 +1,44 @@
+/*
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
+#ifndef __PAL_H
+#define __PAL_H
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
+
+struct phy_link {
+	struct list_head	list;
+	__u8			local_id;
+	__u8			remote_id;
+	__u8			state;
+	__u8			amp_role;
+	__u8			handle;
+	struct amp_mgr		*mgr;
+	struct amp_assoc	rem_assoc;
+	struct kref		kref;
+};
+
+struct phy_link *hci_phylink_add(struct amp_mgr *mgr, u8 local_id,
+				 u8 remote_id, u8 *rem_assoc, u16 assoc_size);
+struct phy_link *hci_phylink_lookup(struct amp_mgr *mgr, u8 local_id,
+				    u8 remote_id);
+int phylink_put(struct phy_link *plink);
+void phylink_get(struct phy_link *plink);
+void hci_phylink_list_flush(struct amp_mgr *mgr);
+int phylink_security(struct hci_conn *conn, u8 *data, u8 *len, u8 *type);
+
+#endif /* __PAL_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index dea6a28..3f76fc2 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o
+	a2mp.o amp.o pal.o
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 517b631..efc4af8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -17,6 +17,7 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 #include <net/bluetooth/amp.h>
+#include <net/bluetooth/pal.h>
 
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
@@ -594,6 +595,7 @@ static void amp_mgr_destroy(struct kref *kref)
 
 	BT_DBG("mgr %p", mgr);
 
+	hci_phylink_list_flush(mgr);
 	kfree(mgr);
 }
 
@@ -628,6 +630,10 @@ static struct amp_mgr *amp_mgr_create(struct l2cap_conn *conn)
 
 	conn->hcon->amp_mgr = mgr;
 
+	/* Phylink initialization */
+	INIT_LIST_HEAD(&mgr->phy_links);
+	mutex_init(&mgr->phy_links_lock);
+
 	kref_init(&mgr->kref);
 
 	return mgr;
diff --git a/net/bluetooth/pal.c b/net/bluetooth/pal.c
new file mode 100644
index 0000000..5dcc448
--- /dev/null
+++ b/net/bluetooth/pal.c
@@ -0,0 +1,135 @@
+/*
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
+#include <net/bluetooth/pal.h>
+
+enum pal_states {
+	DISCONNECTED,
+	STARTING,
+	CONNECTING,
+	AUTHENTICATING,
+	CONNECTED,
+	DISCONNECTING
+};
+
+/* Physical Link interface */
+void phylink_get(struct phy_link *plink)
+{
+	BT_DBG("plink %p refcnt %d -> %d", plink,
+	       atomic_read(&plink->kref.refcount),
+	       atomic_read(&plink->kref.refcount) + 1);
+
+	kref_get(&plink->kref);
+}
+
+static void phylink_destroy(struct kref *kref)
+{
+	struct phy_link *plink = container_of(kref, struct phy_link, kref);
+
+	BT_DBG("plink %p", plink);
+
+	kfree(plink);
+}
+
+int phylink_put(struct phy_link *plink)
+{
+	BT_DBG("plink %p refcnt %d -> %d", plink,
+	       atomic_read(&plink->kref.refcount),
+	       atomic_read(&plink->kref.refcount) - 1);
+
+	return kref_put(&plink->kref, &phylink_destroy);
+}
+
+struct phy_link *hci_phylink_add(struct amp_mgr *mgr, u8 local_id,
+				 u8 remote_id, u8 *rem_assoc, u16 assoc_size)
+{
+	struct phy_link *plink;
+
+	plink = kzalloc(sizeof(*plink), GFP_KERNEL);
+	if (!plink)
+		return NULL;
+
+	plink->local_id = local_id;
+	plink->remote_id = remote_id;
+	plink->mgr = mgr;
+
+	plink->rem_assoc.len = min_t(u16, assoc_size, HCI_MAX_AMP_ASSOC_SIZE);
+	memcpy(plink->rem_assoc.data, rem_assoc, plink->rem_assoc.len);
+
+	plink->state = STARTING;
+
+	mutex_lock(&mgr->phy_links_lock);
+	list_add(&plink->list, &mgr->phy_links);
+	mutex_unlock(&mgr->phy_links_lock);
+
+	kref_init(&plink->kref);
+
+	BT_DBG("Physical link %p created", plink);
+
+	return plink;
+}
+
+void hci_phylink_del(struct amp_mgr *mgr, struct phy_link *plink)
+{
+	BT_DBG("phylink %p", plink);
+
+	mutex_lock(&mgr->phy_links_lock);
+	list_del(&plink->list);
+	mutex_unlock(&mgr->phy_links_lock);
+
+	phylink_put(plink);
+}
+
+void hci_phylink_list_flush(struct amp_mgr *mgr)
+{
+	struct phy_link *plink, *n;
+
+	BT_DBG("mgr %p", mgr);
+
+	mutex_lock(&mgr->phy_links_lock);
+	list_for_each_entry_safe(plink, n, &mgr->phy_links, list) {
+		list_del(&plink->list);
+		phylink_put(plink);
+	}
+	mutex_unlock(&mgr->phy_links_lock);
+}
+
+struct phy_link *hci_phylink_lookup(struct amp_mgr *mgr, u8 local_id,
+				    u8 remote_id)
+{
+	struct phy_link *plink, *found = NULL;
+
+	mutex_lock(&mgr->phy_links_lock);
+	list_for_each_entry(plink, &mgr->phy_links, list) {
+		/* Closest match */
+		if (!remote_id && plink->local_id == local_id) {
+			found = plink;
+			break;
+		}
+		/* Exact match */
+		if (plink->local_id == local_id &&
+		    plink->remote_id == remote_id) {
+			found = plink;
+			break;
+		}
+	}
+	mutex_unlock(&mgr->phy_links_lock);
+
+	BT_DBG("local_id %d remote_id %d plink %p", local_id, remote_id,
+	       plink);
+
+	if (found)
+		phylink_get(plink);
+
+	return found;
+}
-- 
1.7.9.5

