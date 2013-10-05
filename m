Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] Bluetooth: Separate AMP controller type from HCI device type
Date: Sat,  5 Oct 2013 11:47:43 -0700
Message-Id: <1380998869-64411-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are two defined HCI device types. One is for BR/EDR controllers
and the other is for AMP controllers. The HCI device type is not the
same as the AMP controller type. It just happens that currently the
defined types match, but that is not guaranteed.

Split the usage of AMP controller type into its own domain so that
it is possible to separate between BR/EDR controllers, 802.11 AMP
controllers and any other AMP technology that might be defined in
the future.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/a2mp.c             | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab52dc7..86e2dbe 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -805,7 +805,7 @@ static inline bool hci_amp_capable(void)
 
 	read_lock(&hci_dev_list_lock);
 	list_for_each_entry(hdev, &hci_dev_list, list)
-		if (hdev->amp_type == HCI_AMP &&
+		if (hdev->amp_type != AMP_TYPE_BREDR &&
 		    test_bit(HCI_UP, &hdev->flags))
 			ret = true;
 	read_unlock(&hci_dev_list_lock);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index a6e45e1..b2ef3d3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -78,7 +78,7 @@ u8 __next_ident(struct amp_mgr *mgr)
 static inline void __a2mp_cl_bredr(struct a2mp_cl *cl)
 {
 	cl->id = 0;
-	cl->type = 0;
+	cl->type = AMP_TYPE_BREDR;
 	cl->status = 1;
 }
 
@@ -352,7 +352,7 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	tmp = amp_mgr_lookup_by_state(READ_LOC_AMP_ASSOC);
 
 	hdev = hci_dev_get(req->id);
-	if (!hdev || hdev->amp_type == HCI_BREDR || tmp) {
+	if (!hdev || hdev->amp_type == AMP_TYPE_BREDR || tmp) {
 		struct a2mp_amp_assoc_rsp rsp;
 		rsp.id = req->id;
 
@@ -459,7 +459,7 @@ static int a2mp_createphyslink_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	rsp.remote_id = req->local_id;
 
 	hdev = hci_dev_get(req->remote_id);
-	if (!hdev || hdev->amp_type != HCI_AMP) {
+	if (!hdev || hdev->amp_type == AMP_TYPE_BREDR) {
 		rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 		goto send_rsp;
 	}
@@ -879,7 +879,7 @@ void a2mp_send_getinfo_rsp(struct hci_dev *hdev)
 	rsp.id = hdev->id;
 	rsp.status = A2MP_STATUS_INVALID_CTRL_ID;
 
-	if (hdev->amp_type != HCI_BREDR) {
+	if (hdev->amp_type != AMP_TYPE_BREDR) {
 		rsp.status = 0;
 		rsp.total_bw = cpu_to_le32(hdev->amp_total_bw);
 		rsp.max_bw = cpu_to_le32(hdev->amp_max_bw);
-- 
1.8.3.1

