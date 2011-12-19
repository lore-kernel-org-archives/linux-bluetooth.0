Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Bluetooth: Incorrect address while storing LTK.
Date: Mon, 19 Dec 2011 11:57:47 +0530
Message-ID: <1324276067-21476-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes incorrect address storage while storing
Long Term Key for LE Devices using SMP. The address stored
should be of remote device and not of source device.

Signed-off-by: Hemant Gupta <hemant.gupta@stericsson.com>
---
 net/bluetooth/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0b96737..843a52a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -637,7 +637,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->smp_key_size,
+	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->smp_key_size,
 						rp->ediv, rp->rand, smp->tk);
 
 	smp_distribute_keys(conn, 1);
-- 
1.6.6.1

