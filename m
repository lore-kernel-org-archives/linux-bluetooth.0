Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Check for force_lesc_support before rejecting SMP over BR/EDR
Date: Sun,  7 Dec 2014 16:19:12 +0100
Message-Id: <1417965552-128069-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SMP over BR/EDR requests for cross-transport pairing should also
accepted when the debugfs setting force_lesc_support has been enabled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 96bf16dcd9e9..3e174f94a46b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1674,7 +1674,8 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	/* SMP over BR/EDR requires special treatment */
 	if (conn->hcon->type == ACL_LINK) {
 		/* We must have a BR/EDR SC link */
-		if (!test_bit(HCI_CONN_AES_CCM, &conn->hcon->flags))
+		if (!test_bit(HCI_CONN_AES_CCM, &conn->hcon->flags) &&
+		    !test_bit(HCI_FORCE_LESC, &hdev->dbg_flags))
 			return SMP_CROSS_TRANSP_NOT_ALLOWED;
 
 		set_bit(SMP_FLAG_SC, &smp->flags);
-- 
1.9.3

