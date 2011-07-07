Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v3 7/9] Add support for getting the Encryption Key Size via btio
Date: Thu,  7 Jul 2011 19:03:28 -0300
Message-Id: <1310076210-15565-7-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1310076210-15565-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1310076210-15565-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some profiles specify some restriction depending on the length
of the key used to encrypt the link, this adds an way to retrieve
that value from the kernel.

Current kernels don't provide this information so the size is
always zero.
---
 btio/btio.c     |   21 +++++++++++++++++++++
 btio/btio.h     |    1 +
 lib/bluetooth.h |    1 +
 3 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 2cc9082..337dcb9 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -502,6 +502,22 @@ static int l2cap_set_flushable(int sock, gboolean flushable)
 	return 0;
 }
 
+static gboolean get_key_size(int sock, BtIOType type, int *size,
+								GError **err)
+{
+	struct bt_security sec;
+	socklen_t len;
+
+	memset(&sec, 0, sizeof(sec));
+	len = sizeof(sec);
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_SECURITY, &sec, &len) == 0) {
+		*size = sec.key_size;
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
 static gboolean l2cap_set(int sock, int sec_level, uint16_t imtu,
 				uint16_t omtu, uint8_t mode, int master,
 				int flushable, GError **err)
@@ -848,6 +864,11 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 						va_arg(args, int *), err))
 				return FALSE;
 			break;
+		case BT_IO_OPT_KEY_SIZE:
+			if (!get_key_size(sock, BT_IO_L2CAP,
+						va_arg(args, int *), err))
+				return FALSE;
+			break;
 		case BT_IO_OPT_PSM:
 			*(va_arg(args, uint16_t *)) = src.l2_psm ?
 						src.l2_psm : dst.l2_psm;
diff --git a/btio/btio.h b/btio/btio.h
index c6b736f..eaa9874 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -52,6 +52,7 @@ typedef enum {
 	BT_IO_OPT_DEST_BDADDR,
 	BT_IO_OPT_DEFER_TIMEOUT,
 	BT_IO_OPT_SEC_LEVEL,
+	BT_IO_OPT_KEY_SIZE,
 	BT_IO_OPT_CHANNEL,
 	BT_IO_OPT_SOURCE_CHANNEL,
 	BT_IO_OPT_DEST_CHANNEL,
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 738e07a..1492139 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -63,6 +63,7 @@ extern "C" {
 #define BT_SECURITY	4
 struct bt_security {
 	uint8_t level;
+	uint8_t key_size;
 };
 #define BT_SECURITY_SDP		0
 #define BT_SECURITY_LOW		1
-- 
1.7.6

