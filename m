Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix length for Read Local OOB Extended Data respone packet
Date: Mon, 16 Mar 2015 16:05:44 -0700
Message-Id: <1426547144-1935-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The length of the respone packet for Read Local OOB Extended Data
command has a calculation error. In case LE Secure Connections support
is not enabled, the actual response is shorter. Keep this in mind and
update the value accordingly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 32c2c75c0888..7fa3c4b8384b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6388,7 +6388,7 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_unlock(hdev);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-				MGMT_STATUS_SUCCESS, rp, rp_len);
+				MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
 
 done:
 	kfree(rp);
-- 
2.1.0

