Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Refactor connection parameter freeing into its own function
Date: Fri, 15 Aug 2014 20:49:19 +0300
Message-Id: <1408124959-27128-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1408124959-27128-1-git-send-email-johan.hedberg@gmail.com>
References: <1408124959-27128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The necessary steps for freeing connection paramaters have grown quite a
bit so we can simplify the code by factoring it out into its own
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cd775d1f7d47..e013a7beba02 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3720,15 +3720,8 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	return 0;
 }
 
-/* This function requires the caller holds hdev->lock */
-void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+static void hci_conn_params_free(struct hci_conn_params *params)
 {
-	struct hci_conn_params *params;
-
-	params = hci_conn_params_lookup(hdev, addr, addr_type);
-	if (!params)
-		return;
-
 	if (params->conn) {
 		hci_conn_drop(params->conn);
 		hci_conn_put(params->conn);
@@ -3737,6 +3730,18 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	list_del(&params->action);
 	list_del(&params->list);
 	kfree(params);
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_params *params;
+
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (!params)
+		return;
+
+	hci_conn_params_free(params);
 
 	hci_update_background_scan(hdev);
 
@@ -3763,15 +3768,8 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 {
 	struct hci_conn_params *params, *tmp;
 
-	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
-		if (params->conn) {
-			hci_conn_drop(params->conn);
-			hci_conn_put(params->conn);
-		}
-		list_del(&params->action);
-		list_del(&params->list);
-		kfree(params);
-	}
+	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list)
+		hci_conn_params_free(params);
 
 	hci_update_background_scan(hdev);
 
-- 
1.9.3

