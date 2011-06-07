Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [bluetooth-next 13/13] Bluetooth: Add support for random destination address
Date: Tue,  7 Jun 2011 19:50:14 -0300
Message-Id: <1307487014-19398-14-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307487014-19398-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Lizardo <anderson.lizardo@openbossa.org>

For source address, only public address type is supported for now.

Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
---
 net/bluetooth/smp.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index b8774a7..9abcc6a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -306,7 +306,7 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 		return SMP_UNSPECIFIED;
 
 	ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp, 0,
-			conn->src, 0, conn->dst, res);
+			conn->src, conn->hcon->dst_type, conn->dst, res);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
@@ -342,7 +342,8 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 			return SMP_UNSPECIFIED;
 
 		ret = smp_c1(tfm, conn->tk, conn->prnd, conn->preq, conn->prsp,
-					0, conn->dst, 0, conn->src, res);
+						conn->hcon->dst_type, conn->dst,
+						0, conn->src, res);
 		if (ret)
 			return SMP_CONFIRM_FAILED;
 
@@ -369,10 +370,12 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	if (conn->hcon->out)
 		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
-				conn->src, 0, conn->dst, res);
+				conn->src, conn->hcon->dst_type, conn->dst,
+				res);
 	else
-		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
-				conn->dst, 0, conn->src, res);
+		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp,
+				conn->hcon->dst_type, conn->dst, 0, conn->src,
+				res);
 	if (ret)
 		return SMP_UNSPECIFIED;
 
-- 
1.7.5.4

