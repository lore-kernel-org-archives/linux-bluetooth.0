Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 16/34] Bluetooth: A2MP: Process A2MP messages
Date: Thu, 19 Jan 2012 11:20:05 +0200
Message-Id: <1326964823-26747-17-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 net/bluetooth/a2mp.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 2755e7e..2ca7820 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -64,6 +64,63 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+/* Handle A2MP signalling */
+int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
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
+			BT_ERR("Unknown A2MP signaling command 0x%2.2x",
+								hdr->code);
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
 static void a2mp_chan_state_change_cb(void *data, int state)
 {
 	struct l2cap_chan *chan = data;
@@ -91,6 +148,7 @@ static void a2mp_chan_close_cb(void *data)
 
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
+	.recv		= a2mp_chan_recv_cb,
 	.close		= a2mp_chan_close_cb,
 	.send		= l2cap_chan_send,
 	.state_change	= a2mp_chan_state_change_cb,
-- 
1.7.4.1

