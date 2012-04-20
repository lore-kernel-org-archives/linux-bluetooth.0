Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv7 23/23] Bluetooth: AMP: Read Local Assoc support
Date: Fri, 20 Apr 2012 14:09:51 +0300
Message-Id: <1334920191-29308-24-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds reading AMP Assoc in HCI callback

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |    3 ++
 include/net/bluetooth/amp.h      |    2 ++
 include/net/bluetooth/hci.h      |   15 ++++++++++
 include/net/bluetooth/hci_core.h |    8 ++++++
 net/bluetooth/a2mp.c             |    3 +-
 net/bluetooth/amp.c              |   59 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   44 ++++++++++++++++++++++++++++
 7 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 6304e14..387987b 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -123,4 +123,7 @@ int amp_mgr_put(struct amp_mgr *mgr);
 struct l2cap_chan *a2mp_channel_create(struct l2cap_conn *conn,
 				       struct sk_buff *skb);
 
+
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/amp.h b/include/net/bluetooth/amp.h
index 2751bf6..64d2b44 100644
--- a/include/net/bluetooth/amp.h
+++ b/include/net/bluetooth/amp.h
@@ -15,5 +15,7 @@
 #define __AMP_H
 
 int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
 
 #endif /* __AMP_H */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1320c06..d6b3a4a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -31,6 +31,7 @@
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
 #define HCI_MAX_AMP_KEY_SIZE	32
+#define HCI_MAX_AMP_ASSOC_SIZE	672
 
 /* HCI dev events */
 #define HCI_DEV_REG			1
@@ -854,6 +855,20 @@ struct hci_rp_read_local_amp_info {
 	__le32   be_flush_to;
 } __packed;
 
+#define HCI_OP_READ_LOCAL_AMP_ASSOC	0x140a
+struct hci_cp_read_local_amp_assoc {
+	__u8     handle;
+	__le16   len_so_far;
+	__le16   max_len;
+} __packed;
+
+struct hci_rp_read_local_amp_assoc {
+	__u8     status;
+	__u8     handle;
+	__le16   rem_len;
+	__u8     frag[0];
+} __packed;
+
 #define HCI_OP_LE_SET_EVENT_MASK	0x2001
 struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2fa5c3d..0e4cb1e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -142,6 +142,12 @@ struct hci_cb_cmd {
 	void (*destructor)(struct hci_cb_cmd *cmd);
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
@@ -195,6 +201,8 @@ struct hci_dev {
 	__u32		amp_max_flush_to;
 	__u32		amp_be_flush_to;
 
+	struct amp_assoc	loc_assoc;
+
 	__u8		flow_ctl_mode;
 
 	unsigned int	auto_accept_delay;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 39a3009..f9cfd55 100644
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
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index af009e0..c36bdf3 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -47,3 +47,62 @@ int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr)
 
 	return err;
 }
+
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle)
+{
+	struct hci_cp_read_local_amp_assoc cp;
+	struct amp_assoc *loc_assoc = &hdev->loc_assoc;
+
+	BT_DBG("%s: handle %d", hdev->name, phy_handle);
+
+	cp.handle = phy_handle;
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
index 0282d78..7ee0eb7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -44,6 +44,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/a2mp.h>
+#include <net/bluetooth/amp.h>
 
 /* Handle HCI Event packets */
 
@@ -880,6 +881,45 @@ send:
 	}
 }
 
+static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
+					struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_assoc *rp = (void *)skb->data;
+	struct amp_assoc *assoc = &hdev->loc_assoc;
+	struct hci_cb_cmd *cmd;
+	size_t rem_len, frag_len;
+
+	BT_DBG("%s status 0x%x", hdev->name, rp->status);
+
+	if (rp->status)
+		goto send;
+
+	frag_len = skb->len - sizeof(*rp);
+	rem_len = __le16_to_cpu(rp->rem_len);
+
+	if (rem_len > frag_len) {
+		memcpy(assoc->data + assoc->offset, rp->frag, frag_len);
+		assoc->offset += frag_len;
+
+		/* Read other fragments */
+		amp_read_loc_assoc_frag(hdev, rp->handle);
+
+		return;
+	}
+
+	memcpy(assoc->data + assoc->offset, rp->frag, rem_len);
+	assoc->len = assoc->offset + rem_len;
+	assoc->offset = 0;
+
+send:
+	/* Run callback when all fragments received */
+	cmd = hci_find_cb(hdev, HCI_OP_READ_LOCAL_AMP_ASSOC);
+	if (cmd) {
+		cmd->status = rp->status;
+		hci_queue_cb(hdev, cmd, hdev->workqueue);
+	}
+}
+
 static void hci_cc_delete_stored_link_key(struct hci_dev *hdev,
 							struct sk_buff *skb)
 {
@@ -2305,6 +2345,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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

