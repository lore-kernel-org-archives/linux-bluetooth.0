Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v8 07/10] Bluetooth: Temporarily stop background scanning on discovery
Date: Wed,  5 Feb 2014 19:23:23 -0300
Message-Id: <1391639006-26311-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org>
References: <1391639006-26311-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the user sends a mgmt start discovery command while the background
scanning is running, we should temporarily stop it. Once the discovery
finishes, we start the background scanning again.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |  2 ++
 net/bluetooth/mgmt.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff85205..8ddb332 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1609,6 +1609,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
+		hci_update_background_scan(hdev);
+
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5c0d55d..9996516 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3319,12 +3319,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_BUSY);
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
+		/* If controller is scanning, it means the background scanning
+		 * is running. Thus, we should temporarily stop it in order to
+		 * set the discovery scanning parameters.
+		 */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			hci_stop_le_scan_req(&req);
 
 		memset(&param_cp, 0, sizeof(param_cp));
 		param_cp.type = LE_SCAN_ACTIVE;
-- 
1.8.5.3

