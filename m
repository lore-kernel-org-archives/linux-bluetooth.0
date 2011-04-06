Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 03/15] Bluetooth: Add new structures for supporting SM key distribution
Date: Tue,  5 Apr 2011 23:11:16 -0300
Message-Id: <1302055888-28177-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need these changes because SMP keys may have more information
associated with them, for example, in the LTK case, it has an
encrypted diversifier (ediv) and a random number (rand).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   20 ++++++++++++++++++++
 include/net/bluetooth/mgmt.h     |    2 ++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 669bcea..74c9f07 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -74,12 +74,32 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
+struct key_master_id {
+	__le16 ediv;
+	u8 rand[8];
+} __packed;
+
+#define KEY_TYPE_LTK	0x11
+#define KEY_TYPE_IRK	0x12
+#define KEY_TYPE_CSRK	0x13
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
index 6b6ff92..d467fb8 100644
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
1.7.4.1

