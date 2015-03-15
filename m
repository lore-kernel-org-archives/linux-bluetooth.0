Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Move eir_append_data function to a different location
Date: Sat, 14 Mar 2015 22:43:17 -0700
Message-Id: <1426398199-11977-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The eir_append_data helper function is needed for generating the
extended local OOB data fields. So move it up into the right location.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ce3b8410dcb4..3e430c8b8030 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6255,6 +6255,17 @@ unlock:
 	return err;
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
 static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 			     void *data, u16 data_len)
 {
@@ -6932,17 +6943,6 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_event(MGMT_EV_NEW_CONN_PARAM, hdev, &ev, sizeof(ev), NULL);
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
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 			   u32 flags, u8 *name, u8 name_len)
 {
-- 
2.1.0

