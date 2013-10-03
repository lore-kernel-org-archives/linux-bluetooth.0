Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Reject device class changes when BR/EDR is not available
Date: Wed,  2 Oct 2013 21:39:24 -0700
Message-Id: <1380775164-15479-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On LE only controllers or dual mode controllers with BR/EDR disabled,
it makes no sense to allow programming of the minor and major class
values. In these cases, just reject the operation.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e93d19a..9dbf185 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1753,13 +1753,14 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct mgmt_cp_set_dev_class *cp = data;
 	struct pending_cmd *cmd;
 	struct hci_request req;
+	u8 status;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
-		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
-				  MGMT_STATUS_NOT_SUPPORTED);
+	status = mgmt_bredr_support(hdev);
+	if (status)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, status);
 
 	hci_dev_lock(hdev);
 
-- 
1.8.3.1

