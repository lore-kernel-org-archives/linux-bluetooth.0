Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 39/49] Bluetooth: Unify remote OOB data functions
Date: Wed,  3 Dec 2014 17:02:33 +0200
Message-Id: <1417618963-18010-40-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to duplicate code for the 192 vs 192+256 variants of the
OOB data functions. This is also helpful to pave the way to support LE
SC OOB data where only 256 bit data is provided.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  6 ++----
 net/bluetooth/hci_core.c         | 46 +++++++++++++---------------------------
 net/bluetooth/mgmt.c             |  9 ++++----
 3 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f39e65096b1f..3e89ece75039 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -944,10 +944,8 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
 					  bdaddr_t *bdaddr);
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 *hash, u8 *rand);
-int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				u8 *hash192, u8 *rand192,
-				u8 *hash256, u8 *rand256);
+			    u8 *hash192, u8 *rand192,
+			    u8 *hash256, u8 *rand256);
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 581e13e9dc32..967fbfe80f1f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3517,7 +3517,8 @@ void hci_remote_oob_data_clear(struct hci_dev *hdev)
 }
 
 int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-			    u8 *hash, u8 *rand)
+			    u8 *hash192, u8 *rand192,
+			    u8 *hash256, u8 *rand256)
 {
 	struct oob_data *data;
 
@@ -3531,38 +3532,21 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		list_add(&data->list, &hdev->remote_oob_data);
 	}
 
-	memcpy(data->hash192, hash, sizeof(data->hash192));
-	memcpy(data->rand192, rand, sizeof(data->rand192));
-
-	memset(data->hash256, 0, sizeof(data->hash256));
-	memset(data->rand256, 0, sizeof(data->rand256));
-
-	BT_DBG("%s for %pMR", hdev->name, bdaddr);
-
-	return 0;
-}
-
-int hci_add_remote_oob_ext_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
-				u8 *hash192, u8 *rand192,
-				u8 *hash256, u8 *rand256)
-{
-	struct oob_data *data;
-
-	data = hci_find_remote_oob_data(hdev, bdaddr);
-	if (!data) {
-		data = kmalloc(sizeof(*data), GFP_KERNEL);
-		if (!data)
-			return -ENOMEM;
-
-		bacpy(&data->bdaddr, bdaddr);
-		list_add(&data->list, &hdev->remote_oob_data);
+	if (hash192 && rand192) {
+		memcpy(data->hash192, hash192, sizeof(data->hash192));
+		memcpy(data->rand192, rand192, sizeof(data->rand192));
+	} else {
+		memset(data->hash192, 0, sizeof(data->hash192));
+		memset(data->rand192, 0, sizeof(data->rand192));
 	}
 
-	memcpy(data->hash192, hash192, sizeof(data->hash192));
-	memcpy(data->rand192, rand192, sizeof(data->rand192));
-
-	memcpy(data->hash256, hash256, sizeof(data->hash256));
-	memcpy(data->rand256, rand256, sizeof(data->rand256));
+	if (hash256 && rand256) {
+		memcpy(data->hash256, hash256, sizeof(data->hash256));
+		memcpy(data->rand256, rand256, sizeof(data->rand256));
+	} else {
+		memset(data->hash256, 0, sizeof(data->hash256));
+		memset(data->rand256, 0, sizeof(data->rand256));
+	}
 
 	BT_DBG("%s for %pMR", hdev->name, bdaddr);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6e8165364b7f..0d92ba99ca93 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3599,7 +3599,8 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
-					      cp->hash, cp->rand);
+					      cp->hash, cp->rand,
+					      NULL, NULL);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
@@ -3619,9 +3620,9 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		err = hci_add_remote_oob_ext_data(hdev, &cp->addr.bdaddr,
-						  cp->hash192, cp->rand192,
-						  cp->hash256, cp->rand256);
+		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
+					      cp->hash192, cp->rand192,
+					      cp->hash256, cp->rand256);
 		if (err < 0)
 			status = MGMT_STATUS_FAILED;
 		else
-- 
2.1.0

