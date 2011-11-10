Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 14/21] Bluetooth: A2MP: Process A2MP Change Notify
Date: Thu, 10 Nov 2011 16:54:21 +0200
Message-Id: <1320936868-7978-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index e4ad28d..c69e949 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -168,6 +168,22 @@ static inline int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static inline int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_cl *cl = (struct a2mp_cl *)skb->data;
+
+	while (skb->len >= sizeof(*cl)) {
+		BT_DBG("Controller id %d type %d status %d", cl->id, cl->type,
+								cl->status);
+		cl = (struct a2mp_cl *) skb_pull(skb, sizeof(*cl));
+	}
+
+	/* TODO send A2MP_CHANGE_RSP */
+
+	return 0;
+}
+
 /* Handle A2MP signalling */
 void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 {
@@ -202,6 +218,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 			break;
 
 		case A2MP_CHANGE_NOTIFY:
+			err = a2mp_change_notify(mgr, skb, hdr);
+			break;
+
 		case A2MP_GETINFO_REQ:
 		case A2MP_GETAMPASSOC_REQ:
 		case A2MP_CREATEPHYSLINK_REQ:
-- 
1.7.4.1

