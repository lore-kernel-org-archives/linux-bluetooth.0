Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 1/3] Bluetooth: Move get info completed callback to a2mp.c
Date: Fri, 24 Jul 2015 17:10:16 +0800
Message-Id: <1437729016-16715-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid a2mp module hooks from hci_event.c and send
getinfo response operation only required by a2mp module,
we can move this callback to a2mp.c

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 net/bluetooth/a2mp.c      |   17 ++++++++++++++++-
 net/bluetooth/hci_event.c |    5 +----
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 5a04eb1..5f123c3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,7 @@
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
 
+#include "hci_request.h"
 #include "a2mp.h"
 #include "amp.h"
 
@@ -286,11 +287,21 @@ static int a2mp_change_notify(struct amp_mgr *mgr, struct sk_buff *skb,
 	return 0;
 }
 
+static void read_local_amp_info_complete(struct hci_dev *hdev, u8 status,
+					 u16 opcode)
+{
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	a2mp_send_getinfo_rsp(hdev);
+}
+
 static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 			    struct a2mp_cmd *hdr)
 {
 	struct a2mp_info_req *req  = (void *) skb->data;
 	struct hci_dev *hdev;
+	struct hci_request hreq;
+	int err = 0;
 
 	if (le16_to_cpu(hdr->len) < sizeof(*req))
 		return -EINVAL;
@@ -311,7 +322,11 @@ static int a2mp_getinfo_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	}
 
 	set_bit(READ_LOC_AMP_INFO, &mgr->state);
-	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+	hci_req_init(&hreq, hdev);
+	hci_req_add(&hreq, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+	err = hci_req_run(&hreq, read_local_amp_info_complete);
+	if (err < 0)
+		a2mp_send_getinfo_rsp(hdev);
 
 done:
 	if (hdev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..3f81cb4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -823,7 +823,7 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
 
 	if (rp->status)
-		goto a2mp_rsp;
+		return;
 
 	hdev->amp_status = rp->amp_status;
 	hdev->amp_total_bw = __le32_to_cpu(rp->total_bw);
@@ -835,9 +835,6 @@ static void hci_cc_read_local_amp_info(struct hci_dev *hdev,
 	hdev->amp_assoc_size = __le16_to_cpu(rp->max_assoc_size);
 	hdev->amp_be_flush_to = __le32_to_cpu(rp->be_flush_to);
 	hdev->amp_max_flush_to = __le32_to_cpu(rp->max_flush_to);
-
-a2mp_rsp:
-	a2mp_send_getinfo_rsp(hdev);
 }
 
 static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
-- 
1.7.9.5

