Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [bluetooth-next -v2 09/24] Bluetooth: Add SMP command structures
Date: Thu, 10 Feb 2011 22:38:54 -0300
Message-Id: <1297388349-14878-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
References: <1297388349-14878-1-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-2-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-3-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-4-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-5-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-6-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-7-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-8-git-send-email-vinicius.gomes@openbossa.org>
 <1297388349-14878-9-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Add command structures for security manager protocol.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/smp.h |   76 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 include/net/bluetooth/smp.h

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
new file mode 100644
index 0000000..8f2edbf
--- /dev/null
+++ b/include/net/bluetooth/smp.h
@@ -0,0 +1,76 @@
+#ifndef __SMP_H
+#define __SMP_H
+
+struct smp_command_hdr {
+	__u8	code;
+} __packed;
+
+#define SMP_CMD_PAIRING_REQ	0x01
+#define SMP_CMD_PAIRING_RSP	0x02
+struct smp_cmd_pairing {
+	__u8	io_capability;
+	__u8	oob_flag;
+	__u8	auth_req;
+	__u8	max_key_size;
+	__u8	init_key_dist;
+	__u8	resp_key_dist;
+} __packed;
+
+#define SMP_CMD_PAIRING_CONFIRM	0x03
+struct smp_cmd_pairing_confirm {
+	__u8	confirm_val[16];
+} __packed;
+
+#define SMP_CMD_PAIRING_RANDOM	0x04
+struct smp_cmd_pairing_random {
+	__u8	rand_val[16];
+} __packed;
+
+#define SMP_CMD_PAIRING_FAIL	0x05
+struct smp_cmd_pairing_fail {
+	__u8	reason;
+} __packed;
+
+#define SMP_CMD_ENCRYPT_INFO	0x06
+struct smp_cmd_encrypt_info {
+	__u8	ltk[16];
+} __packed;
+
+#define SMP_CMD_MASTER_IDENT	0x07
+struct smp_cmd_master_ident {
+	__u16	ediv;
+	__u8	rand[8];
+} __packed;
+
+#define SMP_CMD_IDENT_INFO	0x08
+struct smp_cmd_ident_info {
+	__u8	irk[16];
+} __packed;
+
+#define SMP_CMD_IDENT_ADDR_INFO	0x09
+struct smp_cmd_ident_addr_info {
+	__u8	addr_type;
+	bdaddr_t bdaddr;
+} __packed;
+
+#define SMP_CMD_SIGN_INFO	0x0a
+struct smp_cmd_sign_info {
+	__u8	csrk[16];
+} __packed;
+
+#define SMP_CMD_SECURITY_REQ	0x0b
+struct smp_cmd_security_req {
+	__u8	auth_req;
+} __packed;
+
+#define SMP_PASSKEY_ENTRY_FAILED	0x01
+#define SMP_OOB_NOT_AVAIL		0x02
+#define SMP_AUTH_REQUIREMENTS		0x03
+#define SMP_CONFIRM_FAILED		0x04
+#define SMP_PAIRING_NOTSUPP		0x05
+#define SMP_ENC_KEY_SIZE		0x06
+#define SMP_CMD_NOTSUPP		0x07
+#define SMP_UNSPECIFIED		0x08
+#define SMP_REPEATED_ATTEMPTS		0x09
+
+#endif /* __SMP_H */
-- 
1.7.4

