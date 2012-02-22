Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Disabling discoverable with timeout is invalid
Date: Wed, 22 Feb 2012 18:06:34 +0100
Message-Id: <1329930394-6213-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add one extra sanity check to ensure that the supplied timeout value is
actually valid in this context.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d756644..6df4af6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -850,13 +850,16 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
+	timeout = get_unaligned_le16(&cp->timeout);
+	if (!cp->val && timeout > 0)
+		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+						MGMT_STATUS_INVALID_PARAMS);
+
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	timeout = get_unaligned_le16(&cp->timeout);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev) && timeout > 0) {
-- 
1.7.7.6

