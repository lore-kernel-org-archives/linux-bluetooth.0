Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 10/21] Bluetooth: A2MP: Process A2MP messages
Date: Thu, 10 Nov 2011 16:54:17 +0200
Message-Id: <1320936868-7978-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
 net/bluetooth/a2mp.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6ffdd12..4e45897 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -75,6 +75,63 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+/* Handle A2MP signalling */
+void a2mp_receive(struct sock *sk, struct sk_buff *skb)
+{
+	struct a2mp_cmd *hdr = (struct a2mp_cmd *) skb->data;
+	struct amp_mgr *mgr;
+	int err = 0;
+
+	mgr = get_amp_mgr_sk(sk);
+	if (!mgr)
+		return;
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
+				hdr->code);
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
+}
+
 static void data_ready_worker(struct work_struct *w)
 {
 	struct a2mp_work_data_ready *work = (struct a2mp_work_data_ready *) w;
@@ -85,7 +142,7 @@ static void data_ready_worker(struct work_struct *w)
 
 	/* skb_dequeue() is thread-safe */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
-		/* process a2mp here */
+		a2mp_receive(sk, skb);
 		kfree_skb(skb);
 	}
 
-- 
1.7.4.1

