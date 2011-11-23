Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v5 3/6] Bluetooth: Cleanup blkcipher on SMP termination
Date: Wed, 23 Nov 2011 08:28:35 -0800
Message-Id: <1322065718-11570-4-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
References: <1322065718-11570-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The blkcipher must be freed to avoid memory leak.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/smp.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 94e94ca..b9af488 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -379,7 +379,15 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 void smp_chan_destroy(struct l2cap_conn *conn)
 {
-	kfree(conn->smp_chan);
+	struct smp_chan *smp = conn->smp_chan;
+
+	clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
+
+	if (smp->tfm)
+		crypto_free_blkcipher(smp->tfm);
+
+	kfree(smp);
+	conn->smp_chan = NULL;
 	hci_conn_put(conn->hcon);
 }
 
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
