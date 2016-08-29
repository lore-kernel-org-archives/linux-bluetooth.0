Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use command status event for Set IO Capability errors
Date: Mon, 29 Aug 2016 06:31:57 +0200
Message-Id: <1472445117-6527-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of failure, the Set IO Capability command is suppose to return
command status and not command complete.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7a7a8be3f2e4..c5345c814e49 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2513,8 +2513,8 @@ static int set_io_capability(struct sock *sk, struct hci_dev *hdev, void *data,
 	BT_DBG("");
 
 	if (cp->io_capability > SMP_IO_KEYBOARD_DISPLAY)
-		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
-					 MGMT_STATUS_INVALID_PARAMS, NULL, 0);
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
+				       MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
-- 
2.7.4

