Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 04/13] Bluetooth: Add structures for the new SMP messages
Date: Thu, 25 Aug 2011 20:02:30 -0300
Message-Id: <1314313359-12652-5-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
References: <1314313359-12652-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   24 ++++++++++++++++++++++++
 include/net/bluetooth/mgmt.h     |   24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5b92442..8ae02c7 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -89,6 +89,28 @@ struct link_key_data {
 	u8 data[0];
 } __packed;
 
+struct smp_ltk_info {
+	u8 enc_size;
+	u16 ediv;
+	u8 rand[8];
+} __packed;
+
+struct smp_irsk_info {
+	u8 addr_type;
+} __packed;
+
+struct smp_link_key {
+	struct list_head list;
+	bdaddr_t bdaddr;
+	u8 type;
+	u8 pin_len;
+	u8 val[16];
+	union {
+		struct smp_ltk_info ltk;
+		struct smp_irsk_info irsk;
+	};
+} __packed;
+
 struct link_key {
 	struct list_head list;
 	bdaddr_t bdaddr;
@@ -203,6 +225,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct list_head	smp_keys;
+
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4ecf4a5..fcc6e5f 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -211,6 +211,24 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+struct mgmt_smp_key_info {
+	bdaddr_t bdaddr;
+	u8 type;
+	u8 pin_len;
+	u8 val[16];
+	union {
+		struct smp_ltk_info ltk;
+		struct smp_irsk_info irsk;
+	};
+} __packed;
+
+#define MGMT_OP_LOAD_SMP_KEYS		0x001F
+struct mgmt_cp_load_smp_keys {
+	__u8 debug_keys;
+	__u16 key_count;
+	struct mgmt_smp_key_info keys[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -312,3 +330,9 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
+
+#define MGMT_EV_NEW_SMP_KEY		0x0017
+struct mgmt_ev_new_smp_key {
+	__u8 store_hint;
+	struct mgmt_smp_key_info key;
+} __packed;
-- 
1.7.6

