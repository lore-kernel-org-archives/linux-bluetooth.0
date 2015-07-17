Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 2/4] Bluetooth: Move irk checking logic in preparation to new connect method
Date: Fri, 17 Jul 2015 22:51:07 +0200
Message-Id: <1437166269-14588-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1437166269-14588-1-git-send-email-jpawlowski@google.com>
References: <1437166269-14588-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_core.c | 11 -----------
 net/bluetooth/mgmt.c     | 17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2f8fb33..bc43b64 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2822,10 +2822,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 {
 	struct hci_conn_params *params;
 
-	/* The conn params list only contains identity addresses */
-	if (!hci_is_identity_address(addr, addr_type))
-		return NULL;
-
 	list_for_each_entry(params, &hdev->le_conn_params, list) {
 		if (bacmp(&params->addr, addr) == 0 &&
 		    params->addr_type == addr_type) {
@@ -2842,10 +2838,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 {
 	struct hci_conn_params *param;
 
-	/* The list only contains identity addresses */
-	if (!hci_is_identity_address(addr, addr_type))
-		return NULL;
-
 	list_for_each_entry(param, list, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
@@ -2861,9 +2853,6 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 {
 	struct hci_conn_params *params;
 
-	if (!hci_is_identity_address(addr, addr_type))
-		return NULL;
-
 	params = hci_conn_params_lookup(hdev, addr, addr_type);
 	if (params)
 		return params;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 47462bf..2ca87cf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6226,7 +6226,11 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	else
 		auto_conn = HCI_AUTO_CONN_REPORT;
 
-	/* Allow only identity addresses */
+	/* Kernel internally uses conn_params with resolvable private
+	 * address, but Remove Device allows only identity addresses.
+	 * Make sure it is enforced before calling
+	 * hci_conn_params_lookup.
+	 */
 	if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
 		err = cmd->cmd_complete(cmd, MGMT_STATUS_INVALID_PARAMS);
 		mgmt_pending_remove(cmd);
@@ -6347,6 +6351,17 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 		else
 			addr_type = ADDR_LE_DEV_RANDOM;
 
+		/* Kernel internally uses conn_params with resolvable private
+		 * address, but Remove Device allows only identity addresses.
+		 * Make sure it is enforced before calling
+		 * hci_conn_params_lookup.
+		 */
+		if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
+			err = cmd->cmd_complete(cmd,
+						MGMT_STATUS_INVALID_PARAMS);
+			mgmt_pending_remove(cmd);
+			goto unlock;
+		}
 		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
 						addr_type);
 		if (!params) {
-- 
2.1.4

