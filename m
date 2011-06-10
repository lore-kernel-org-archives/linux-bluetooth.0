Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 14/16] Bluetooth: Add LE Scan helper functions
Date: Fri, 10 Jun 2011 16:36:11 -0300
Message-Id: <1307734573-1630-15-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds some helper functions to perform LE scan according
to the general discovery procedure recommendations.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci.h |    9 +++++++
 net/bluetooth/mgmt.c        |   56 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7a0dd4f..c92a4cc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -711,6 +711,15 @@ struct hci_rp_le_read_buffer_size {
 	__u8     le_max_pkt;
 } __packed;
 
+#define HCI_OP_LE_SET_SCAN_PARAM	0x200b
+struct hci_cp_le_set_scan_param {
+	__u8    type;
+	__le16  interval;
+	__le16  window;
+	__u8    own_address_type;
+	__u8    filter_policy;
+} __packed;
+
 #define HCI_OP_LE_SET_SCAN_ENABLE	0x200c
 struct hci_cp_le_set_scan_enable {
 	__u8     enable;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9453b1a..9e60416 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1619,6 +1619,54 @@ static int do_inquiry(struct hci_dev *hdev, __u8 inq_length)
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
 }
 
+/* hdev must be locked */
+static int set_le_scan_param(struct hci_dev *hdev)
+{
+	struct hci_cp_le_set_scan_param cp;
+
+	/*
+	 * These values are set according to LE General Discovery Procedure
+	 * specification.
+	 */
+	cp.type = 0x01; /* Active scanning */
+	cp.interval = cpu_to_le16(0x0012); /* TGAP(gen_disc_scan_int) */
+	cp.window = cpu_to_le16(0x0012); /* TGAP(gen_disc_scan_wind) */
+	cp.own_address_type = 0x00; /* Public */
+	cp.filter_policy = 0x00; /* Accept all advertisement packets */
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
+}
+
+/* hdev must be locked */
+static int enable_le_scan(struct hci_dev *hdev, __u8 enable)
+{
+	struct hci_cp_le_set_scan_enable cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.enable = enable;
+
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+}
+
+/* hdev must be locked */
+static int do_le_scan(struct hci_dev *hdev, int timeout)
+{
+	int err;
+
+	err = set_le_scan_param(hdev);
+	if (err < 0)
+		return err;
+
+	err = enable_le_scan(hdev, 1);
+	if (err < 0)
+		return err;
+
+	mod_timer(&hdev->le_scan_timer,
+			jiffies + msecs_to_jiffies(timeout));
+
+	return 0;
+}
+
 static int get_device_type(struct hci_dev *hdev)
 {
 	if (!lmp_no_bredr_capable(hdev) && lmp_le_capable(hdev))
@@ -1688,6 +1736,14 @@ static inline int cancel_inquiry(struct hci_dev *hdev)
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
 
+/* hdev must be locked */
+static int cancel_le_scan(struct hci_dev *hdev)
+{
+	del_timer(&hdev->le_scan_timer);
+
+	return enable_le_scan(hdev, 0);
+}
+
 static int stop_discovery(struct sock *sk, u16 index)
 {
 	struct hci_dev *hdev;
-- 
1.7.4.1

