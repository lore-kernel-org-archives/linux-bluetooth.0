Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 08/19] Bluetooth: AMP: Use HCI callback to Read Loc AMP Assoc
Date: Fri, 29 Jun 2012 17:46:41 +0300
Message-Id: <1340981212-21709-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds reading Local AMP Assoc in HCI callback

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |    1 +
 include/net/bluetooth/amp.h      |    2 ++
 include/net/bluetooth/hci.h      |    2 ++
 include/net/bluetooth/hci_core.h |    8 ++++++
 net/bluetooth/a2mp.c             |   16 +++++------
 net/bluetooth/amp.c              |   59 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   41 ++++++++++++++++++++++++++
 7 files changed, 121 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6a76e0a..ec77ddc 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -122,5 +122,6 @@ void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
 
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index ec7bea7..e861675 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -15,5 +15,7 @@
 #define __AMP_H
 
 void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
 
 #endif /* __AMP_H */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7f19556..2b19703 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -33,6 +33,8 @@
 #define HCI_LINK_KEY_SIZE	16
 #define HCI_AMP_LINK_KEY_SIZE	(2 * HCI_LINK_KEY_SIZE)
 
+#define HCI_MAX_AMP_ASSOC_SIZE	672
+
 /* HCI dev events */
 #define HCI_DEV_REG			1
 #define HCI_DEV_UNREG			2
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d52e86b..fb0b4e4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -141,6 +141,12 @@ struct hci_cb_cmd {
 	void (*destructor)(struct hci_dev *hdev, struct hci_cb_cmd *cmd);
 };
 
+struct amp_assoc {
+	__u16	len;
+	__u16	offset;
+	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
+};
+
 #define NUM_REASSEMBLY 4
 struct hci_dev {
 	struct list_head list;
@@ -194,6 +200,8 @@ struct hci_dev {
 	__u32		amp_max_flush_to;
 	__u32		amp_be_flush_to;
 
+	struct amp_assoc	loc_assoc;
+
 	__u8		flow_ctl_mode;
 
 	unsigned int	auto_accept_delay;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index f11feb0..31545d4 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -38,8 +38,7 @@ static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
 	return cmd;
 }
 
-static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
-		      void *data)
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 {
 	struct l2cap_chan *chan = mgr->a2mp_chan;
 	struct a2mp_cmd *cmd;
@@ -231,15 +230,16 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 
 		a2mp_send(mgr, A2MP_GETAMPASSOC_RSP, hdr->ident, sizeof(rsp),
 			  &rsp);
-		goto clean;
-	}
 
-	/* Placeholder for HCI Read AMP Assoc */
+		if (hdev)
+			hci_dev_put(hdev);
 
-clean:
-	if (hdev)
-		hci_dev_put(hdev);
+		goto done;
+	}
+
+	amp_read_loc_assoc(hdev, mgr);
 
+done:
 	skb_pull(skb, sizeof(*req));
 	return 0;
 }
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 4aea7be..ebe1fd7 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -61,3 +61,62 @@ void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr)
 	hci_cmd_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL,
 		   amp_read_loc_info_complete, mgr, cb_destructor, GFP_KERNEL);
 }
+
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+
+	BT_DBG("%s: handle %d", hdev->name, phy_handle);
+
+	cp.phy_handle = phy_handle;
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+	cp.len_so_far = cpu_to_le16(loc_assoc->offset);
+
+	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp);
+}
+
+static void amp_read_loc_assoc_complete(struct hci_dev *hdev,
+					struct hci_cb_cmd *cmd)
+{
+	struct amp_mgr *mgr = cmd->opt;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+	struct a2mp_amp_assoc_rsp *rsp;
+	size_t len;
+
+	BT_DBG("%s: cmd %p", hdev->name, cmd);
+
+	len = sizeof(struct a2mp_amp_assoc_rsp) + loc_assoc->len;
+	rsp = kzalloc(len, GFP_KERNEL);
+	if (!rsp)
+		return;
+
+	rsp->id = hdev->id;
+
+	if (cmd->status) {
+		rsp->status = A2MP_STATUS_INVALID_CTRL_ID;
+		goto send;
+	}
+
+	rsp->status = A2MP_STATUS_SUCCESS;
+	memcpy(rsp->amp_assoc, loc_assoc->data, loc_assoc->len);
+
+send:
+	a2mp_send(mgr, A2MP_GETAMPASSOC_RSP, mgr->ident, len, rsp);
+	kfree(rsp);
+}
+
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+
+	memset(&hdev->loc_assoc, 0, sizeof(struct amp_assoc));
+	memset(&cp, 0, sizeof(cp));
+
+	cp.max_len = cpu_to_le16(hdev->amp_assoc_size);
+
+	amp_mgr_get(mgr);
+
+	hci_cmd_cb(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, sizeof(cp), &cp,
+		amp_read_loc_assoc_complete, mgr, cb_destructor, GFP_KERNEL);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9b34417..cbf4983 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 /* Handle HCI Event packets */
 
@@ -865,6 +866,42 @@ process_cb:
 	hci_process_cb(hdev, HCI_OP_READ_LOCAL_AMP_INFO, rp->status);
 }
 
+static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_assoc *rp = (void *)skb->data;
+	struct amp_assoc *assoc = &hdev->loc_assoc;
+	size_t rem_len, frag_len;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		goto process_cb;
+
+	frag_len = skb->len - sizeof(*rp);
+	rem_len = __le16_to_cpu(rp->rem_len);
+
+	if (rem_len > frag_len) {
+		BT_DBG("frag_len %d rem_len %d", frag_len, rem_len);
+
+		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
+		assoc->offset += frag_len;
+
+		/* Read other fragments */
+		amp_read_loc_assoc_frag(hdev, rp->phy_handle);
+
+		return;
+	}
+
+	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
+	assoc->len = assoc->offset + rem_len;
+	assoc->offset = 0;
+
+process_cb:
+	/* Run callback when all fragments received */
+	hci_process_cb(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC, rp->status);
+}
+
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 					  struct sk_buff *skb)
 {
@@ -2294,6 +2331,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_cc_read_local_amp_info(hdev, skb);
 		break;
 
+	case HCI_OP_READ_LOCAL_AMP_ASSOC:
+		hci_cc_read_local_amp_assoc(hdev, skb);
+		break;
+
 	case HCI_OP_DELETE_STORED_LINK_KEY:
 		hci_cc_delete_stored_link_key(hdev, skb);
 		break;
-- 
1.7.9.5

