Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Restrict disabling of HS when controller is powered off
Date: Wed,  2 Oct 2013 00:27:02 -0700
Message-Id: <1380698822-25791-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disabling the high speed setting when the controller is powered on has
too many side effects that are not taken care of. And in general it
is not an useful operation anyway. So just make such a command fail
with a rejection error message.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ad38629..35d3c12 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1352,10 +1352,17 @@ static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	hci_dev_lock(hdev);
 
-	if (cp->val)
+	if (cp->val) {
 		changed = !test_and_set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
-	else
+	} else {
+		if (hdev_is_powered(hdev)) {
+			err = cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+					 MGMT_STATUS_REJECTED);
+			goto unlock;
+		}
+
 		changed = test_and_clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
+	}
 
 	err = send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
 	if (err < 0)
-- 
1.8.3.1

