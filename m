Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] Bluetooth: Use smp->local_pk + 32 instead of &smp->local_pk[32]
Date: Mon, 16 Mar 2015 01:10:25 -0700
Message-Id: <1426493425-7427-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0fcd8c8f1a6b..f0c5c2827372 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1859,7 +1859,7 @@ static u8 sc_send_public_key(struct smp_chan *smp)
 
 done:
 	SMP_DBG("Local Public Key X: %32phN", smp->local_pk);
-	SMP_DBG("Local Public Key Y: %32phN", &smp->local_pk[32]);
+	SMP_DBG("Local Public Key Y: %32phN", smp->local_pk + 32);
 	SMP_DBG("Local Private Key:  %32phN", smp->local_sk);
 
 	smp_send_cmd(smp->conn, SMP_CMD_PUBLIC_KEY, 64, smp->local_pk);
-- 
2.1.0

