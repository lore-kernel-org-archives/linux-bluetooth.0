Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 08/23] Bluetooth: A2MP: Process A2MP Command Reject
Date: Fri, 20 Apr 2012 14:09:36 +0300
Message-Id: <1334920191-29308-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Placeholder for future A2MP Command Reject handler.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index e3b91cd..4f3e6f9 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -63,6 +63,22 @@ static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+/* Processing A2MP messages */
+static int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
+			    struct a2mp_cmd *hdr)
+{
+	struct a2mp_cmd_rej *rej = (struct a2mp_cmd_rej *) skb->data;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*rej))
+		return -EINVAL;
+
+	BT_DBG("ident %d reason %d", hdr->ident, le16_to_cpu(rej->reason));
+
+	skb_pull(skb, sizeof(*rej));
+
+	return 0;
+}
+
 /* Handle A2MP signalling */
 static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -89,6 +105,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 
 		switch (hdr->code) {
 		case A2MP_COMMAND_REJ:
+			a2mp_command_rej(mgr, skb, hdr);
+			break;
+
 		case A2MP_DISCOVER_REQ:
 		case A2MP_CHANGE_NOTIFY:
 		case A2MP_GETINFO_REQ:
-- 
1.7.9.5

