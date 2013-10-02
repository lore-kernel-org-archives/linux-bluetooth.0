Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v2 1/8] Bluetooth: Add Set Reserved LT_ADDR Command
Date: Wed,  2 Oct 2013 20:10:11 +0900
Message-Id: <1380712218-9269-2-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
References: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Set_Reserved_LT_ADDR command allows the host to request that the
BR/EDR Controller reserve a specific LT_ADDR for Connectionless Slave
Broadcast.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 90

"7.3.86 Set Reserved LT_ADDR Command [New Section]
...
If the LT_ADDR indicated in the LT_ADDR parameter is already in use by the
BR/EDR Controller, it shall return the ACL Connection Already Exists (0x0B)
error code. If the LT_ADDR indicated in the LT_ADDR parameter is out of
range, the controller shall return the Invalid HCI Command Parameters (0x12)
error code. If the command succeeds, then the reserved LT_ADDR shall be
used when issuing subsequent Set Connectionless Slave Broadcast Data and
Set Connectionless Slave Broadcast commands.
To ensure that the reserved LT_ADDR is not already allocated, it is
recommended that this command be issued at some point after HCI_Reset is
issued but before page scanning is enabled or paging is initiated."

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4fa08d7..420a8c4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -839,6 +839,15 @@ struct hci_cp_write_le_host_supported {
 	__u8	simul;
 } __packed;
 
+#define HCI_OP_SET_RESERVED_LT_ADDR	0x0c74
+struct hci_cp_set_reserved_lt_addr {
+	__u8	lt_addr;
+} __packed;
+struct hci_rp_set_reserved_lt_addr {
+	__u8	status;
+	__u8	lt_addr;
+} __packed;
+
 #define HCI_OP_READ_SYNC_TRAIN_PARAMS	0x0c77
 
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
-- 
1.8.1.2

