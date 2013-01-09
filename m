Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Fix returning proper command status for start_discovery
Date: Wed,  9 Jan 2013 15:29:37 +0200
Message-Id: <1357738180-4128-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
References: <1357738180-4128-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Management commands should whenever possible fail with proper command
status or command complete events. This patch fixes the
mgmt_start_discovery command to do this for the failure cases where an
incorrect parameter value was passed to it ("not supported" if the
parameter value was valid but the controller doesn't support it and
"invalid params" if it isn't valid at all).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6e6de9e..4f60540 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2377,31 +2377,46 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
-		if (lmp_bredr_capable(hdev))
+		if (lmp_bredr_capable(hdev)) {
 			err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
-		else
-			err = -ENOTSUPP;
+		} else {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_NOT_SUPPORTED);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
 		break;
 
 	case DISCOV_TYPE_LE:
-		if (lmp_host_le_capable(hdev))
+		if (lmp_host_le_capable(hdev)) {
 			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
 					  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
-		else
-			err = -ENOTSUPP;
+		} else {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_NOT_SUPPORTED);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev))
+		if (lmp_host_le_capable(hdev) && lmp_bredr_capable(hdev)) {
 			err = hci_le_scan(hdev, LE_SCAN_TYPE, LE_SCAN_INT,
 					  LE_SCAN_WIN,
 					  LE_SCAN_TIMEOUT_BREDR_LE);
-		else
-			err = -ENOTSUPP;
+		} else {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_NOT_SUPPORTED);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
 		break;
 
 	default:
-		err = -EINVAL;
+		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				 MGMT_STATUS_INVALID_PARAMS);
+		mgmt_pending_remove(cmd);
+		goto failed;
 	}
 
 	if (err < 0)
-- 
1.7.10.4

