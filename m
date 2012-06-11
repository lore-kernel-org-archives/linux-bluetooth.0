Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove magic value in disconnect mgmt handler
Date: Mon, 11 Jun 2012 18:41:12 -0300
Message-Id: <1339450872-28438-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces the magic value of variable 'reason' by the
proper macro.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 958f764..38bb7d5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1611,7 +1611,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 	dc.handle = cpu_to_le16(conn->handle);
-	dc.reason = 0x13; /* Remote User Terminated Connection */
+	dc.reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
 	if (err < 0)
-- 
1.7.10.3

