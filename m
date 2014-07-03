Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Remove redundant IRK lookup
Date: Thu,  3 Jul 2014 19:33:48 +0300
Message-Id: <1404405231-16390-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
References: <1404405231-16390-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When processing passive scanning results we need the resolved identity
address both in check_pending_le_conn() as well as later in
process_adv_report(). Since process_adv_report() calls
check_pending_le_conn() we can simply resolve the IRK earlier in the
function and thereby eliminate a second lookup.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dd70e3a4fea5..643c5a8d4050 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4186,16 +4186,6 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				  u8 addr_type)
 {
 	struct hci_conn *conn;
-	struct smp_irk *irk;
-
-	/* If this is a resolvable address, we should resolve it and then
-	 * update address and address type variables.
-	 */
-	irk = hci_get_irk(hdev, addr, addr_type);
-	if (irk) {
-		addr = &irk->bdaddr;
-		addr_type = irk->addr_type;
-	}
 
 	if (!hci_pend_le_conn_lookup(hdev, addr, addr_type))
 		return;
@@ -4233,6 +4223,13 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		struct hci_conn_params *param;
 		struct smp_irk *irk;
 
+		/* Check if we need to convert to identity address */
+		irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
+		if (irk) {
+			bdaddr = &irk->bdaddr;
+			bdaddr_type = irk->addr_type;
+		}
+
 		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
 			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
 
@@ -4242,13 +4239,6 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
-		/* Check if we need to convert to identity address */
-		irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
-		if (irk) {
-			bdaddr = &irk->bdaddr;
-			bdaddr_type = irk->addr_type;
-		}
-
 		/* The conn params list only contains identity addresses */
 		if (!hci_is_identity_address(bdaddr, bdaddr_type))
 			return;
-- 
1.9.3

