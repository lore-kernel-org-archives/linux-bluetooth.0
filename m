Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 01/12] Add messages to the mgmt interface to handle SMP key storage
Date: Fri, 19 Aug 2011 21:11:57 -0300
Message-Id: <1313799128-8842-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SMP keys are to be communicated to/from userspace using these
messages.
---
 doc/mgmt-api.txt |   41 +++++++++++++++++++++++++++++++++++++++++
 lib/mgmt.h       |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e5cf5de..127af94 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -387,6 +387,28 @@ Write Controller Tracing Filter Command
 				Protocol_Identifier[i] (16 Octets)
 	Return Parameters:	Status (1 Octet)
 
+Load SMP Keys Command
+=====================
+
+	Command Code:		0x001F
+	Controller Index:	<controller id>
+	Command Parameters:	Debug Keys (1 Octet)
+				Key Count (2 Octets)
+				Key1 {
+					Address (6 Octets)
+					Type (1 Octet)
+					PIN_Length (1 Octet)
+					Value (16 Octets)
+					[
+						Encryption Size (1 Octet)
+						Enc. Diversifier (2 Octets)
+						Random Number (8 Octets)
+					] || [
+						Address Type (1 Octet)
+					]
+				}
+				Key2 {  }
+				...
 
 Command Complete Event
 ======================
@@ -552,3 +574,22 @@ Discovering Event
 Event Code		0x00014
 Controller Index	<controller id>
 Event Parameters	Discovering (1 Octet)
+
+New SMP Key Event
+=================
+
+Event Code		0x0015
+Controller Index	<controller id>
+Event Parameters	Store Hint (1 Octet)
+			Key {
+				Address (6 Octets)
+				Type (1 Octet)
+				PIN_Length (1 Octet)
+				Value (16 Octets)
+				[	Encryption Size (1 Octet)
+					Enc. Diversifier (2 Octets)
+					Random Number (8 Octets)
+				] || [
+					Address Type (1 Octet)
+				]
+			}
diff --git a/lib/mgmt.h b/lib/mgmt.h
index f22434e..0c52850 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -215,6 +215,35 @@ struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
 
+struct smp_ltk_info {
+	uint8_t enc_size;
+	uint16_t ediv;
+	uint8_t rand[8];
+} __packed;
+
+struct smp_irsk_info {
+	uint8_t addr_type;
+} __packed;
+
+struct mgmt_smp_key_info {
+	bdaddr_t bdaddr;
+	uint8_t type;
+	uint8_t pin_len;
+	uint8_t val[16];
+	union {
+		struct smp_ltk_info ltk;
+		struct smp_irsk_info irsk;
+		uint8_t data[0];
+	};
+} __packed;
+
+#define MGMT_OP_LOAD_SMP_KEYS		0x001F
+struct mgmt_cp_load_smp_keys {
+	uint8_t debug_keys;
+	uint16_t key_count;
+	struct mgmt_smp_key_info keys[0];
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -305,3 +334,9 @@ struct mgmt_ev_remote_name {
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0014
+
+#define MGMT_EV_NEW_SMP_KEY		0x0015
+struct mgmt_ev_new_smp_key {
+	uint8_t store_hint;
+	struct mgmt_smp_key_info key;
+} __packed;
-- 
1.7.6

