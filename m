Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH] Bluetooth: Remove magic value in disconnect mgmt handler
Date: Mon, 11 Jun 2012 22:13:38 -0300
Message-Id: <1339463618-5862-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the magic value of variable 'reason' by the
proper macro.

Signed-off-by: Paulo Alcantara <paulo.alcantara@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5903d3b..00c9ec1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1557,7 +1557,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	dc.handle = cpu_to_le16(conn->handle);
-	dc.reason = 0x13; /* Remote User Terminated Connection */
+	dc.reason = HCI_ERROR_REMOTE_USER_TERM;
 	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.10.2

