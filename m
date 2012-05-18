Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 07/17] Bluetooth: A2MP: Process A2MP messages
Date: Fri, 18 May 2012 17:25:40 +0300
Message-Id: <1337351150-20526-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implement basic processing for AMP Manager Protocol (A2MP).

Example below shows processing unrecognized command.
...
> ACL data: handle 11 flags 0x02 dlen 12
    A2MP: code 0x00 ident 3 len 0
< ACL data: handle 11 flags 0x00 dlen 14
    A2MP: Command Reject: reason (0) - Command not recognized
...

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   65 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 67a7ad4..8a2dfbf 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -63,6 +63,70 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+/* Handle A2MP signalling */
+static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
+{
+	struct a2mp_cmd *hdr = (struct a2mp_cmd *) skb->data;
+	struct amp_mgr *mgr = data;
+	int err = 0;
+
+	amp_mgr_get(mgr);
+
+	while (skb->len >= sizeof(*hdr)) {
+		struct a2mp_cmd *hdr = (struct a2mp_cmd *) skb->data;
+		u16 len = le16_to_cpu(hdr->len);
+
+		BT_DBG("code 0x%02x id %d len %d", hdr->code, hdr->ident, len);
+
+		skb_pull(skb, sizeof(*hdr));
+
+		if (len > skb->len || !hdr->ident) {
+			err = -EINVAL;
+			break;
+		}
+
+		mgr->ident = hdr->ident;
+
+		switch (hdr->code) {
+		case A2MP_COMMAND_REJ:
+		case A2MP_DISCOVER_REQ:
+		case A2MP_CHANGE_NOTIFY:
+		case A2MP_GETINFO_REQ:
+		case A2MP_GETAMPASSOC_REQ:
+		case A2MP_CREATEPHYSLINK_REQ:
+		case A2MP_DISCONNPHYSLINK_REQ:
+		case A2MP_CHANGE_RSP:
+		case A2MP_DISCOVER_RSP:
+		case A2MP_GETINFO_RSP:
+		case A2MP_GETAMPASSOC_RSP:
+		case A2MP_CREATEPHYSLINK_RSP:
+		case A2MP_DISCONNPHYSLINK_RSP:
+		default:
+			BT_ERR("Unknown A2MP sig cmd 0x%2.2x", hdr->code);
+			err = -EINVAL;
+			break;
+		}
+	}
+
+	if (err) {
+		struct a2mp_cmd_rej rej;
+		rej.reason = cpu_to_le16(0);
+
+		BT_DBG("Send A2MP Rej: cmd 0x%2.2x err %d", hdr->code, err);
+
+		a2mp_send(mgr, A2MP_COMMAND_REJ, hdr->ident, sizeof(rej),
+			  &rej);
+	}
+
+	/* Always free skb and return success error code to prevent
+	   from sending L2CAP Disconnect over A2MP channel */
+	kfree_skb(skb);
+
+	amp_mgr_put(mgr);
+
+	return 0;
+}
+
 static void a2mp_chan_state_change_cb(void *data, int state)
 {
 	struct amp_mgr *mgr = data;
@@ -100,6 +164,7 @@ static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
 
 static struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
+	.recv = a2mp_chan_recv_cb,
 	.state_change = a2mp_chan_state_change_cb,
 	.close = a2mp_chan_close_cb,
 	.alloc_skb = a2mp_chan_alloc_skb_cb,
-- 
1.7.9.5

