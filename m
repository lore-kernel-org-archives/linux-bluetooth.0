Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v11 09/15] Bluetooth: Temporarily stop background scanning on discovery
Date: Mon, 24 Feb 2014 19:30:55 -0300
Message-Id: <1393281061-14320-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
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
index 0c1d2e3..831cca8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1786,6 +1786,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
+		hci_update_background_scan(hdev);
+
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c722914..7c8a611 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3432,12 +3432,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
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
 
-- 
1.8.5.4

