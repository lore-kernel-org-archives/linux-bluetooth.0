Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 19/21] Bluetooth: A2MP: Process A2MP Command Responses
Date: Thu, 10 Nov 2011 16:54:26 +0200
Message-Id: <1320936868-7978-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320936868-7978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index acb5e15..faf22ca 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -295,6 +295,15 @@ send_rsp:
 	return 0;
 }
 
+static inline int a2mp_cmd_rsp(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	BT_DBG("ident %d code %d", hdr->ident, hdr->code);
+
+	skb_pull(skb, hdr->len);
+	return 0;
+}
+
 /* Handle A2MP signalling */
 void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 {
@@ -354,6 +363,9 @@ void a2mp_receive(struct sock *sk, struct sk_buff *skb)
 		case A2MP_GETAMPASSOC_RSP:
 		case A2MP_CREATEPHYSLINK_RSP:
 		case A2MP_DISCONNPHYSLINK_RSP:
+			err = a2mp_cmd_rsp(mgr, skb, hdr);
+			break;
+
 		default:
 			BT_ERR("Unknown A2MP signaling command 0x%2.2x",
 				hdr->code);
-- 
1.7.4.1

