Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/12] Bluetooth: Remove unused hci_pend_le_conn_del() function
Date: Fri,  4 Jul 2014 12:37:22 +0300
Message-Id: <1404466647-16352-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
References: <1404466647-16352-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that there are no-longer any users of the hci_pend_le_conn_del()
function we can simply go ahead and remove it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9670f4c66ee3..758146c513d3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -871,7 +871,6 @@ void hci_conn_params_clear_enabled(struct hci_dev *hdev);
 struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 						bdaddr_t *addr, u8 addr_type);
 void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params);
-void hci_pend_le_conn_del(struct hci_dev *hdev, struct hci_conn_params *params);
 void hci_pend_le_conns_clear(struct hci_dev *hdev);
 
 void hci_update_background_scan(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3b0da6eeb449..6eadde820333 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3461,16 +3461,6 @@ void hci_pend_le_conn_add(struct hci_dev *hdev, struct hci_conn_params *params)
 }
 
 /* This function requires the caller holds hdev->lock */
-void hci_pend_le_conn_del(struct hci_dev *hdev, struct hci_conn_params *params)
-{
-	list_del_init(&params->action);
-
-	BT_DBG("addr %pMR (type %u)", &params->addr, params->addr_type);
-
-	hci_update_background_scan(hdev);
-}
-
-/* This function requires the caller holds hdev->lock */
 void hci_pend_le_conns_clear(struct hci_dev *hdev)
 {
 	while (!list_empty(&hdev->pend_le_conns))
-- 
1.9.3

