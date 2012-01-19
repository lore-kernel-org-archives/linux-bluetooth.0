Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 23/34] Bluetooth: A2MP: Process A2MP Create Physlink Request
Date: Thu, 19 Jan 2012 11:20:12 +0200
Message-Id: <1326964823-26747-24-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 6996fd9..ea881a9 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -242,6 +242,22 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
+							struct a2mp_cmd *hdr)
+{
+	struct a2mp_physlink_req *req = (struct a2mp_physlink_req *)skb->data;
+
+	if (le16_to_cpu(hdr->len) < sizeof(*req))
+		return -EINVAL;
+
+	BT_DBG("local_id %d, remote_id %d", req->local_id, req->remote_id);
+
+	/* TODO process physlink create */
+
+	skb_pull(skb, hdr->len);
+	return 0;
+}
+
 /* Handle A2MP signalling */
 int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 {
@@ -286,6 +302,9 @@ int a2mp_chan_recv_cb(void *data, struct sk_buff *skb)
 			break;
 
 		case A2MP_CREATEPHYSLINK_REQ:
+			err = a2mp_createphyslink_req(mgr, skb, hdr);
+			break;
+
 		case A2MP_DISCONNPHYSLINK_REQ:
 		case A2MP_CHANGE_RSP:
 		case A2MP_DISCOVER_RSP:
-- 
1.7.4.1

