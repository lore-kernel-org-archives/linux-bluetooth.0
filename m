Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] Bluetooth: Use real advertising state to random address update decision
Date: Tue,  8 Jul 2014 15:07:49 +0300
Message-Id: <1404821273-28005-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that we have a flag for tracking the real advertising state we
should use that to determine whether it's safe to update the random
address or not. The couple of places that were clearing the flag due to
a pending request need to be updated too.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 4 ++--
 net/bluetooth/hci_core.c | 2 +-
 net/bluetooth/mgmt.c     | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 16fd55da9c1d..0db2579ea6c6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -671,12 +671,12 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	enable = 0x00;
 	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
 
-	/* Clear the HCI_ADVERTISING bit temporarily so that the
+	/* Clear the HCI_LE_ADV bit temporarily so that the
 	 * hci_update_random_address knows that it's safe to go ahead
 	 * and write a new random address. The flag will be set back on
 	 * as soon as the SET_ADV_ENABLE HCI command completes.
 	 */
-	clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
 
 	/* Set require_privacy to false so that the remote device has a
 	 * chance of identifying us.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f1c5a077e558..8ffaca0290f8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3746,7 +3746,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	 * In this kind of scenario skip the update and let the random
 	 * address be updated at the next cycle.
 	 */
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) ||
+	if (test_bit(HCI_LE_ADV, &hdev->dev_flags) ||
 	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
 		BT_DBG("Deferring random address update");
 		return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dda1eb124208..be589d8d437f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1046,12 +1046,12 @@ static void enable_advertising(struct hci_request *req)
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
 
-	/* Clear the HCI_ADVERTISING bit temporarily so that the
+	/* Clear the HCI_LE_ADV bit temporarily so that the
 	 * hci_update_random_address knows that it's safe to go ahead
 	 * and write a new random address. The flag will be set back on
 	 * as soon as the SET_ADV_ENABLE HCI command completes.
 	 */
-	clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+	clear_bit(HCI_LE_ADV, &hdev->dev_flags);
 
 	connectable = get_connectable(hdev);
 
-- 
1.9.3

