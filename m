Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow setting static address even if LE is disabled
Date: Wed,  2 Oct 2013 22:10:32 -0700
Message-Id: <1380777032-23598-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Setting the static address does not depend on LE beeing enabled. It
only depends on a controller with LE support.

When depending on LE enabled this command becomes really complicated
since in case LE gets disabled, it would be required to clear the
static address and also its random address representation inside
the controller. With future support for private addresses such
complex setup should be avoided.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5c44e30..a336027 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3293,15 +3293,13 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 			      void *data, u16 len)
 {
 	struct mgmt_cp_set_static_address *cp = data;
-	u8 status;
 	int err;
 
 	BT_DBG("%s", hdev->name);
 
-	status = mgmt_le_support(hdev);
-	if (status)
+	if (!lmp_le_capable(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
-				  status);
+				  MGMT_STATUS_NOT_SUPPORTED);
 
 	if (hdev_is_powered(hdev))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_STATIC_ADDRESS,
-- 
1.8.3.1

