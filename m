Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix pair device command reply if adapter is powered off
Date: Fri, 18 Jan 2013 12:48:07 +0100
Message-ID: <1358509687-7194-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Bluetooth Management API specification Pair Device Command
should generate command complete event on both success and failure.
This fix replying with command status (which lacks address info) when
adapter is powered off.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc171f2..3aa8c38 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1939,11 +1939,15 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
-				 MGMT_STATUS_NOT_POWERED);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
 		goto unlock;
 	}
 
@@ -1960,10 +1964,6 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
 				   cp->addr.type, sec_level, auth_type);
 
-	memset(&rp, 0, sizeof(rp));
-	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
-	rp.addr.type = cp->addr.type;
-
 	if (IS_ERR(conn)) {
 		int status;
 
-- 
1.8.0.3

