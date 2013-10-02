Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v4 5/8] Bluetooth: Add the definition and structure for Set CSB
Date: Wed,  2 Oct 2013 21:54:50 +0900
Message-Id: <1380718493-4577-6-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380718493-4577-1-git-send-email-dh79.pyun@samsung.com>
References: <1380718493-4577-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

he Set_Connectionless_Slave_Broadcast command controls the
Connectionless Slave Broadcast functionality in the BR/EDR
Controller.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 78

"7.1.49 Set Connectionless Slave Broadcast Command [New Section]
...
The LT_ADDR indicated in the Set_Connectionless_Slave_Broadcast shall be
pre-allocated using the HCI_Set_Reserved_LT_ADDR command. If the
LT_ADDR has not been reserved, the Unknown Connection Identifier (0x02)
error code shall be returned. If the controller is unable to reserve
sufficient bandwidth for the requested activity, the Connection Rejected
Due to Limited Resources (0x0D) error code shall be returned.

The LPO_Allowed parameter informs the BR/EDR Controller whether it is
allowed to sleep.

The Packet_Type parameter specifies which packet types are allowed. The
Host shall either enable BR packet types only, or shall enable EDR and DM1
packet types only.

The Interval_Min and Interval_Max parameters specify the range from which
the BR/EDR Controller must select the Connectionless Slave Broadcast
Interval. The selected Interval is returned."

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cad6ca1..42d3832 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -628,6 +628,22 @@ struct hci_rp_logical_link_cancel {
 	__u8     flow_spec_id;
 } __packed;
 
+#define HCI_OP_SET_CSB			0x0441
+struct hci_cp_set_csb {
+	__u8	enable;
+	__u8	lt_addr;
+	__u8	lpo_allowed;
+	__le16	packet_type;
+	__le16	interval_min;
+	__le16	interval_max;
+	__le16	csb_sv_tout;
+} __packed;
+struct hci_rp_set_csb {
+	__u8	status;
+	__u8	lt_addr;
+	__le16	interval;
+} __packed;
+
 #define HCI_OP_SNIFF_MODE		0x0803
 struct hci_cp_sniff_mode {
 	__le16   handle;
-- 
1.8.1.2

