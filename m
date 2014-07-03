Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: Add identity address check in param lookup functions
Date: Thu,  3 Jul 2014 19:33:51 +0300
Message-Id: <1404405231-16390-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
References: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since we only store entries with identity addresses in the
le_conn_params and pend_le_conns lists we can avoid unnecessary lookups
by checking for an identity address before diving into the lists
themselves.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c  | 8 ++++++++
 net/bluetooth/hci_event.c | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8882a6cd2876..750f969df8db 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3399,6 +3399,10 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 {
 	struct hci_conn_params *params;
 
+	/* The conn params list only contains identity addresses */
+	if (!hci_is_identity_address(addr, addr_type))
+		return NULL;
+
 	list_for_each_entry(params, &hdev->le_conn_params, list) {
 		if (bacmp(&params->addr, addr) == 0 &&
 		    params->addr_type == addr_type) {
@@ -3432,6 +3436,10 @@ struct hci_conn_params *hci_pend_le_conn_lookup(struct hci_dev *hdev,
 {
 	struct hci_conn_params *param;
 
+	/* The list only contains identity addresses */
+	if (!hci_is_identity_address(addr, addr_type))
+		return NULL;
+
 	list_for_each_entry(param, &hdev->pend_le_conns, pend_le_conn) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index e0b439d4f958..20317e516e74 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4246,10 +4246,6 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
-		/* The conn params list only contains identity addresses */
-		if (!hci_is_identity_address(bdaddr, bdaddr_type))
-			return;
-
 		param = hci_conn_params_lookup(hdev, bdaddr, bdaddr_type);
 		if (!param || param->auto_connect != HCI_AUTO_CONN_REPORT)
 			return;
-- 
1.9.3

