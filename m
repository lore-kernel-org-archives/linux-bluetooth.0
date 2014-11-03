Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jukka Taimisto <jtt@codenomicon.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix invalid response for 'Start Discovery' command
Date: Mon,  3 Nov 2014 14:20:56 +0100
Message-Id: <1415020856-9018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Management Interface API 'Start Discovery' command should
generate a Command Complete event on failure. Currently kernel is
sending Command Status on early errors. This results in userspace
ignoring such event due to invalid size.

bluetoothd[28499]: src/adapter.c:trigger_start_discovery()
bluetoothd[28499]: src/adapter.c:cancel_passive_scanning()
bluetoothd[28499]: src/adapter.c:start_discovery_timeout()
bluetoothd[28499]: src/adapter.c:start_discovery_complete() status 0x0a
bluetoothd[28499]: Wrong size of start discovery return parameters

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
Reported-by: Jukka Taimisto <jtt@codenomicon.com>
---
 net/bluetooth/mgmt.c | 56 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9c4daf7..ce0272c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3727,20 +3727,23 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				 MGMT_STATUS_NOT_POWERED);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				   MGMT_STATUS_NOT_POWERED,
+				   &cp->type, sizeof(cp->type));
 		goto failed;
 	}
 
 	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				 MGMT_STATUS_BUSY);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				   MGMT_STATUS_BUSY, &cp->type,
+				   sizeof(cp->type));
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				 MGMT_STATUS_BUSY);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				   MGMT_STATUS_BUSY, &cp->type,
+				   sizeof(cp->type));
 		goto failed;
 	}
 
@@ -3758,15 +3761,18 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_BREDR:
 		status = mgmt_bredr_support(hdev);
 		if (status) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 status);
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_START_DISCOVERY, status,
+					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_BUSY);
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_START_DISCOVERY,
+					   MGMT_STATUS_BUSY, &cp->type,
+					   sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3783,16 +3789,19 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	case DISCOV_TYPE_INTERLEAVED:
 		status = mgmt_le_support(hdev);
 		if (status) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 status);
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_START_DISCOVERY, status,
+					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
 		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_NOT_SUPPORTED);
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_START_DISCOVERY,
+					   MGMT_STATUS_NOT_SUPPORTED,
+					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3804,9 +3813,11 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			 */
 			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
 						       BT_CONNECT)) {
-				err = cmd_status(sk, hdev->id,
-						 MGMT_OP_START_DISCOVERY,
-						 MGMT_STATUS_REJECTED);
+				err = cmd_complete(sk, hdev->id,
+						   MGMT_OP_START_DISCOVERY,
+						   MGMT_STATUS_REJECTED,
+						   &cp->type,
+						   sizeof(cp->type));
 				mgmt_pending_remove(cmd);
 				goto failed;
 			}
@@ -3829,8 +3840,10 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		 */
 		err = hci_update_random_address(&req, true, &own_addr_type);
 		if (err < 0) {
-			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					 MGMT_STATUS_FAILED);
+			err = cmd_complete(sk, hdev->id,
+					   MGMT_OP_START_DISCOVERY,
+					   MGMT_STATUS_FAILED,
+					   &cp->type, sizeof(cp->type));
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
@@ -3850,8 +3863,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		break;
 
 	default:
-		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				 MGMT_STATUS_INVALID_PARAMS);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+				   MGMT_STATUS_INVALID_PARAMS,
+				   &cp->type, sizeof(cp->type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
-- 
1.9.3

