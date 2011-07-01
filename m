Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 09/12] Bluetooth: Remove unused field in hci_conn
Date: Fri,  1 Jul 2011 16:07:44 -0300
Message-Id: <1309547267-9514-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 -
 net/bluetooth/smp.c              |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 751104a..308a9f7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -265,7 +265,6 @@ struct hci_conn {
 	__u8		power_save;
 	__u16		disc_timeout;
 	unsigned long	pend;
-	__u8		ltk[16];
 
 	__u8		remote_cap;
 	__u8		remote_oob;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 191aaec..d9fffbd 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -367,8 +367,6 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	swap128(skb->data, random);
 	skb_pull(skb, sizeof(random));
 
-	memset(hcon->ltk, 0, sizeof(hcon->ltk));
-
 	if (conn->hcon->out)
 		ret = smp_c1(tfm, conn->tk, random, conn->preq, conn->prsp, 0,
 				conn->src, conn->hcon->dst_type, conn->dst,
-- 
1.7.6

