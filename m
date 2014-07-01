Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Change hci_conn_params_add to return the parameter struct
Date: Tue,  1 Jul 2014 12:11:04 +0200
Message-Id: <1404209466-64712-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding new connection parameters, it is useful to return either
the existing struct or the newly created one.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 11 ++++++-----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ec830871b9b8..5a83621672bf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -852,7 +852,8 @@ int hci_white_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
-int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
+					    bdaddr_t *addr, u8 addr_type);
 int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			u8 auto_connect, u16 conn_min_interval,
 			u16 conn_max_interval);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2312e77582b0..883ddd52344d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3472,21 +3472,22 @@ void hci_pend_le_conns_clear(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
+					    bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *params;
 
 	if (!is_identity_address(addr, addr_type))
-		return -EINVAL;
+		return NULL;
 
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
-		return 0;
+		return params;
 
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params) {
 		BT_ERR("Out of memory");
-		return -ENOMEM;
+		return NULL;
 	}
 
 	bacpy(&params->addr, addr);
@@ -3502,7 +3503,7 @@ int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 
 	BT_DBG("addr %pMR (type %u)", addr, addr_type);
 
-	return 0;
+	return params;
 }
 
 /* This function requires the caller holds hdev->lock */
-- 
1.9.3

