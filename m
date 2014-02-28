Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/avctp: Make handler return ssize_t
Date: Fri, 28 Feb 2014 15:42:31 +0200
Message-Id: <1393594953-4970-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1393594953-4970-1-git-send-email-luiz.dentz@gmail.com>
References: <1393594953-4970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes possible to return errors such as -EAGAIN to indicate the
request would block and a response will be sent asynchronously.
---
 android/avctp.c     | 17 ++++++++++++-----
 android/avctp.h     |  2 +-
 android/avrcp-lib.c |  2 +-
 unit/test-avctp.c   |  2 +-
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index bc1bd80..aa5abc9 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -311,7 +311,7 @@ static gboolean auto_release(gpointer user_data)
 	return FALSE;
 }
 
-static size_t handle_panel_passthrough(struct avctp *session,
+static ssize_t handle_panel_passthrough(struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
@@ -402,7 +402,7 @@ done:
 	return operand_count;
 }
 
-static size_t handle_unit_info(struct avctp *session,
+static ssize_t handle_unit_info(struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
@@ -428,7 +428,7 @@ static size_t handle_unit_info(struct avctp *session,
 	return operand_count;
 }
 
-static size_t handle_subunit_info(struct avctp *session,
+static ssize_t handle_subunit_info(struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
@@ -849,8 +849,9 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 	uint8_t *operands, code, subunit;
 	struct avctp_header *avctp;
 	struct avc_header *avc;
-	int ret, packet_size, operand_count, sock;
+	int packet_size, operand_count, sock;
 	struct avctp_pdu_handler *handler;
+	ssize_t ret;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto failed;
@@ -910,10 +911,16 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 	code = avc->code;
 	subunit = avc->subunit_type;
 
-	packet_size += handler->cb(session, avctp->transaction, &code,
+	ret = handler->cb(session, avctp->transaction, &code,
 					&subunit, operands, operand_count,
 					handler->user_data);
+	if (ret < 0) {
+		if (ret == -EAGAIN)
+			return TRUE;
+		goto failed;
+	}
 
+	packet_size += ret;
 	avc->code = code;
 	avc->subunit_type = subunit;
 
diff --git a/android/avctp.h b/android/avctp.h
index dfa0ca6..2f419a2 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -113,7 +113,7 @@ struct avctp;
 typedef bool (*avctp_passthrough_cb) (struct avctp *session,
 					uint8_t op, bool pressed,
 					void *user_data);
-typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
+typedef ssize_t (*avctp_control_pdu_cb) (struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data);
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index b1085f2..88d8875 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -129,7 +129,7 @@ void avrcp_shutdown(struct avrcp *session)
 	g_free(session);
 }
 
-static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
+static ssize_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 					uint8_t *code, uint8_t *subunit,
 					uint8_t *operands, size_t operand_count,
 					void *user_data)
diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index be1dfd7..0759731 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -227,7 +227,7 @@ static void execute_context(struct context *context)
 	destroy_context(context);
 }
 
-static size_t handler(struct avctp *session,
+static ssize_t handler(struct avctp *session,
 					uint8_t transaction, uint8_t *code,
 					uint8_t *subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
-- 
1.8.5.3

