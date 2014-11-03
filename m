Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add hci_conn_lookup_type() helper function
Date: Mon,  3 Nov 2014 05:16:08 +0100
Message-Id: <1414988168-51327-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some drivers require knowledge of what connection handle is assigned
to what connection link type (ACL or SCO/eSCO). Instead of having each
driver implement connection tracking, provide a simple helper function
for lookup of the link type.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 2e08f5a89463..d5f85d7746bc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -274,6 +274,7 @@ enum {
 /* Low Energy links do not have defined link type. Use invented one */
 #define LE_LINK		0x80
 #define AMP_LINK	0x81
+#define INVALID_LINK	0xff
 
 /* LMP features */
 #define LMP_3SLOT	0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 27ddb905b351..4e39a5adfcab 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -646,6 +646,26 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 	return c->acl_num + c->amp_num + c->sco_num + c->le_num;
 }
 
+static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *c;
+	__u8 type = INVALID_LINK;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->handle == handle) {
+			type = c->type;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return type;
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 								__u16 handle)
 {
-- 
1.9.3

