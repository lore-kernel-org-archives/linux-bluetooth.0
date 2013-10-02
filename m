Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>,
	C S Bhargava <cs.bhargava@samsung.com>
Subject: [PATCH v2 2/8] Bluetooth: Add Delete Reserved LT_ADDR Command
Date: Wed,  2 Oct 2013 20:10:12 +0900
Message-Id: <1380712218-9269-3-git-send-email-dh79.pyun@samsung.com>
In-Reply-To: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
References: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

The Delete_Reserved_LT_ADDR command requests that the BR/EDR
Controller cancel the reservation for a specific LT_ADDR reserved for the
purposes of Connectionless Slave Broadcast.

The Core Spec Addendum 4 adds this command in part B Connectionless
Slave Broadcast.

Bluetooth Core Specification Addendum 4 - Page 92

"7.3.87 Delete Reserved LT_ADDR Command [New Section]
...
If the LT_ADDR indicated in the LT_ADDR parameter is not reserved by the
BR/EDR Controller, it shall return the Unknown Connection Identifier (0x02)
error code.
If connectionless slave broadcast mode is still active, then the Controller
shall return the Command Disallowed (0x0C) error code."

Signed-off-by: Dohyun Pyun <dh79.pyun@samsung.com>
Signed-off-by: C S Bhargava <cs.bhargava@samsung.com>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 420a8c4..187938c 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -848,6 +848,15 @@ struct hci_rp_set_reserved_lt_addr {
 	__u8	lt_addr;
 } __packed;
 
+#define HCI_OP_DELETE_RESERVED_LT_ADDR	0x0c75
+struct hci_cp_delete_reserved_lt_addr {
+	__u8	lt_addr;
+} __packed;
+struct hci_rp_delete_reserved_lt_addr {
+	__u8	status;
+	__u8	lt_addr;
+} __packed;
+
 #define HCI_OP_READ_SYNC_TRAIN_PARAMS	0x0c77
 
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
-- 
1.8.1.2

