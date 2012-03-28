Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 13/26] Bluetooth: A2MP: Process A2MP Change Notify
Date: Wed, 28 Mar 2012 16:31:36 +0300
Message-Id: <1332941509-21345-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Placeholder for A2MP Change Notify handler.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 1ec2fc8..d8a74a8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -162,6 +162,22 @@ static inline int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static inline int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
+				     struct a2mp_cmd *hdr)
+{
+	struct a2mp_cl *cl = (struct a2mp_cl *) skb->data;
+
+	while (skb->len >= sizeof(*cl)) {
+		BT_DBG("Controller id %d type %d status %d", cl->id, cl->type,
+		       cl->status);
+		cl = (struct a2mp_cl *) skb_pull(skb, sizeof(*cl));
+	}
+
+	/* TODO send A2MP_CHANGE_RSP */
+
+	return 0;
+}
+
 /* Handle A2MP signalling */
 static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -196,6 +212,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 			break;
 
 		case A2MP_CHANGE_NOTIFY:
+			err = a2mp_change_notify(mgr, skb, hdr);
+			break;
+
 		case A2MP_GETINFO_REQ:
 		case A2MP_GETAMPASSOC_REQ:
 		case A2MP_CREATEPHYSLINK_REQ:
-- 
1.7.9.1

