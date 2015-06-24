Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>, root <root@google.com>
Subject: [PATCH v1 1/2] Bluetooth: Move address type check for hci_conn_params
Date: Wed, 24 Jun 2015 16:32:09 -0700
Message-Id: <1435188730-14151-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using "add device" mgmt command to add devices to whitelist, only
identity addresses are allowed. This restriction is enforced in methods
manipulating hci_conn_params. This patch removes those checks, and
instead add a check inside "add device" command implementation.

Reason behind that is hci_conn_params structure will be internally used
for other addresses in upcoming patches modifying connection procedure.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Signed-off-by: root <root@google.com>
---
 net/bluetooth/hci_core.c | 11 -----------
 net/bluetooth/mgmt.c     |  7 +++++++
 2 files changed, 7 insertions(+), 11 deletions(-)

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
index 7998fb2..a7d1b33 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6226,6 +6226,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	else
 		auto_conn = HCI_AUTO_CONN_REPORT;
 
+	/* Allow only identity addresses */
+	if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
+		err = cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
+		mgmt_pending_remove(cmd);
+		goto unlock;
+	}
+
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-- 
2.4.3.573.g4eafbef

