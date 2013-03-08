Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] Bluetooth: Merge LE-only and interleaved cases
Date: Fri,  8 Mar 2013 20:06:15 -0300
Message-Id: <1362783979-10142-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
References: <1362783979-10142-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch merges the LE-only and interleaved discovery type cases.
Since hci_le_scan helper uses the HCI request framework, those cases
are pretty much the same now.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fbf3265..0fe7a87 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2501,6 +2501,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	case DISCOV_TYPE_LE:
+	case DISCOV_TYPE_INTERLEAVED:
 		if (!lmp_host_le_capable(hdev)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
@@ -2508,18 +2509,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		hci_req_init(&req, hdev);
-
-		err = hci_le_scan(&req, LE_SCAN_TYPE, LE_SCAN_INT,
-				  LE_SCAN_WIN);
-		if (err)
-			break;
-
-		err = hci_req_run(&req, enable_le_scan_complete);
-		break;
-
-	case DISCOV_TYPE_INTERLEAVED:
-		if (!lmp_host_le_capable(hdev) || !lmp_bredr_capable(hdev)) {
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+		    !lmp_bredr_capable(hdev)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
-- 
1.8.1.2

