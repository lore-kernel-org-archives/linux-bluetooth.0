Return-Path: <cyrus@holtmann.org>
From: Nicholas Krause <xerofoify@gmail.com>
To: marcel@holtmann.org
Cc: gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth:Fix error checking in the function sc_dhkey_check
Date: Tue, 18 Aug 2015 21:47:55 -0400
Message-Id: <1439948875-19807-1-git-send-email-xerofoify@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error checking  in the function sc_dhkey_check by
properly checking if the internal call to the function smp_f6
has failed by returning a error code as we must return to the
caller immediately if this internal call fails as we cannot

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 net/bluetooth/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ad82324..05d9814 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1460,8 +1460,9 @@ static void sc_dhkey_check(struct smp_chan *smp)
 	if (smp->method == REQ_OOB)
 		memcpy(r, smp->rr, 16);
 
-	smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
-	       local_addr, remote_addr, check.e);
+	if (smp_f6(smp->tfm_cmac, smp->mackey, smp->prnd, smp->rrnd, r, io_cap,
+		   local_addr, remote_addr, check.e))
+		return;
 
 	smp_send_cmd(smp->conn, SMP_CMD_DHKEY_CHECK, sizeof(check), &check);
 }
-- 
2.1.4
