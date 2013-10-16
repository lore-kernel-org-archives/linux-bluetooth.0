Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 04/15] Bluetooth: Make find_conn_param() helper non-local
Date: Wed, 16 Oct 2013 20:17:54 -0300
Message-Id: <1381965485-9159-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes the find_conn_param() helper non-local by adding the
hci_ prefix and declaring it in hci_core.h. This helper will be used
in hci_conn.c to get the connection parameters when establishing
connections.

Since hci_find_conn_param() returns a reference to the hci_conn_param
object, it was added a refcount to hci_conn_param to control its
lifetime. This way, we avoid bugs such as one thread deletes hci_conn_
param (e.g. thread running MGMT_OP_REMOVE_CONN_PARAM command) while
another thread holds a reference to that object (e.g thread carrying
out the connection establishment).	.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  5 +++++
 net/bluetooth/hci_core.c         | 46 ++++++++++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 98be273..1e67da5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -371,6 +371,8 @@ struct hci_chan {
 };
 
 struct hci_conn_param {
+	struct kref refcount;
+
 	struct list_head list;
 
 	bdaddr_t addr;
@@ -751,6 +753,9 @@ int hci_blacklist_clear(struct hci_dev *hdev);
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
+struct hci_conn_param *hci_find_conn_param(struct hci_dev *hdev,
+					   bdaddr_t *addr, u8 addr_type);
+void hci_conn_param_put(struct hci_conn_param *param);
 int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		       u8 auto_connect, u16 min_conn_interval,
 		       u16 max_conn_interval);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a4242ac..c9c3390 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2151,8 +2151,34 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
-struct hci_conn_param *find_conn_param(struct hci_dev *hdev,
-				       bdaddr_t *addr, u8 addr_type)
+static void hci_conn_param_get(struct hci_conn_param *param)
+{
+	kref_get(&param->refcount);
+}
+
+static void release_hci_conn_param(struct kref *kref)
+{
+	struct hci_conn_param *param = container_of(kref,
+						    struct hci_conn_param,
+						    refcount);
+
+	kfree(param);
+}
+
+void hci_conn_param_put(struct hci_conn_param *param)
+{
+	kref_put(&param->refcount, release_hci_conn_param);
+}
+
+/*
+ * Lookup hci_conn_param in hdev->conn_param list.
+ *
+ * Return a reference to hci_conn_param object with refcount incremented.
+ * The caller should drop its reference by using hci_conn_param_put(). If
+ * hci_conn_param is not found, NULL is returned.
+ */
+struct hci_conn_param *hci_find_conn_param(struct hci_dev *hdev,
+					   bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_param *param;
 
@@ -2164,6 +2190,8 @@ struct hci_conn_param *find_conn_param(struct hci_dev *hdev,
 		if (param->addr_type != addr_type)
 			continue;
 
+		hci_conn_param_get(param);
+
 		rcu_read_unlock();
 		return param;
 	}
@@ -2178,14 +2206,18 @@ int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 {
 	struct hci_conn_param *param;
 
-	param = find_conn_param(hdev, addr, addr_type);
-	if (param)
+	param = hci_find_conn_param(hdev, addr, addr_type);
+	if (param) {
+		hci_conn_param_put(param);
 		return -EEXIST;
+	}
 
 	param = kmalloc(sizeof(*param), GFP_KERNEL);
 	if (!param)
 		return -ENOMEM;
 
+	kref_init(&param->refcount);
+
 	bacpy(&param->addr, addr);
 	param->addr_type = addr_type;
 	param->auto_connect = auto_connect;
@@ -2208,20 +2240,22 @@ static void __remove_conn_param(struct hci_conn_param *param)
 	list_del_rcu(&param->list);
 	synchronize_rcu();
 
-	kfree(param);
+	hci_conn_param_put(param);
 }
 
 void hci_remove_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_param *param;
 
-	param = find_conn_param(hdev, addr, addr_type);
+	param = hci_find_conn_param(hdev, addr, addr_type);
 	if (!param)
 		return;
 
 	hci_dev_lock(hdev);
 	__remove_conn_param(param);
 	hci_dev_unlock(hdev);
+
+	hci_conn_param_put(param);
 }
 
 /*
-- 
1.8.4

