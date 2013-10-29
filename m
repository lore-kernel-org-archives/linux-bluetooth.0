Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 10/15] Bluetooth: Temporarily stop background scanning on discovery
Date: Tue, 29 Oct 2013 10:25:55 -0300
Message-Id: <1383053160-10175-11-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the user send a mgmt start discovery command while the background
scanning is running, we should temporarily stop it. Once the discovery
finishes, we start the background scanning again.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |  5 +++++
 net/bluetooth/mgmt.c     | 12 ++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 79debc3..44d3f99 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1496,6 +1496,11 @@ void hci_discovery_set_state(struct hci_dev *hdev, int state)
 
 	switch (state) {
 	case DISCOVERY_STOPPED:
+		/* Check the background scanning since it may have been
+		 * temporarily stopped by the start discovery command.
+		 */
+		hci_check_background_scan(hdev);
+
 		if (hdev->discovery.state != DISCOVERY_STARTING)
 			mgmt_discovering(hdev, 0);
 		break;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 22cf547..0e329e5 100644
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
1.8.4

