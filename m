Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Add protections for updating local random address
Date: Fri, 28 Feb 2014 12:54:14 +0200
Message-Id: <1393584857-30375-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393584857-30375-1-git-send-email-johan.hedberg@gmail.com>
References: <1393584857-30375-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Different controllers behave differently when HCI_Set_Random_Address is
called while they are advertising or have a HCI_LE_Create_Connection in
progress. Some take the newly written address into use for the pending
operation while others use the random address that we had at the time
that the operation started.

Due to this undefined behavior and for the fact that we want to reliably
determine the initiator address of all connections for the sake of SMP
it's best to simply prevent the random address update if we have these
problematic operations in progress.

This patch adds a set_random_addr() helper function for the use of
hci_update_random_address which contains the necessary checks for
advertising and ongoing LE connections.

One extra thing we need to do is to clear the HCI_ADVERTISING flag in
the enable_advertising() function before sending any commands. Since
re-enabling advertising happens by calling first disable_advertising()
and then enable_advertising() all while having the HCI_ADVERTISING flag
set. Clearing the flag lets the set_random_addr() function know that
it's safe to write a new address at least as far as advertising is
concerned.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 27 +++++++++++++++++++++++++--
 net/bluetooth/mgmt.c     |  7 +++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 32c0c2c58f66..8bbfdea9cbec 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3649,6 +3649,29 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	/* If we're advertising or initiating an LE connection we can't
+	 * go ahead and change the random address at this time. This is
+	 * because the eventual initiator address used for the
+	 * subsequently created connection will be undefined (some
+	 * controllers use the new address and others the one we had
+	 * when the operation started).
+	 *
+	 * In this kind of scenario skip the update and let the random
+	 * address be updated at the next cycle.
+	 */
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags) ||
+	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+		BT_DBG("Deferring random address update");
+		return;
+	}
+
+	hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, rpa);
+}
+
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			      u8 *own_addr_type)
 {
@@ -3674,7 +3697,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 			return err;
 		}
 
-		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &hdev->rpa);
+		set_random_addr(req, &hdev->rpa);
 
 		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
 		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
@@ -3693,7 +3716,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 		urpa.b[5] &= 0x3f;	/* Clear two most significant bits */
 
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
-		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &urpa);
+		set_random_addr(req, &urpa);
 		return 0;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2d11c817d082..98e9df3556e7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -840,6 +840,13 @@ static void enable_advertising(struct hci_request *req)
 	u8 own_addr_type, enable = 0x01;
 	bool connectable;
 
+	/* Clear the HCI_ADVERTISING bit temporarily so that the
+	 * hci_update_random_address knows that it's safe to go ahead
+	 * and write a new random address. The flag will be set back on
+	 * as soon as the SET_ADV_ENABLE HCI command completes.
+	 */
+	clear_bit(HCI_ADVERTISING, &hdev->dev_flags);
+
 	connectable = get_connectable(hdev);
 
 	/* Set require_privacy to true only when non-connectable
-- 
1.8.5.3

