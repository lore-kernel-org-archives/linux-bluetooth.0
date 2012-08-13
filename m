Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 08/20] Bluetooth: AMP: Use phylink in create/disc phylink req
Date: Mon, 13 Aug 2012 16:50:26 +0300
Message-Id: <1344865838-9165-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1344865838-9165-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1344865838-9165-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use phy_link structure to keep track about physical connections.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/pal.h |    1 +
 net/bluetooth/a2mp.c        |   19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/bluetooth/pal.h b/include/net/bluetooth/pal.h
index 3223ec2..6ce1dfb 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -52,5 +52,6 @@ struct phy_link *phylink_lookup(struct amp_mgr *mgr, u8 local_id, u8 remote_id);
 int phylink_put(struct phy_link *plink);
 void phylink_get(struct phy_link *plink);
 void phylink_list_flush(struct amp_mgr *mgr);
+void phylink_del(struct amp_mgr *mgr, struct phy_link *plink);
 
 #endif /* __PAL_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index f35d90f..3a0e3b8 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -309,6 +309,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct phy_link *plink;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -326,6 +327,11 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	/* TODO process physlink create */
 
+	plink = phylink_add(mgr, rsp.local_id, rsp.remote_id, req->amp_assoc,
+			    le16_to_cpu(hdr->len) - sizeof(*req));
+
+	BT_DBG("plink %p", plink);
+
 	rsp.status = A2MP_STATUS_SUCCESS;
 
 send_rsp:
@@ -345,6 +351,7 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_physlink_req *req = (void *) skb->data;
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct phy_link *plink;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -361,8 +368,20 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 		goto send_rsp;
 	}
 
+	plink = phylink_lookup(mgr, rsp.local_id, rsp.remote_id);
+	if (!plink) {
+		BT_ERR("No phys link exist");
+		rsp.status = A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS;
+		goto clean;
+	}
+
 	/* TODO Disconnect Phys Link here */
 
+	phylink_put(plink);
+
+	phylink_del(mgr, plink);
+
+clean:
 	hci_dev_put(hdev);
 
 send_rsp:
-- 
1.7.9.5

