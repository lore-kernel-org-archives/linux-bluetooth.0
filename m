Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Move eir_append_data() function into mgmt.c
Date: Tue, 15 Oct 2013 10:26:39 -0700
Message-Id: <1381857999-47886-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The eir_append_data() function is only used from mgmt.c and so
instead of having a public function move it to the location where
it is used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 11 -----------
 net/bluetooth/mgmt.c             | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cf6be04..42591a4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1026,17 +1026,6 @@ static inline size_t eir_get_length(u8 *eir, size_t eir_len)
 	return eir_len;
 }
 
-static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
-				  u8 data_len)
-{
-	eir[eir_len++] = sizeof(type) + data_len;
-	eir[eir_len++] = type;
-	memcpy(&eir[eir_len], data, data_len);
-	eir_len += data_len;
-
-	return eir_len;
-}
-
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6fb302e..292e81f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4381,6 +4381,17 @@ int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 			  NULL);
 }
 
+static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
+				  u8 data_len)
+{
+	eir[eir_len++] = sizeof(type) + data_len;
+	eir[eir_len++] = type;
+	memcpy(&eir[eir_len], data, data_len);
+	eir_len += data_len;
+
+	return eir_len;
+}
+
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			   u8 *dev_class)
-- 
1.8.3.1

