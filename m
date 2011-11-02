Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 10/20] Bluetooth: A2MP: processing A2MP command reject
Date: Wed,  2 Nov 2011 16:02:38 +0200
Message-Id: <1320242568-372-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5071acc..996a9dc 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -71,6 +71,22 @@ static void a2mp_send(struct socket *a2mp_sock, u8 code, u8 ident, u16 len,
 	kfree(cmd);
 }
 
+/* Processing A2MP messages */
+static inline int a2mp_command_rej(struct amp_mgr *mgr, struct sk_buff *skb,
+						struct a2mp_cmd *hdr)
+{
+	struct a2mp_cmd_rej *rej = (struct a2mp_cmd_rej *)skb->data;
+
+	if (skb->len < sizeof(*rej))
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
 void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 {
@@ -97,6 +113,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 
 		switch (hdr->code) {
 		case A2MP_COMMAND_REJ:
+			a2mp_command_rej(mgr, skb, hdr);
+			break;
+
 		case A2MP_DISCOVER_REQ:
 		case A2MP_CHANGE_NOTIFY:
 		case A2MP_GETINFO_REQ:
-- 
1.7.4.1

