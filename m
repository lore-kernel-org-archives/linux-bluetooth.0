Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: debug: Fix printing A2MP cmd code format
Date: Thu, 19 Jul 2012 17:03:41 +0300
Message-Id: <1342706627-19129-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Print A2MP code format according to Bluetooth style.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index bc28c21..179a6b6 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -316,7 +316,7 @@ send_rsp:
 static inline int a2mp_cmd_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 			       struct a2mp_cmd *hdr)
 {
-	BT_DBG("ident %d code %d", hdr->ident, hdr->code);
+	BT_DBG("ident %d code 0x%2.2x", hdr->ident, hdr->code);
 
 	skb_pull(skb, le16_to_cpu(hdr->len));
 	return 0;
@@ -335,7 +335,7 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		struct a2mp_cmd *hdr = (void *) skb->data;
 		u16 len = le16_to_cpu(hdr->len);
 
-		BT_DBG("code 0x%02x id %d len %d", hdr->code, hdr->ident, len);
+		BT_DBG("code 0x%2.2x id %d len %u", hdr->code, hdr->ident, len);
 
 		skb_pull(skb, sizeof(*hdr));
 
-- 
1.7.9.5

