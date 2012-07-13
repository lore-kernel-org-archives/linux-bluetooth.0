Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 02/20] Bluetooth: Do not shadow hdr variable
Date: Fri, 13 Jul 2012 16:39:04 +0300
Message-Id: <1342186762-32329-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342186762-32329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1342186762-32329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fix compile warnings below:

...
net/bluetooth/a2mp.c:505:33: warning: symbol 'hdr' shadows an earlier one
net/bluetooth/a2mp.c:498:25: originally declared here
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index bc28c21..1133890 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -325,15 +325,17 @@ static inline int a2mp_cmd_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
 /* Handle A2MP signalling */
 static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct a2mp_cmd *hdr = (void *) skb->data;
+	struct a2mp_cmd *hdr;
 	struct amp_mgr *mgr = chan->data;
 	int err = 0;
 
 	amp_mgr_get(mgr);
 
 	while (skb->len >= sizeof(*hdr)) {
-		struct a2mp_cmd *hdr = (void *) skb->data;
-		u16 len = le16_to_cpu(hdr->len);
+		u16 len;
+
+		hdr = (void *) skb->data;
+		len = le16_to_cpu(hdr->len);
 
 		BT_DBG("code 0x%02x id %d len %d", hdr->code, hdr->ident, len);
 
@@ -393,7 +395,9 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	if (err) {
 		struct a2mp_cmd_rej rej;
+
 		rej.reason = __constant_cpu_to_le16(0);
+		hdr = (void *) skb->data;
 
 		BT_DBG("Send A2MP Rej: cmd 0x%2.2x err %d", hdr->code, err);
 
-- 
1.7.9.5

