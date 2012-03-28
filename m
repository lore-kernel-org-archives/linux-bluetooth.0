Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv6 21/26] Bluetooth: physical link HCI interface to AMP
Date: Wed, 28 Mar 2012 16:31:44 +0300
Message-Id: <1332941509-21345-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Adds support for physical link create/acceppt/disconnect AMP HCI
commands. To be used by the upper layer.
Backport from CodeAurora & Atheros

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |   24 ++++++++++++++++++++++
 net/bluetooth/hci_core.c    |   45 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3a7bd76..3577b85 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -30,6 +30,8 @@
 #define HCI_MAX_EVENT_SIZE	260
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
+#define HCI_MAX_AMP_KEY_SIZE	32
+
 /* HCI dev events */
 #define HCI_DEV_REG			1
 #define HCI_DEV_UNREG			2
@@ -525,6 +527,28 @@ struct hci_cp_io_capability_neg_reply {
 	__u8     reason;
 } __packed;
 
+#define HCI_OP_CREATE_PHY_LINK		0x0435
+struct hci_cp_create_phy_link {
+	__u8     handle;
+	__u8     key_len;
+	__u8     key_type;
+	__u8     key[HCI_MAX_AMP_KEY_SIZE];
+} __packed;
+
+#define HCI_OP_ACCEPT_PHY_LINK		0x0436
+struct hci_cp_accept_phy_link {
+	__u8	handle;
+	__u8	key_len;
+	__u8	key_type;
+	__u8	key[HCI_MAX_AMP_KEY_SIZE];
+} __packed;
+
+#define HCI_OP_DISC_PHY_LINK		0x0437
+struct hci_cp_disc_phy_link {
+	__u8     handle;
+	__u8     reason;
+} __packed;
+
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
 	__le16   handle;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f807146..f27e3e8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -340,6 +340,51 @@ static void hci_linkpol_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_WRITE_DEF_LINK_POLICY, 2, &policy);
 }
 
+/* AMP HCI interface */
+void hci_phylink_create_req(struct hci_dev *hdev, __u8 handle, __u8 key_len,
+						__u8 key_type, __u8 *key)
+{
+	struct hci_cp_create_phy_link cp;
+
+	cp.handle	= handle;
+	cp.key_type	= key_type;
+	cp.key_len	= min_t(__u8, key_len, HCI_MAX_AMP_KEY_SIZE);
+
+	BT_DBG("key len %d, phy handle %d", cp.key_len, cp.handle);
+
+	memcpy(cp.key, key, cp.key_len);
+	hci_send_cmd(hdev, HCI_OP_CREATE_PHY_LINK, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_phylink_create_req);
+
+void hci_phylink_accept_req(struct hci_dev *hdev, __u8 handle, __u8 key_len,
+						__u8 key_type, __u8 *key)
+{
+	struct hci_cp_accept_phy_link cp;
+
+	cp.handle	= handle;
+	cp.key_type	= key_type;
+	cp.key_len	= min_t(__u8, key_len, HCI_MAX_AMP_KEY_SIZE);
+
+	BT_DBG("key len %d, phy handle %d", cp.key_len, cp.handle);
+
+	memcpy(cp.key, key, cp.key_len);
+	hci_send_cmd(hdev, HCI_OP_ACCEPT_PHY_LINK, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_phylink_accept_req);
+
+void hci_phylink_disc_req(struct hci_dev *hdev, __u8 handle, __u8 reason)
+{
+	struct hci_cp_disc_phy_link cp;
+
+	BT_DBG("handle %d reason %d", handle, reason);
+
+	cp.handle = handle;
+	cp.reason = reason;
+	hci_send_cmd(hdev, HCI_OP_DISC_PHY_LINK, sizeof(cp), &cp);
+}
+EXPORT_SYMBOL(hci_phylink_disc_req);
+
 /* Get HCI device by index.
  * Device is held on return. */
 struct hci_dev *hci_dev_get(int index)
-- 
1.7.9.1

