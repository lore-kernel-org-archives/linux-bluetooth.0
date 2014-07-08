Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Fix advertising and active scanning co-existence
Date: Tue,  8 Jul 2014 15:07:53 +0300
Message-Id: <1404821273-28005-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Many controllers allow simultaneous active scanning and advertising
(e.g. Intel and Broadcom) but some do not (e.g. CSR). It's therefore
safest to implement mutual exclusion of these states in the kernel.

This patch ensures that the two states are never entered simultaneously.
Extra precaution needs to be taken for outgoing connection attempts in
slave role (i.e. through directed advertising) in which case the
operation that came first has precedence and the one that comes after
gets a rejection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  | 10 ++++++++++
 net/bluetooth/hci_event.c | 10 +++++++++-
 net/bluetooth/mgmt.c      | 24 ++++++++++++++++++------
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1517f1549f85..490ee8846d9e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -772,6 +772,16 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	/* If requested to connect as slave use directed advertising */
 	if (!master) {
+		/* If we're active scanning most controllers are unable
+		 * to initiate advertising. Simply reject the attempt.
+		 */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+		    hdev->le_scan_type == LE_SCAN_ACTIVE) {
+			skb_queue_purge(&req.cmd_q);
+			hci_conn_del(conn);
+			return ERR_PTR(-EBUSY);
+		}
+
 		hci_req_directed_advertising(&req, conn);
 		goto create_conn;
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8fbf604ba228..5d3095d7d4b0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1176,13 +1176,21 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		cancel_delayed_work(&hdev->le_scan_disable);
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
+
 		/* The HCI_LE_SCAN_INTERRUPTED flag indicates that we
 		 * interrupted scanning due to a connect request. Mark
-		 * therefore discovery as stopped.
+		 * therefore discovery as stopped. If this was not
+		 * because of a connect request advertising might have
+		 * been disabled because of active scanning, so
+		 * re-enable it again if necessary.
 		 */
 		if (test_and_clear_bit(HCI_LE_SCAN_INTERRUPTED,
 				       &hdev->dev_flags))
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		else if (!test_bit(HCI_LE_ADV, &hdev->dev_flags) &&
+			 hdev->discovery.state != DISCOVERY_STARTING)
+			mgmt_reenable_advertising(hdev);
+
 		break;
 
 	default:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9549d7366da2..944e6463fd61 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3726,11 +3726,21 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_REJECTED);
-			mgmt_pending_remove(cmd);
-			goto failed;
+		if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
+			/* Don't let discovery abort an outgoing
+			 * connection attempt that's using directed
+			 * advertising.
+			 */
+			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
+						       BT_CONNECT)) {
+				err = cmd_status(sk, hdev->id,
+						 MGMT_OP_START_DISCOVERY,
+						 MGMT_STATUS_REJECTED);
+				mgmt_pending_remove(cmd);
+				goto failed;
+			}
+
+			disable_advertising(&req);
 		}
 
 		/* If controller is scanning, it means the background scanning
@@ -4078,7 +4088,9 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 	 * necessary).
 	 */
 	if (!hdev_is_powered(hdev) || val == enabled ||
-	    hci_conn_num(hdev, LE_LINK) > 0) {
+	    hci_conn_num(hdev, LE_LINK) > 0 ||
+	    (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	     hdev->le_scan_type == LE_SCAN_ACTIVE)) {
 		bool changed = false;
 
 		if (val != test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
-- 
1.9.3

