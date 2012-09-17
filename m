Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv5 08/17] Bluetooth: AMP: Handle create / disc phylink req
Date: Mon, 17 Sep 2012 16:24:25 +0300
Message-Id: <1347888274-30779-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use hci_conn structure to keep track about AMP physical connections.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index dc5c01b..df50c4d 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -322,6 +322,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct hci_conn *hcon;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -339,7 +340,14 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	/* TODO process physlink create */
 
-	rsp.status = A2MP_STATUS_SUCCESS;
+	hcon = phylink_add(hdev, mgr, req->local_id);
+	if (hcon) {
+		BT_DBG("hcon %p", hcon);
+
+		rsp.status = A2MP_STATUS_SUCCESS;
+	} else {
+		rsp.status = A2MP_STATUS_UNABLE_START_LINK_CREATION;
+	}
 
 send_rsp:
 	if (hdev)
@@ -358,6 +366,7 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_physlink_req *req = (void *) skb->data;
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct hci_conn *hcon;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -368,14 +377,22 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	rsp.remote_id = req->local_id;
 	rsp.status = A2MP_STATUS_SUCCESS;
 
-	hdev = hci_dev_get(req->local_id);
+	hdev = hci_dev_get(req->remote_id);
 	if (!hdev) {
 		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 		goto send_rsp;
 	}
 
+	hcon = hci_conn_hash_lookup_ba(hdev, AMP_LINK, mgr->l2cap_conn->dst);
+	if (!hcon) {
+		BT_ERR("No phys link exist");
+		rsp.status = A2MP_STATUS_NO_PHYSICAL_LINK_EXISTS;
+		goto clean;
+	}
+
 	/* TODO Disconnect Phys Link here */
 
+clean:
 	hci_dev_put(hdev);
 
 send_rsp:
-- 
1.7.9.5

