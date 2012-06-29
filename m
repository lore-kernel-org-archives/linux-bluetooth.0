Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 13/19] Bluetooth: A2MP: Process A2MP Getinfo Rsp
Date: Fri, 29 Jun 2012 17:46:46 +0300
Message-Id: <1340981212-21709-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Process A2MP Getinfo Response, send Get AMP Assoc Req.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index ee3ebe8..4cfc80f 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -269,6 +269,35 @@ done:
 	return 0;
 }
 
+static int a2mp_getinfo_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
+			    struct a2mp_cmd *hdr)
+{
+	struct a2mp_info_rsp *rsp = (struct a2mp_info_rsp *) skb->data;
+	struct a2mp_amp_assoc_req req;
+	struct amp_ctrl *ctrl;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*rsp))
+		return -EINVAL;
+
+	BT_DBG("id %d status %d", rsp->id, rsp->status);
+
+	if (rsp->status)
+		return -EINVAL;
+
+	ctrl = amp_ctrl_add(mgr);
+	if (!ctrl)
+		return -ENOMEM;
+
+	ctrl->id = rsp->id;
+
+	req.id = rsp->id;
+	a2mp_send(mgr, A2MP_GETAMPASSOC_REQ, __next_ident(mgr), sizeof(req),
+		  &req);
+
+	skb_pull(skb, sizeof(*rsp));
+	return 0;
+}
+
 static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 				struct a2mp_cmd *hdr)
 {
@@ -458,8 +487,11 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 			err = a2mp_discover_rsp(mgr, skb, hdr);
 			break;
 
-		case A2MP_CHANGE_RSP:
 		case A2MP_GETINFO_RSP:
+			err = a2mp_getinfo_rsp(mgr, skb, hdr);
+			break;
+
+		case A2MP_CHANGE_RSP:
 		case A2MP_GETAMPASSOC_RSP:
 		case A2MP_CREATEPHYSLINK_RSP:
 		case A2MP_DISCONNPHYSLINK_RSP:
-- 
1.7.9.5

