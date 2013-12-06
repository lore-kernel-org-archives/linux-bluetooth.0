Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 09/12] Bluetooth: Temporarily stop background scanning on discovery
Date: Fri,  6 Dec 2013 19:05:46 -0300
Message-Id: <1386367549-29136-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
References: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the user send a mgmt start discovery command while the background
scanning is running, we should temporarily stop it. Once the discovery
finishes, we start the background scanning again.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |  2 ++
 net/bluetooth/mgmt.c     | 12 ++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 47d31bd..5bb73cf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1498,6 +1498,8 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
+		hci_update_background_scan(hdev);
+
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a03ca3c..81b8cfa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3280,11 +3280,15 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
+		/* If controller is scanning, it means the background scanning
+		 * is running. Thus, we should temporarily stop it in order to
+		 * set the discovery scanning parameters.
+		 */
 		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_BUSY);
-			mgmt_pending_remove(cmd);
-			goto failed;
+			memset(&enable_cp, 0, sizeof(enable_cp));
+			enable_cp.enable = LE_SCAN_DISABLE;
+			hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE,
+				    sizeof(enable_cp), &enable_cp);
 		}
 
 		memset(&param_cp, 0, sizeof(param_cp));
-- 
1.8.4.2

