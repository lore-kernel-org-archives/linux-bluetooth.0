Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Bluetooth: mgmt: Fix some code style and indentation issues
Date: Fri, 16 Mar 2012 16:02:56 +0100
Message-ID: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 212b8a4..70eee11 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1144,8 +1144,8 @@ static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
-	     err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
-			      MGMT_STATUS_BUSY);
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+				 MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -3048,7 +3048,7 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			 sk);
 
 	if (sk)
-	  sock_put(sk);
+		sock_put(sk);
 
 	mgmt_pending_foreach(MGMT_OP_UNPAIR_DEVICE, hdev, unpair_device_rsp,
 			     hdev);
@@ -3460,10 +3460,10 @@ int mgmt_le_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 
 		if (enable && test_and_clear_bit(HCI_LE_ENABLED,
 						 &hdev->dev_flags))
-		  err = new_settings(hdev, NULL);
+			err = new_settings(hdev, NULL);
 
-		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev,
-				     cmd_status_rsp, &mgmt_err);
+		mgmt_pending_foreach(MGMT_OP_SET_LE, hdev, cmd_status_rsp,
+				     &mgmt_err);
 
 		return err;
 	}
-- 
on behalf of ST-Ericsson

