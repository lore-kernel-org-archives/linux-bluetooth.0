Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/13] Bluetooth: Remove unnecessary hci_explicit_connect_lookup function
Date: Wed, 21 Oct 2015 18:03:10 +0300
Message-Id: <1445439791-2151-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
References: <1445439791-2151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's only one user of this helper which can be replaces with a call
to hci_pend_le_action_lookup() and a check for params->explicit_connect.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 ---
 net/bluetooth/hci_conn.c         |  5 +++--
 net/bluetooth/hci_core.c         | 17 -----------------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 32bb281e6aa6..1878d0a96333 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1042,9 +1042,6 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
-struct hci_conn_params *hci_explicit_connect_lookup(struct hci_dev *hdev,
-						    bdaddr_t *addr,
-						    u8 addr_type);
 
 void hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 77b2bf9e808e..85b82f7adbd2 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -78,8 +78,9 @@ static void hci_connect_le_scan_cleanup(struct hci_conn *conn)
 		bdaddr_type = irk->addr_type;
 	}
 
-	params = hci_explicit_connect_lookup(hdev, bdaddr, bdaddr_type);
-	if (!params)
+	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, bdaddr,
+					   bdaddr_type);
+	if (!params || !params->explicit_connect)
 		return;
 
 	/* The connection attempt was doing scan for new RPA, and is
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 964fba4c96bf..086ed9389da1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2941,23 +2941,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 }
 
 /* This function requires the caller holds hdev->lock */
-struct hci_conn_params *hci_explicit_connect_lookup(struct hci_dev *hdev,
-						    bdaddr_t *addr,
-						    u8 addr_type)
-{
-	struct hci_conn_params *param;
-
-	list_for_each_entry(param, &hdev->pend_le_conns, action) {
-		if (bacmp(&param->addr, addr) == 0 &&
-		    param->addr_type == addr_type &&
-		    param->explicit_connect)
-			return param;
-	}
-
-	return NULL;
-}
-
-/* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
 {
-- 
2.5.0

