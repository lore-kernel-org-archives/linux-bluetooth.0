Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 33/34] Bluetooth: Clean sco_send_frame() flow
Date: Thu,  1 Apr 2010 17:23:51 -0300
Message-Id: <1270153432-6477-34-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-33-git-send-email-padovan@profusion.mobi>
References: <1270153432-6477-1-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-2-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-3-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-4-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-5-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-6-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-7-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-8-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-9-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-10-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-11-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-12-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-13-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-14-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-15-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-16-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-17-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-18-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-19-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-20-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-21-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-22-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-23-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-24-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-25-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-26-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-27-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-28-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-29-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-30-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-31-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-32-git-send-email-padovan@profusion.mobi>
 <1270153432-6477-33-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/sco.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 50a9af8..1dc7856 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -245,17 +245,13 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 		return err;
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
-		err = -EFAULT;
-		goto fail;
+		kfree_skb(skb);
+		return -EFAULT;
 	}
 
 	hci_send_sco(conn->hcon, skb);
 
 	return count;
-
-fail:
-	kfree_skb(skb);
-	return err;
 }
 
 static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
-- 
1.6.4.4
