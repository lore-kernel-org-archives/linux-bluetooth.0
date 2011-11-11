Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 1/8] Bluetooth: Add structures for the new LTK exchange messages
Date: Thu, 10 Nov 2011 22:03:49 -0300
Message-Id: <1320973436-13399-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/mgmt.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8b07a83..f4011e3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -233,6 +233,21 @@ struct mgmt_cp_set_fast_connectable {
 	__u8 enable;
 } __packed;
 
+struct mgmt_ltk_info {
+	bdaddr_t bdaddr;
+	__u8 pin_len;
+	__u8 enc_size;
+	__le16 ediv;
+	__u8 rand[8];
+	__u8 val[16];
+} __packed;
+
+#define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0023
+struct mgmt_cp_load_long_term_keys {
+	__u16 key_count;
+	struct mgmt_ltk_info keys[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16 opcode;
@@ -327,3 +342,9 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
+
+#define MGMT_EV_NEW_LONG_TERM_KEY	0x0017
+struct mgmt_ev_new_long_term_key {
+	__u8 store_hint;
+	struct mgmt_ltk_info key;
+} __packed;
-- 
1.7.7

