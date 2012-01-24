Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 2/6] Add support for getting the Encryption Key Size via btio
Date: Mon, 23 Jan 2012 21:27:01 -0300
Message-Id: <1327364825-7285-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1327364825-7285-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some profiles specify some restriction depending on the length
of the key used to encrypt the link, this adds an way to retrieve
that value from the kernel.
---
 btio/btio.c |   19 +++++++++++++++++++
 btio/btio.h |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index a45a9cc..77ddb1d 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -511,6 +511,21 @@ static int set_priority(int sock, uint32_t prio)
 	return 0;
 }
 
+static gboolean get_key_size(int sock, int *size, GError **err)
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
 				int flushable, uint32_t priority, GError **err)
@@ -875,6 +890,10 @@ static gboolean l2cap_get(int sock, GError **err, BtIOOption opt1,
 						va_arg(args, int *), err))
 				return FALSE;
 			break;
+		case BT_IO_OPT_KEY_SIZE:
+			if (!get_key_size(sock, va_arg(args, int *), err))
+				return FALSE;
+			break;
 		case BT_IO_OPT_PSM:
 			*(va_arg(args, uint16_t *)) = src.l2_psm ?
 					btohs(src.l2_psm) : btohs(dst.l2_psm);
diff --git a/btio/btio.h b/btio/btio.h
index ae55b61..7e3e130 100644
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
-- 
1.7.8.1

