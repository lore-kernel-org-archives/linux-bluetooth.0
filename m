Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Simplify the code for re-arming discoverable timeout
Date: Tue, 15 Oct 2013 08:28:51 -0700
Message-Id: <1381850931-34295-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When only the discoverable timeout gets updated, just cancel the current
timeout, store the new timeout value. If the new timeout is valid, then
arm the discoverable timeout again.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 686bda76..1d608ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1143,15 +1143,13 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	if (!!cp->val == test_bit(HCI_DISCOVERABLE, &hdev->dev_flags)) {
-		if (hdev->discov_timeout > 0) {
-			cancel_delayed_work(&hdev->discov_off);
-			hdev->discov_timeout = 0;
-		}
+		cancel_delayed_work(&hdev->discov_off);
+		hdev->discov_timeout = timeout;
 
-		if (cp->val && timeout > 0) {
-			hdev->discov_timeout = timeout;
+		if (cp->val && hdev->discov_timeout > 0) {
+			int to = msecs_to_jiffies(hdev->discov_timeout * 1000);
 			queue_delayed_work(hdev->workqueue, &hdev->discov_off,
-				msecs_to_jiffies(hdev->discov_timeout * 1000));
+					   to);
 		}
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_DISCOVERABLE, hdev);
-- 
1.8.3.1

