Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 15/17] Bluetooth: A2MP: Process A2MP Command Responses
Date: Tue, 29 May 2012 13:59:15 +0300
Message-Id: <1338289158-25655-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Process A2MP responses, print cmd code and ident for now.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 0d3e0d9..1076ce3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -313,6 +313,15 @@ send_rsp:
 	return 0;
 }
 
+static inline int a2mp_cmd_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
+			       struct a2mp_cmd *hdr)
+{
+	BT_DBG("ident %d code %d", hdr->ident, hdr->code);
+
+	skb_pull(skb, le16_to_cpu(hdr->len));
+	return 0;
+}
+
 /* Handle A2MP signalling */
 static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
@@ -372,6 +381,9 @@ static int a2mp_chan_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 		case A2MP_GETAMPASSOC_RSP:
 		case A2MP_CREATEPHYSLINK_RSP:
 		case A2MP_DISCONNPHYSLINK_RSP:
+			err = a2mp_cmd_rsp(mgr, skb, hdr);
+			break;
+
 		default:
 			BT_ERR("Unknown A2MP sig cmd 0x%2.2x", hdr->code);
 			err = -EINVAL;
-- 
1.7.9.5

