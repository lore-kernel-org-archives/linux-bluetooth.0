Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Support scanning for devices using RPA
Date: Wed,  2 Jul 2014 23:09:24 +0300
Message-Id: <1404331764-24731-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're scanning for specific devices that use an RPA we need to
convert the RPA to the identity address before looking up the entry in
the connection parameters. This patch adds the necessary code to do this
in the process_adv_report() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 87a704bd7eb7..dd70e3a4fea5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4231,6 +4231,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	 */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
 		struct hci_conn_params *param;
+		struct smp_irk *irk;
 
 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
 			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
@@ -4241,6 +4242,17 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
+		/* Check if we need to convert to identity address */
+		irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
+		if (irk) {
+			bdaddr = &irk->bdaddr;
+			bdaddr_type = irk->addr_type;
+		}
+
+		/* The conn params list only contains identity addresses */
+		if (!hci_is_identity_address(bdaddr, bdaddr_type))
+			return;
+
 		param = hci_conn_params_lookup(hdev, bdaddr, bdaddr_type);
 		if (!param || param->auto_connect != HCI_AUTO_CONN_REPORT)
 			return;
-- 
1.9.3

