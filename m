Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v3 3/8] Bluetooth: Add Set Connectionless Slave Broadcast Data Command
Date: Wed,  2 Oct 2013 21:09:13 +0900
Message-Id: <1380715758-10334-4-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380715758-10334-1-git-send-email-dh79.pyun@samsung.com>
References: <1380715758-10334-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Set_Connectionless_Slave_Broadcast_Data command provides the
ability for the Host to set Connectionless Slave Broadcast data in
the BR/EDR Controller.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 93

"7.3.88 Set Connectionless Slave Broadcast Data Command [New Section]
...
If connectionless slave broadcast mode is disabled, this data shall be
kept by the BR/EDR Controller and used once connectionless slave broadcast
mode is enabled. If connectionless slave broadcast mode is enabled,
and this command is successful, this data will be sent starting with
the next Connectionless Slave Broadcast instant.

The Data_Length field may be zero, in which case no data needs to be
provided.

The Host may fragment the data using the Fragment field in the command. If
the combined length of the fragments exceeds the capacity of the largest
allowed packet size specified in the Set Connectionless Slave Broadcast
command, all fragments associated with the data being assembled shall be
discarded and the Invalid HCI Command Parameters error (0x12) shall be
returned."

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 9b071f1..d9e0a84 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -35,6 +35,8 @@
 
 #define HCI_MAX_AMP_ASSOC_SIZE	672
 
+#define HCI_MAX_CSB_DATA_SIZE	252
+
 /* HCI dev events */
 #define HCI_DEV_REG			1
 #define HCI_DEV_UNREG			2
@@ -857,6 +859,18 @@ struct hci_rp_delete_reserved_lt_addr {
 	__u8	lt_addr;
 } __packed;
 
+#define HCI_OP_SET_CSB_DATA		0x0c76
+struct hci_cp_set_csb_data {
+	__u8	lt_addr;
+	__u8	fragment;
+	__u8	data_length;
+	__u8	data[HCI_MAX_CSB_DATA_SIZE];
+} __packed;
+struct hci_rp_set_csb_data {
+	__u8	status;
+	__u8	lt_addr;
+} __packed;
+
 #define HCI_OP_READ_SYNC_TRAIN_PARAMS	0x0c77
 
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
-- 
1.8.1.2

