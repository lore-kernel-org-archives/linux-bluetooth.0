Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 1/7] Bluetooth: Simplify the error handling of Start Discovery command
Date: Thu,  4 Dec 2014 11:36:34 +0100
Message-Id: <1417689400-128063-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Start Discovery command has some complicated code when it comes
to error handling. With the future introduction of Start Service
Discovery simplifying this makes it easier to read.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 77cf0ef0d8a3..f3296371a310 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3771,14 +3771,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
-		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_BUSY, &cp->type,
-				   sizeof(cp->type));
-		goto failed;
-	}
-
-	if (hdev->discovery.state != DISCOVERY_STOPPED) {
+	if (hdev->discovery.state != DISCOVERY_STOPPED ||
+	    test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 				   MGMT_STATUS_BUSY, &cp->type,
 				   sizeof(cp->type));
@@ -3909,10 +3903,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	err = hci_req_run(&req, start_discovery_complete);
-	if (err < 0)
+	if (err < 0) {
 		mgmt_pending_remove(cmd);
-	else
-		hci_discovery_set_state(hdev, DISCOVERY_STARTING);
+		goto failed;
+	}
+
+	hci_discovery_set_state(hdev, DISCOVERY_STARTING);
 
 failed:
 	hci_dev_unlock(hdev);
-- 
1.9.3

