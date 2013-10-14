Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Reorganize set_connectable HCI command sending
Date: Mon, 14 Oct 2013 13:52:40 +0300
Message-Id: <1381747965-24599-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
References: <1381747965-24599-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch moves all the decisions of which HCI commands to send (or not
to send) to the code between hci_req_init() and hci_req_run() this
allows us to further extend the request with further commands but still
keep the same logic of handling whether to return a direct mgmt response
in the case that no HCI commands were sent.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6f07523..982b397 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1144,30 +1144,29 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (!!cp->val == test_bit(HCI_PSCAN, &hdev->flags)) {
-		err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE, hdev);
-		goto failed;
-	}
-
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_CONNECTABLE, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
 	}
 
-	if (cp->val) {
-		scan = SCAN_PAGE;
-	} else {
-		scan = 0;
+	hci_req_init(&req, hdev);
 
-		if (test_bit(HCI_ISCAN, &hdev->flags) &&
-		    hdev->discov_timeout > 0)
-			cancel_delayed_work(&hdev->discov_off);
-	}
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
+	    cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
 
-	hci_req_init(&req, hdev);
+		if (cp->val) {
+			scan = SCAN_PAGE;
+		} else {
+			scan = 0;
 
-	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+			if (test_bit(HCI_ISCAN, &hdev->flags) &&
+					hdev->discov_timeout > 0)
+				cancel_delayed_work(&hdev->discov_off);
+		}
+
+		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	}
 
 	/* If we're going from non-connectable to connectable or
 	 * vice-versa when fast connectable is enabled ensure that fast
@@ -1179,8 +1178,13 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 		write_fast_connectable(&req, false);
 
 	err = hci_req_run(&req, set_connectable_complete);
-	if (err < 0)
+	if (err < 0) {
 		mgmt_pending_remove(cmd);
+		if (err == -ENODATA)
+			err = send_settings_rsp(sk, MGMT_OP_SET_CONNECTABLE,
+						hdev);
+		goto failed;
+	}
 
 failed:
 	hci_dev_unlock(hdev);
-- 
1.8.3.1

