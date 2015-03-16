Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use smp->remote_pk + 32 instead of &smp->remote_pk[32]
Date: Mon, 16 Mar 2015 09:34:10 -0700
Message-Id: <1426523650-3554-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 82824213d0fb..4c423bb4b043 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2535,7 +2535,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	}
 
 	SMP_DBG("Remote Public Key X: %32phN", smp->remote_pk);
-	SMP_DBG("Remote Public Key Y: %32phN", &smp->remote_pk[32]);
+	SMP_DBG("Remote Public Key Y: %32phN", smp->remote_pk + 32);
 
 	if (!ecdh_shared_secret(smp->remote_pk, smp->local_sk, smp->dhkey))
 		return SMP_UNSPECIFIED;
-- 
2.1.0

