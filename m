Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 08/19] Bluetooth: AMP: Handle create / disc phylink req
Date: Thu,  6 Sep 2012 15:19:46 +0300
Message-Id: <1346933997-14369-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use hci_conn structure to keep track about AMP physical connections.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/a2mp.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 36bf0f4..8c6cda4 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -312,6 +312,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct hci_conn *hcon;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -329,7 +330,14 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
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
@@ -348,6 +356,7 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	struct a2mp_physlink_req *req = (void *) skb->data;
 	struct a2mp_physlink_rsp rsp;
 	struct hci_dev *hdev;
+	struct hci_conn *hcon;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -358,14 +367,22 @@ static int a2mp_discphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	rsp.remote_id = req->local_id;
 	rsp.status = A2MP_STATUS_SUCCESS;
 
-	hdev = hci_dev_get(req->local_id);
+	hdev = hci_dev_get(req->remote_id);
 	if (!hdev) {
 		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 		goto send_rsp;
 	}
 
+	hcon = hci_conn_hash_lookup_id(hdev, rsp.local_id);
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

