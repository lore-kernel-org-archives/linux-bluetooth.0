Return-Path: <cyrus@holtmann.org>
From: Cristian Chilipirea <cristian.chilipirea@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	daniel.baluta@gmail.com,
	Cristian Chilipirea <cristian.chilipirea@gmail.com>
Subject: [PATCH] bluetooth: Fixed checkpatch warnings
Date: Wed,  9 May 2012 08:44:52 +0300
Message-Id: <1336542292-15258-1-git-send-email-cristian.chilipirea@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed some checkpatch warnings in mgmt.c.

Signed-off-by: Cristian Chilipirea <cristian.chilipirea@gmail.com>
---
 net/bluetooth/mgmt.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)
 mode change 100644 => 100755 net/bluetooth/mgmt.c

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
old mode 100644
new mode 100644
index 4bb03b1..494004d
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1122,8 +1122,8 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
-	     err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-			      MGMT_STATUS_BUSY);
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				 MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -2884,7 +2884,8 @@ int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 	return 0;
 }
 
-int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key, bool persistent)
+int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
+		      bool persistent)
 {
 	struct mgmt_ev_new_link_key ev;
 
@@ -3001,7 +3002,7 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 sk);
 
 	if (sk)
-	  sock_put(sk);
+		sock_put(sk);
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
 			     hdev);
@@ -3413,7 +3414,7 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 
 		if (enable && test_and_clear_bit(HCI_LE_ENABLED,
 						 &hdev->dev_flags))
-		  err = new_settings(hdev, NULL);
+			err = new_settings(hdev, NULL);
 
 		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev,
 				     cmd_status_rsp, &mgmt_err);
-- 
1.7.5.4
