Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 02/11] Add messages to the mgmt interface to handle SMP key storage
Date: Wed, 18 Jan 2012 14:12:31 -0300
Message-Id: <1326906751-15470-1-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SMP keys are to be communicated to/from userspace using these
messages.
---
Johan,

Just a note that I need to update my kernel patches after you remove
the Remote Name event.

 lib/mgmt.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 5414ea6..af63889 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -275,6 +275,22 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+struct mgmt_ltk_info {
+	struct mgmt_addr_info addr;
+	uint8_t authenticated;
+	uint8_t master;
+	uint8_t enc_size;
+	uint16_t ediv;
+	uint8_t rand[8];
+	uint8_t val[16];
+} __packed;
+
+#define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0026
+struct mgmt_cp_load_long_term_keys {
+	uint16_t key_count;
+	struct mgmt_ltk_info keys[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -374,3 +390,9 @@ struct mgmt_ev_device_blocked {
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
+
+#define MGMT_EV_NEW_LONG_TERM_KEY	0x0015
+struct mgmt_ev_new_long_term_key {
+	uint8_t store_hint;
+	struct mgmt_ltk_info key;
+} __packed;
-- 
1.7.8.1

