Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, jprvita@profusion.mobi
Subject: [PATCH 34/34] Bluetooth: Remove unneeded check for MTU on sco_send_frame()
Date: Thu,  1 Apr 2010 17:23:52 -0300
Message-Id: <1270153432-6477-35-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1270153432-6477-34-git-send-email-padovan@profusion.mobi>
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
 <1270153432-6477-34-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

We have

count = min_t(unsigned int, conn->mtu, len);

there, so no need to return on len > conn->mtu.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
Reviewed-by: João Paulo Rechi Vita <jprvita@profusion.mobi>
---
 net/bluetooth/sco.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1dc7856..e2da719 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -234,10 +234,6 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 	struct sk_buff *skb;
 	int err, count;
 
-	/* Check outgoing MTU */
-	if (len > conn->mtu)
-		return -EINVAL;
-
 	BT_DBG("sk %p len %d", sk, len);
 
 	count = min_t(unsigned int, conn->mtu, len);
-- 
1.6.4.4
