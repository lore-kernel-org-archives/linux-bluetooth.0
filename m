Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 2/2] Bluetooth: Append local name and CoD to Extended Controller Info
Date: Thu,  1 Sep 2016 16:46:24 +0200
Message-Id: <1472741184-29311-2-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1472741184-29311-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1472741184-29311-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds device class, complete local name and short local name
to EIR data in Extended Controller Info as specified in docs.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/mgmt.c | 63 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 69001f4..74179b9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -866,26 +866,58 @@ static int read_controller_info(struct sock *sk, struct hci_dev *hdev,
 				 sizeof(rp));
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
 static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 				    void *data, u16 data_len)
 {
-	struct mgmt_rp_read_ext_info rp;
+	struct mgmt_rp_read_ext_info *rp;
+	char buff[512];
+	u16 eir_len = 0;
+	u8 name_len;
 
 	BT_DBG("sock %p %s", sk, hdev->name);
 
 	hci_dev_lock(hdev);
 
-	memset(&rp, 0, sizeof(rp));
+	if (hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+		eir_len = eir_append_data(buff, eir_len,
+					  EIR_CLASS_OF_DEV,
+					  hdev->dev_class, 3);
 
-	bacpy(&rp.bdaddr, &hdev->bdaddr);
+	name_len = strlen(hdev->dev_name);
+	eir_len = eir_append_data(buff, eir_len, EIR_NAME_COMPLETE,
+				  hdev->dev_name, name_len);
 
-	rp.version = hdev->hci_ver;
-	rp.manufacturer = cpu_to_le16(hdev->manufacturer);
+	name_len = strlen(hdev->short_name);
+	eir_len = eir_append_data(buff, eir_len, EIR_NAME_SHORT,
+				  hdev->short_name, name_len);
 
-	rp.supported_settings = cpu_to_le32(get_supported_settings(hdev));
-	rp.current_settings = cpu_to_le32(get_current_settings(hdev));
+	rp = kmalloc(sizeof(*rp) + eir_len, GFP_KERNEL);
+	if (!rp)
+		return -ENOMEM;
+
+	memset(rp, 0, sizeof(*rp) + eir_len);
+
+	rp->eir_len = cpu_to_le16(eir_len);
+	memcpy(rp->eir, buff, eir_len);
 
-	rp.eir_len = cpu_to_le16(0);
+	bacpy(&rp->bdaddr, &hdev->bdaddr);
+
+	rp->version = hdev->hci_ver;
+	rp->manufacturer = cpu_to_le16(hdev->manufacturer);
+
+	rp->supported_settings = cpu_to_le32(get_supported_settings(hdev));
+	rp->current_settings = cpu_to_le32(get_current_settings(hdev));
 
 	hci_dev_unlock(hdev);
 
@@ -898,8 +930,8 @@ static int read_ext_controller_info(struct sock *sk, struct hci_dev *hdev,
 	hci_sock_clear_flag(sk, HCI_MGMT_DEV_CLASS_EVENTS);
 	hci_sock_clear_flag(sk, HCI_MGMT_LOCAL_NAME_EVENTS);
 
-	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_EXT_INFO, 0, &rp,
-				 sizeof(rp));
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_EXT_INFO, 0, rp,
+				 sizeof(*rp) + eir_len);
 }
 
 static int ext_info_changed(struct hci_dev *hdev, struct sock *skip)
@@ -5552,17 +5584,6 @@ unlock:
 	return err;
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
 static void read_local_oob_ext_data_complete(struct hci_dev *hdev, u8 status,
 					     u16 opcode, struct sk_buff *skb)
 {
-- 
2.7.4

