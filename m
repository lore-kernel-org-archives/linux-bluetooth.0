Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 15/30] Bluetooth: A2MP: Process A2MP messages
Date: Thu, 15 Mar 2012 14:30:06 +0200
Message-Id: <1331814621-13905-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 net/bluetooth/a2mp.c |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1607592..b9b14e5 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -64,6 +64,64 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
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
+		a2mp_send(mgr, A2MP_COMMAND_REJ, hdr->ident, sizeof(rej),
+									&rej);
+	}
+
+	amp_mgr_put(mgr);
+
+	return err;
+}
+
 static void a2mp_chan_state_change_cb(void *data, int state, int err)
 {
 	struct l2cap_chan *chan = data;
@@ -97,6 +155,7 @@ static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
 
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
+	.recv		= a2mp_chan_recv_cb,
 	.close		= a2mp_chan_close_cb,
 	.send		= l2cap_chan_send,
 	.state_change	= a2mp_chan_state_change_cb,
-- 
1.7.9.1

