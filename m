Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 13/13] Bluetooth: Remove unneeded hdev->own_addr_type
Date: Sun, 23 Feb 2014 19:42:29 +0200
Message-Id: <1393177349-361-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that the identity address type is always looked up for all
successful connections using the hci_copy_identity_address function the
hdev->own_addr_type variable has become completely unnecessary. Simply
remove it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 17 +----------------
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2506963c7a06..43b6d1131c4d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -156,7 +156,6 @@ struct hci_dev {
 	bdaddr_t	bdaddr;
 	bdaddr_t	random_addr;
 	bdaddr_t	static_addr;
-	__u8		own_addr_type;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
 	__u8		short_name[HCI_MAX_SHORT_NAME_LENGTH];
 	__u8		eir[HCI_MAX_EIR_LENGTH];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 629919be071c..1651de959d9c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1506,23 +1506,8 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 	if (hdev->commands[5] & 0x10)
 		hci_setup_link_policy(req);
 
-	if (lmp_le_capable(hdev)) {
-		/* If the controller has a public BD_ADDR, then by default
-		 * use that one. If this is a LE only controller without
-		 * a public address, default to the random address.
-		 *
-		 * For debugging purposes it is possible to force
-		 * controllers with a public address to use the
-		 * random address instead.
-		 */
-		if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
-		    !bacmp(&hdev->bdaddr, BDADDR_ANY))
-			hdev->own_addr_type = ADDR_LE_DEV_RANDOM;
-		else
-			hdev->own_addr_type = ADDR_LE_DEV_PUBLIC;
-
+	if (lmp_le_capable(hdev))
 		hci_set_le_support(req);
-	}
 
 	/* Read features beyond page 1 if available */
 	for (p = 2; p < HCI_MAX_PAGES && p <= hdev->max_page; p++) {
-- 
1.8.5.3

