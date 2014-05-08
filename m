Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/8] Bluetooth: Move eir_append_data up
Date: Thu, 8 May 2014 15:32:10 +0200
Message-ID: <1399555935-702-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves eir_append_data up in file, close to other eir-related
functions, so we can use it later in mgmt handlers.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 net/bluetooth/mgmt.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54abbce..840b273 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -701,6 +701,17 @@ static void update_adv_data(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
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
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
@@ -5105,17 +5116,6 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 	mgmt_event(MGMT_EV_NEW_CSRK, hdev, &ev, sizeof(ev), NULL);
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
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			   u8 *dev_class)
-- 
1.9.2

