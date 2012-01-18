Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/15] Bluetooth: Move eir_has_data_field to hci_core.h
Date: Wed, 18 Jan 2012 20:51:48 +0200
Message-Id: <1326912717-6347-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This makes the function accessible from all places it's needed (e.g.
mgmt.c and hci_event.c).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   25 +++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 33dff8e..393bb73 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -868,6 +868,31 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 	read_unlock(&hci_cb_list_lock);
 }
 
+static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
+{
+	u8 field_len;
+	size_t parsed;
+
+	for (parsed = 0; parsed < data_len - 1; parsed += field_len) {
+		field_len = data[0];
+
+		if (field_len == 0)
+			break;
+
+		parsed += field_len + 1;
+
+		if (parsed > data_len)
+			break;
+
+		if (data[1] == type)
+			return true;
+
+		data += field_len + 1;
+	}
+
+	return false;
+}
+
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea2ec61..a50e857 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2842,31 +2842,6 @@ static inline void hci_sniff_subrate_evt(struct hci_dev *hdev, struct sk_buff *s
 	BT_DBG("%s status %d", hdev->name, ev->status);
 }
 
-static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
-{
-	u8 field_len;
-	size_t parsed;
-
-	for (parsed = 0; parsed < data_len - 1; parsed += field_len) {
-		field_len = data[0];
-
-		if (field_len == 0)
-			break;
-
-		parsed += field_len + 1;
-
-		if (parsed > data_len)
-			break;
-
-		if (data[1] == type)
-			return true;
-
-		data += field_len + 1;
-	}
-
-	return false;
-}
-
 static inline void hci_extended_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct inquiry_data data;
-- 
1.7.8.3

