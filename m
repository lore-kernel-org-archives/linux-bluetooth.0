Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 11/22] Bluetooth: AMP: Use phylink in create/disc phylink req
Date: Fri, 24 Aug 2012 17:00:10 +0300
Message-Id: <1345816821-32331-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1345816821-32331-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
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
index f99994a..4a5eeed 100644
--- a/include/net/bluetooth/pal.h
+++ b/include/net/bluetooth/pal.h
@@ -53,5 +53,6 @@ struct phy_link *phylink_lookup_by_handle(u8 handle);
 int phylink_put(struct phy_link *plink);
 void phylink_get(struct phy_link *plink);
 void phylink_list_flush(struct amp_mgr *mgr);
+void phylink_del(struct amp_mgr *mgr, struct phy_link *plink);
 
 #endif /* __PAL_H */
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 40147e6..d1f6864 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -312,6 +312,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct phy_link *plink;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -329,6 +330,11 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	/* TODO process physlink create */
 
+	plink = phylink_add(mgr, rsp.local_id, rsp.remote_id, req->amp_assoc,
+			    le16_to_cpu(hdr->len) - sizeof(*req));
+
+	BT_DBG("plink %p", plink);
+
 	rsp.status = A2MP_STATUS_SUCCESS;
 
 send_rsp:
@@ -348,6 +354,7 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_physlink_req *req = (void *) skb->data;
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct phy_link *plink;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -364,8 +371,20 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
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

