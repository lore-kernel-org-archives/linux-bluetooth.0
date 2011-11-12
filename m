Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 4/5] Bluetooth: Cleanup blkcipher on SMP termination
Date: Fri, 11 Nov 2011 16:24:00 -0800
Message-Id: <1321057441-7921-5-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
References: <1321057441-7921-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/smp.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 94e94ca..3b3726a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -379,7 +379,13 @@ static struct smp_chan *smp_chan_create(struct l2cap_conn *conn)
 
 void smp_chan_destroy(struct l2cap_conn *conn)
 {
-	kfree(conn->smp_chan);
+	struct smp_chan *smp = conn->smp_chan;
+
+	if (smp && !IS_ERR(smp->tfm))
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
