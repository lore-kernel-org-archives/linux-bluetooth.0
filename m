Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 12/19] Bluetooth: AMP: Use phylink in create/disc phylink req
Date: Fri, 29 Jun 2012 17:46:45 +0300
Message-Id: <1340981212-21709-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use phy_link structure to keep track about physical connections.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d52a843..ee3ebe8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -309,6 +309,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct phy_link *plink;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -326,6 +327,12 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	/* TODO process physlink create */
 
+	plink = hci_phylink_add(mgr, rsp.local_id, rsp.remote_id,
+				req->amp_assoc,
+				le16_to_cpu(hdr->len) - sizeof(*req));
+
+	BT_DBG("plink %p", plink);
+
 	rsp.status = A2MP_STATUS_SUCCESS;
 
 send_rsp:
@@ -345,6 +352,7 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_physlink_req *req = (void *) skb->data;
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct phy_link *plink;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -361,8 +369,18 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		goto send_rsp;
 	}
 
+	plink = hci_phylink_lookup(mgr, rsp.local_id, rsp.remote_id);
+	if (!plink) {
+		BT_ERR("No phys link exist");
+		rsp.status = A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS;
+		goto clean;
+	}
+
 	/* TODO Disconnect Phys Link here */
 
+	phylink_put(plink);
+
+clean:
 	hci_dev_put(hdev);
 
 send_rsp:
-- 
1.7.9.5

