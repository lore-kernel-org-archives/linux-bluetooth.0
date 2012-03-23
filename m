Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv5 18/26] Bluetooth: A2MP: Process A2MP Command Responses
Date: Fri, 23 Mar 2012 18:13:58 +0200
Message-Id: <1332519246-16656-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Process A2MP responses, print cmd code and ident for now.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index b2d0153..178832e 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -288,6 +288,15 @@ send_rsp:
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
 static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -347,6 +356,9 @@ static int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
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
1.7.9.1

