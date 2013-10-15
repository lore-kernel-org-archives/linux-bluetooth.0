Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move eir_get_length() function into hci_event.c
Date: Tue, 15 Oct 2013 10:31:12 -0700
Message-Id: <1381858272-50639-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The eir_get_length() function is only used from hci_event.c and so
instead of having a public function move it to the location where
it is used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 17 -----------------
 net/bluetooth/hci_event.c        | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 42591a4..b076cd9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1009,23 +1009,6 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 	return false;
 }
 
-static inline size_t eir_get_length(u8 *eir, size_t eir_len)
-{
-	size_t parsed = 0;
-
-	while (parsed < eir_len) {
-		u8 field_len = eir[0];
-
-		if (field_len == 0)
-			return parsed;
-
-		parsed += field_len + 1;
-		eir += field_len + 1;
-	}
-
-	return eir_len;
-}
-
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 071c0df..7450626 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2928,6 +2928,23 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
+static inline size_t eir_get_length(u8 *eir, size_t eir_len)
+{
+	size_t parsed = 0;
+
+	while (parsed < eir_len) {
+		u8 field_len = eir[0];
+
+		if (field_len == 0)
+			return parsed;
+
+		parsed += field_len + 1;
+		eir += field_len + 1;
+	}
+
+	return eir_len;
+}
+
 static void hci_extended_inquiry_result_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-- 
1.8.3.1

