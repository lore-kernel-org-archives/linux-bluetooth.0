Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove two else branches that are not needed
Date: Wed, 11 Mar 2015 17:47:40 -0700
Message-Id: <1426121260-32743-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SMP code contains two else branches that are not needed since the
successful test will actually leave the function.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c91c19bfc0a8..d6ef7e48c2c3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1743,10 +1743,10 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp->remote_key_dist &= ~SMP_SC_NO_DIST;
 		/* Wait for Public Key from Initiating Device */
 		return 0;
-	} else {
-		SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
 	}
 
+	SMP_ALLOW_CMD(smp, SMP_CMD_PAIRING_CONFIRM);
+
 	/* Request setup of TK */
 	ret = tk_request(conn, 0, auth, rsp.io_capability, req->io_capability);
 	if (ret)
@@ -1926,8 +1926,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (test_bit(SMP_FLAG_TK_VALID, &smp->flags))
 		return smp_confirm(smp);
-	else
-		set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
+
+	set_bit(SMP_FLAG_CFM_PENDING, &smp->flags);
 
 	return 0;
 }
-- 
2.1.0

