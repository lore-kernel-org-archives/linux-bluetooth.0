Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v9 07/10] Bluetooth: Temporarily stop background scanning on discovery
Date: Tue, 18 Feb 2014 14:54:58 -0300
Message-Id: <1392746101-5981-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
References: <1392746101-5981-1-git-send-email-andre.guedes@openbossa.org>
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
index 219a5aa..d53e031 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1612,6 +1612,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
+		hci_update_background_scan(hdev);
+
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25a0c46..1d35362 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3330,12 +3330,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
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
+			hci_req_add_le_scan_disable(&req);
 
 		memset(&param_cp, 0, sizeof(param_cp));
 		param_cp.type = LE_SCAN_ACTIVE;
-- 
1.8.5.4

