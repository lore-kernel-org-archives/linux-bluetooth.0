Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 40/49] Bluetooth: Store address type with OOB data
Date: Wed,  3 Dec 2014 17:02:34 +0200
Message-Id: <1417618963-18010-41-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To be able to support OOB data for LE pairing we need to store the
address type of the remote device. This patch extends the relevant
functions and data types with a bdaddr_type variable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  8 +++++---
 net/bluetooth/hci_core.c         | 26 ++++++++++++++++----------
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/mgmt.c             | 11 ++++++-----
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3e89ece75039..1dae7001fc31 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -140,6 +140,7 @@ struct link_key {
 struct oob_data {
 	struct list_head list;
 	bdaddr_t bdaddr;
+	u8 bdaddr_type;
 	u8 hash192[16];
 	u8 rand192[16];
 	u8 hash256[16];
@@ -942,11 +943,12 @@ void hci_smp_irks_clear(struct hci_dev *hdev);
 
 void hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
-					  bdaddr_t *bdaddr);
+					  bdaddr_t *bdaddr, u8 bdaddr_type);
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 *hash192, u8 *rand192,
+			    u8 bdaddr_type, u8 *hash192, u8 *rand192,
 			    u8 *hash256, u8 *rand256);
-int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			       u8 bdaddr_type);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 967fbfe80f1f..c8123f04a33c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2160,7 +2160,7 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 
 	BT_DBG("cache %p, %pMR", cache, &data->bdaddr);
 
-	hci_remove_remote_oob_data(hdev, &data->bdaddr);
+	hci_remove_remote_oob_data(hdev, &data->bdaddr, BDADDR_BREDR);
 
 	if (!data->ssp_mode)
 		flags |= MGMT_DEV_FOUND_LEGACY_PAIRING;
@@ -3479,26 +3479,31 @@ static void hci_cmd_timeout(struct work_struct *work)
 }
 
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
-					  bdaddr_t *bdaddr)
+					  bdaddr_t *bdaddr, u8 bdaddr_type)
 {
 	struct oob_data *data;
 
-	list_for_each_entry(data, &hdev->remote_oob_data, list)
-		if (bacmp(bdaddr, &data->bdaddr) == 0)
-			return data;
+	list_for_each_entry(data, &hdev->remote_oob_data, list) {
+		if (bacmp(bdaddr, &data->bdaddr) != 0)
+			continue;
+		if (data->bdaddr_type != bdaddr_type)
+			continue;
+		return data;
+	}
 
 	return NULL;
 }
 
-int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr)
+int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
+			       u8 bdaddr_type)
 {
 	struct oob_data *data;
 
-	data = hci_find_remote_oob_data(hdev, bdaddr);
+	data = hci_find_remote_oob_data(hdev, bdaddr, bdaddr_type);
 	if (!data)
 		return -ENOENT;
 
-	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
+	BT_DBG("%s removing %pMR (%u)", hdev->name, bdaddr, bdaddr_type);
 
 	list_del(&data->list);
 	kfree(data);
@@ -3517,18 +3522,19 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev)
 }
 
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 *hash192, u8 *rand192,
+			    u8 bdaddr_type, u8 *hash192, u8 *rand192,
 			    u8 *hash256, u8 *rand256)
 {
 	struct oob_data *data;
 
-	data = hci_find_remote_oob_data(hdev, bdaddr);
+	data = hci_find_remote_oob_data(hdev, bdaddr, bdaddr_type);
 	if (!data) {
 		data = kmalloc(sizeof(*data), GFP_KERNEL);
 		if (!data)
 			return -ENOMEM;
 
 		bacpy(&data->bdaddr, bdaddr);
+		data->bdaddr_type = bdaddr_type;
 		list_add(&data->list, &hdev->remote_oob_data);
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c3d6390e3b7b..f4e2a61bb6aa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3773,7 +3773,7 @@ static void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		cp.authentication = conn->auth_type;
 
-		if (hci_find_remote_oob_data(hdev, &conn->dst) &&
+		if (hci_find_remote_oob_data(hdev, &conn->dst, BDADDR_BREDR) &&
 		    (conn->out || test_bit(HCI_CONN_REMOTE_OOB, &conn->flags)))
 			cp.oob_data = 0x01;
 		else
@@ -4028,7 +4028,7 @@ static void hci_remote_oob_data_request_evt(struct hci_dev *hdev,
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		goto unlock;
 
-	data = hci_find_remote_oob_data(hdev, &ev->bdaddr);
+	data = hci_find_remote_oob_data(hdev, &ev->bdaddr, BDADDR_BREDR);
 	if (data) {
 		if (bredr_sc_enabled(hdev)) {
 			struct hci_cp_remote_oob_ext_data_reply cp;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0d92ba99ca93..57de9f7222aa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3599,8 +3599,8 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
-					      cp->hash, cp->rand,
-					      NULL, NULL);
+					      cp->addr.type, cp->hash,
+					      cp->rand, NULL, NULL);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
@@ -3621,8 +3621,9 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
-					      cp->hash192, cp->rand192,
-					      cp->hash256, cp->rand256);
+					      cp->addr.type, cp->hash192,
+					      cp->rand192, cp->hash256,
+					      cp->rand256);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
@@ -3663,7 +3664,7 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
-	err = hci_remove_remote_oob_data(hdev, &cp->addr.bdaddr);
+	err = hci_remove_remote_oob_data(hdev, &cp->addr.bdaddr, cp->addr.type);
 	if (err < 0)
 		status = MGMT_STATUS_INVALID_PARAMS;
 	else
-- 
2.1.0

