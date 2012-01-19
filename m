Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 34/34] Bluetooth: AMP: Read Local Assoc support
Date: Thu, 19 Jan 2012 11:20:23 +0200
Message-Id: <1326964823-26747-35-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds reading AMP Assoc in HCI callback

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h     |    3 ++
 include/net/bluetooth/hci.h      |   15 ++++++++++
 include/net/bluetooth/hci_core.h |    8 +++++
 net/bluetooth/a2mp.c             |    7 +++-
 net/bluetooth/amp.c              |   57 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   45 ++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 783f6d4..61bfde3 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -121,4 +121,7 @@ void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 void a2mp_channel_create(struct l2cap_conn *conn, struct sk_buff *skb);
 
+
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data);
+
 #endif /* __A2MP_H */
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3310efe..7683d93 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -31,6 +31,7 @@
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
 #define HCI_MAX_AMP_KEY_SIZE	32
+#define HCI_MAX_AMP_ASSOC_SIZE	672
 
 /* HCI dev events */
 #define HCI_DEV_REG			1
@@ -835,6 +836,20 @@ struct hci_rp_read_local_amp_info {
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
index b43784e..2cb7f50 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -136,6 +136,12 @@ struct cb_cmd {
 	void (*destructor)(struct cb_cmd *cmd);
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
@@ -184,6 +190,8 @@ struct hci_dev {
 	__u32		amp_max_flush_to;
 	__u32		amp_be_flush_to;
 
+	struct amp_assoc	loc_assoc;
+
 	__u8		flow_ctl_mode;
 
 	unsigned int	auto_accept_delay;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 4de97a5..88dc8f2 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -20,6 +20,8 @@
 #include <net/bluetooth/a2mp.h>
 
 int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
 
 /* A2MP build & send command helper functions */
 static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
@@ -55,8 +57,7 @@ static inline int __a2mp_send(struct amp_mgr *mgr, u8 *data, int len)
 	return chan->ops->send(chan, &msg, len, 0);
 }
 
-static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
-								void *data)
+void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len, void *data)
 {
 	struct a2mp_cmd *cmd;
 
@@ -239,6 +240,8 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 									&rsp);
 	}
 
+	amp_read_loc_assoc(hdev, mgr);
+
 	if (hdev)
 		hci_dev_put(hdev);
 
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index 3832c28b..7f64f5b 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -32,3 +32,60 @@ int amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr)
 
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
+void amp_read_loc_assoc_complete(struct hci_dev *hdev, struct cb_cmd *cmd)
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
+			amp_read_loc_assoc_complete, mgr, cb_destructor);
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index acbf4a9..ee94880 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -48,6 +48,8 @@
 
 static int enable_le;
 
+void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
+
 /* Handle HCI Event packets */
 
 static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -845,6 +847,45 @@ send:
 	}
 }
 
+static void hci_cc_read_local_amp_assoc(struct hci_dev *hdev,
+							struct sk_buff *skb)
+{
+	struct hci_rp_read_local_amp_assoc *rp = (void *)skb->data;
+	struct amp_assoc *assoc = &hdev->loc_assoc;
+	struct cb_cmd *cmd;
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
@@ -2191,6 +2232,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
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
1.7.4.1

