Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 05/19] Bluetooth: A2MP: Process Discover Response
Date: Thu,  6 Sep 2012 15:19:43 +0300
Message-Id: <1346933997-14369-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When receiving A2MP Discover Response send A2MP Get Info Request
for each AMP controller in the discovery list.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 27ebf31..c876997 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -67,6 +67,14 @@ void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 	kfree(cmd);
 }
 
+static u8 __next_ident(struct amp_mgr *mgr)
+{
+	if (++mgr->ident == 0)
+		mgr->ident = 1;
+
+	return mgr->ident;
+}
+
 static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
 {
 	cl->id = 0;
@@ -165,6 +173,55 @@ static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static int a2mp_discover_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
+			     struct a2mp_cmd *hdr)
+{
+	struct a2mp_discov_rsp *rsp = (void *) skb->data;
+	u16 len = le16_to_cpu(hdr->len);
+	struct a2mp_cl *cl;
+	u16 ext_feat;
+
+	if (len < sizeof(*rsp))
+		return -EINVAL;
+
+	len -= sizeof(*rsp);
+	skb_pull(skb, sizeof(*rsp));
+
+	ext_feat = le16_to_cpu(rsp->ext_feat);
+
+	BT_DBG("mtu %d efm 0x%4.4x", le16_to_cpu(rsp->mtu), ext_feat);
+
+	/* check that packet is not broken for now */
+	while (ext_feat & A2MP_FEAT_EXT) {
+		if (len < sizeof(ext_feat))
+			return -EINVAL;
+
+		ext_feat = get_unaligned_le16(skb->data);
+		BT_DBG("efm 0x%4.4x", ext_feat);
+		len -= sizeof(ext_feat);
+		skb_pull(skb, sizeof(ext_feat));
+	}
+
+	cl = (void *) skb->data;
+	while (len >= sizeof(*cl)) {
+		BT_DBG("Remote AMP id %d type %d status %d", cl->id, cl->type,
+		       cl->status);
+
+		if (cl->id != HCI_BREDR_ID && cl->type == HCI_AMP) {
+			struct a2mp_info_req req;
+
+			req.id = cl->id;
+			a2mp_send(mgr, A2MP_GETINFO_REQ, __next_ident(mgr),
+				  sizeof(req), &req);
+		}
+
+		len -= sizeof(*cl);
+		cl = (void *) skb_pull(skb, sizeof(*cl));
+	}
+
+	return 0;
+}
+
 static int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
 			      struct a2mp_cmd *hdr)
 {
@@ -381,8 +438,11 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 			err = a2mp_discphyslink_req(mgr, skb, hdr);
 			break;
 
-		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
+			err = a2mp_discover_rsp(mgr, skb, hdr);
+			break;
+
+		case A2MP_CHANGE_RSP:
 		case A2MP_GETINFO_RSP:
 		case A2MP_GETAMPASSOC_RSP:
 		case A2MP_CREATEPHYSLINK_RSP:
-- 
1.7.9.5

