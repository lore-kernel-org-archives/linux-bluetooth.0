Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix updating SMP remote key distribution information
Date: Fri, 14 Mar 2014 10:53:49 +0200
Message-Id: <1394787230-26475-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When performing pairing using SMP the remote may clear any key
distribution bits it wants in its pairing response. We must therefore
update our local variable accordingly, otherwise we might get stuck
waiting for keys that will never come.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 74a17cf91b26..8a1b1bf79555 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -748,6 +748,11 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	smp->prsp[0] = SMP_CMD_PAIRING_RSP;
 	memcpy(&smp->prsp[1], rsp, sizeof(*rsp));
 
+	/* Update remote key distribution in case the remote cleared
+	 * some bits that we had enabled in our request.
+	 */
+	smp->remote_key_dist &= rsp->resp_key_dist;
+
 	if ((req->auth_req & SMP_AUTH_BONDING) &&
 	    (rsp->auth_req & SMP_AUTH_BONDING))
 		auth = SMP_AUTH_BONDING;
-- 
1.8.5.3

