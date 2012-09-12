Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org, gustavo@padovan.org
Subject: [PATCHv4 01/17] Bluetooth: Add HCI logical link cmds definitions
Date: Wed, 12 Sep 2012 11:06:16 +0300
Message-Id: <1347437192-24694-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <alpine.DEB.2.02.1209111121550.3754@mathewm-linux>
 <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h |   36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0f28f70..42aae18 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -556,12 +556,46 @@ struct hci_cp_accept_phy_link {
 	__u8     key[HCI_AMP_LINK_KEY_SIZE];
 } __packed;
 
-#define HCI_OP_DISCONN_PHY_LINK	0x0437
+#define HCI_OP_DISCONN_PHY_LINK		0x0437
 struct hci_cp_disconn_phy_link {
 	__u8     phy_handle;
 	__u8     reason;
 } __packed;
 
+struct ext_flow_spec {
+	__u8       id;
+	__u8       stype;
+	__le16     msdu;
+	__le32     sdu_itime;
+	__le32     acc_lat;
+	__le32     flush_to;
+} __packed;
+
+#define HCI_OP_CREATE_LOGICAL_LINK	0x0438
+#define HCI_OP_ACCEPT_LOGICAL_LINK	0x0439
+struct hci_cp_create_accept_logical_link {
+	__u8                  phy_handle;
+	struct ext_flow_spec  tx_flow_spec;
+	struct ext_flow_spec  rx_flow_spec;
+} __packed;
+
+#define HCI_OP_DISCONN_LOGICAL_LINK	0x043a
+struct hci_cp_disconn_logical_link {
+	__le16   log_handle;
+} __packed;
+
+#define HCI_OP_LOGICAL_LINK_CANCEL	0x043b
+struct hci_cp_logical_link_cancel {
+	__u8     phy_handle;
+	__u8     flow_spec_id;
+} __packed;
+
+struct hci_rp_logical_link_cancel {
+	__u8     status;
+	__u8     phy_handle;
+	__u8     flow_spec_id;
+} __packed;
+
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
 	__le16   handle;
-- 
1.7.9.5

