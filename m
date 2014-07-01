Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove connection interval parameters from hci_conn_params_set
Date: Tue,  1 Jul 2014 12:11:06 +0200
Message-Id: <1404209466-64712-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The connection interval parameter of hci_conn_params_set are always used
with the controller defaults. So just let hci_conn_params_add set the
controller default and not bother resetting them to controller defaults
every time the hci_conn_params_set is called.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 +--
 net/bluetooth/hci_core.c         | 10 +++-------
 net/bluetooth/mgmt.c             |  5 ++---
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a83621672bf..61d4d265f42d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -855,8 +855,7 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
 int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			u8 auto_connect, u16 conn_min_interval,
-			u16 conn_max_interval);
+			u8 auto_connect);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9ae945d8ad7e..237963d5473c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3508,8 +3508,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 
 /* This function requires the caller holds hdev->lock */
 int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
-			u8 auto_connect, u16 conn_min_interval,
-			u16 conn_max_interval)
+			u8 auto_connect)
 {
 	struct hci_conn_params *params;
 
@@ -3517,8 +3516,6 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	if (!params)
 		return -EIO;
 
-	params->conn_min_interval = conn_min_interval;
-	params->conn_max_interval = conn_max_interval;
 	params->auto_connect = auto_connect;
 
 	switch (auto_connect) {
@@ -3532,9 +3529,8 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		break;
 	}
 
-	BT_DBG("addr %pMR (type %u) auto_connect %u conn_min_interval 0x%.4x "
-	       "conn_max_interval 0x%.4x", addr, addr_type, auto_connect,
-	       conn_min_interval, conn_max_interval);
+	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
+	       auto_connect);
 
 	return 0;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6baba309f9e2..c6e9b551242b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5028,9 +5028,8 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type, auto_conn,
-				hdev->le_conn_min_interval,
-				hdev->le_conn_max_interval) < 0) {
+	if (hci_conn_params_set(hdev, &cp->addr.bdaddr, addr_type,
+				auto_conn) < 0) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				   MGMT_STATUS_FAILED,
 				   &cp->addr, sizeof(cp->addr));
-- 
1.9.3

