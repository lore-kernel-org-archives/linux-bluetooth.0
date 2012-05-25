Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Define HCI AMP cmd struct
Date: Fri, 25 May 2012 14:14:00 +0300
Message-Id: <1337944440-9361-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337944440-9361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337944440-9361-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add HCI commands to deal with Bluetooth AMP controllers.
Those commands will be used by bluetooth and softamp code.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |   83 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index edb6639..afd9594 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -31,6 +31,7 @@
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
 #define HCI_LINK_KEY_SIZE	16
+#define HCI_AMP_LINK_KEY_SIZE	(2 * HCI_LINK_KEY_SIZE)
 
 /* HCI dev events */
 #define HCI_DEV_REG			1
@@ -525,6 +526,28 @@ struct hci_cp_io_capability_neg_reply {
 	__u8     reason;
 } __packed;
 
+#define HCI_OP_CREATE_PHY_LINK		0x0435
+struct hci_cp_create_phy_link {
+	__u8     phy_handle;
+	__u8     key_len;
+	__u8     key_type;
+	__u8     key[HCI_AMP_LINK_KEY_SIZE];
+} __packed;
+
+#define HCI_OP_ACCEPT_PHY_LINK		0x0436
+struct hci_cp_accept_phy_link {
+	__u8     phy_handle;
+	__u8     key_len;
+	__u8     key_type;
+	__u8     key[HCI_AMP_LINK_KEY_SIZE];
+} __packed;
+
+#define HCI_OP_DISC_PHY_LINK		0x0437
+struct hci_cp_disc_phy_link {
+	__u8     phy_handle;
+	__u8     reason;
+} __packed;
+
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
 	__le16   handle;
@@ -820,6 +843,33 @@ struct hci_rp_read_local_amp_info {
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
+#define HCI_OP_WRITE_REMOTE_AMP_ASSOC	0x140b
+struct hci_cp_write_remote_amp_assoc {
+	__u8     handle;
+	__le16   len_so_far;
+	__le16   rem_len;
+	__u8     frag[0];
+} __packed;
+
+struct hci_rp_write_remote_amp_assoc {
+	__u8     status;
+	__u8     handle;
+} __packed;
+
 #define HCI_OP_LE_SET_EVENT_MASK	0x2001
 struct hci_cp_le_set_event_mask {
 	__u8     mask[8];
@@ -1192,6 +1242,39 @@ struct hci_ev_le_meta {
 	__u8     subevent;
 } __packed;
 
+#define HCI_EV_PHY_LINK_COMPLETE	0x40
+struct hci_ev_phy_link_complete {
+	__u8     status;
+	__u8     phy_handle;
+} __packed;
+
+#define HCI_EV_CHANNEL_SELECTED		0x41
+struct hci_ev_channel_selected {
+	__u8     phy_handle;
+} __packed;
+
+#define HCI_EV_DISC_PHY_LINK_COMPLETE	0x42
+struct hci_ev_disc_phy_link_complete {
+	__u8     status;
+	__u8     phy_handle;
+	__u8     reason;
+} __packed;
+
+#define HCI_EV_LOG_LINK_COMPLETE	0x45
+struct hci_ev_log_link_complete {
+	__u8     status;
+	__le16   log_handle;
+	__u8     phy_handle;
+	__u8     flow_spec_id;
+} __packed;
+
+#define HCI_EV_DISC_LOG_LINK_COMPLETE	0x46
+struct hci_ev_disconn_log_link_complete {
+	__u8     status;
+	__le16   log_handle;
+	__u8     reason;
+} __packed;
+
 #define HCI_EV_NUM_COMP_BLOCKS		0x48
 struct hci_comp_blocks_info {
 	__le16   handle;
-- 
1.7.9.5

