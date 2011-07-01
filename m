Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 02/12] Bluetooth: Add new structures for supporting SM key distribution
Date: Fri,  1 Jul 2011 16:07:37 -0300
Message-Id: <1309547267-9514-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need these changes because SMP keys may have more information
associated with them, for example, in the LTK case, it has an
encrypted diversifier (ediv) and a random number (rand).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci.h      |    4 ++++
 include/net/bluetooth/hci_core.h |   16 ++++++++++++++++
 include/net/bluetooth/mgmt.h     |    2 ++
 3 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 65345cd..3b6d057 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -254,6 +254,10 @@ enum {
 #define HCI_LK_UNAUTH_COMBINATION	0x04
 #define HCI_LK_AUTH_COMBINATION		0x05
 #define HCI_LK_CHANGED_COMBINATION	0x06
+/* The spec doesn't define types for SMP keys */
+#define HCI_LK_SMP_LTK			0x81
+#define HCI_LK_SMP_IRK			0x82
+#define HCI_LK_SMP_CSRK			0x83
 
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 26233d4..c92e89b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -74,12 +74,28 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
+struct key_master_id {
+	__le16 ediv;
+	u8 rand[8];
+} __packed;
+
+struct link_key_data {
+	bdaddr_t bdaddr;
+	u8 type;
+	u8 val[16];
+	u8 pin_len;
+	u8 dlen;
+	u8 data[0];
+} __packed;
+
 struct link_key {
 	struct list_head list;
 	bdaddr_t bdaddr;
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
+	u8 dlen;
+	u8 data[0];
 };
 
 struct oob_data {
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 45bea25..5428fd3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -101,6 +101,8 @@ struct mgmt_key_info {
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
+	u8 dlen;
+	u8 data[0];
 } __packed;
 
 #define MGMT_OP_LOAD_KEYS		0x000D
-- 
1.7.6

