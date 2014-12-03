Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/49] Bluetooth: Add basic SMP defines for LE Secure Connections
Date: Wed,  3 Dec 2014 17:01:55 +0200
Message-Id: <1417618963-18010-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds basic SMP defines for commands, error codes and PDU
definitions for the LE Secure Connections feature.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.h | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index f76083b85005..7c3c351909f5 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -50,10 +50,13 @@ struct smp_cmd_pairing {
 #define SMP_DIST_ENC_KEY	0x01
 #define SMP_DIST_ID_KEY		0x02
 #define SMP_DIST_SIGN		0x04
+#define SMP_DIST_LINK_KEY	0x08
 
 #define SMP_AUTH_NONE		0x00
 #define SMP_AUTH_BONDING	0x01
 #define SMP_AUTH_MITM		0x04
+#define SMP_AUTH_SC		0x08
+#define SMP_AUTH_KEYPRESS	0x10
 
 #define SMP_CMD_PAIRING_CONFIRM	0x03
 struct smp_cmd_pairing_confirm {
@@ -102,7 +105,23 @@ struct smp_cmd_security_req {
 	__u8	auth_req;
 } __packed;
 
-#define SMP_CMD_MAX		0x0b
+#define SMP_CMD_PUBLIC_KEY	0x0c
+struct smp_cmd_public_key {
+	__u8	x[32];
+	__u8	y[32];
+} __packed;
+
+#define SMP_CMD_DHKEY_CHECK	0x0d
+struct smp_cmd_dhkey_check {
+	__u8	e[16];
+} __packed;
+
+#define SMP_CMD_KEYPRESS_NOTIFY	0x0e
+struct smp_cmd_keypress_notify {
+	__u8	value;
+} __packed;
+
+#define SMP_CMD_MAX		0x0e
 
 #define SMP_PASSKEY_ENTRY_FAILED	0x01
 #define SMP_OOB_NOT_AVAIL		0x02
@@ -114,6 +133,10 @@ struct smp_cmd_security_req {
 #define SMP_UNSPECIFIED			0x08
 #define SMP_REPEATED_ATTEMPTS		0x09
 #define SMP_INVALID_PARAMS		0x0a
+#define SMP_DHKEY_CHECK_FAILED		0x0b
+#define SMP_NUMERIC_COMP_FAILED		0x0c
+#define SMP_BREDR_PAIRING_IN_PROGRESS	0x0d
+#define SMP_CROSS_TRANSP_NOT_ALLOWED	0x0e
 
 #define SMP_MIN_ENC_KEY_SIZE		7
 #define SMP_MAX_ENC_KEY_SIZE		16
-- 
2.1.0

