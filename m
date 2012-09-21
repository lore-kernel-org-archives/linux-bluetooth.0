Return-Path: <cyrus@holtmann.org>
From: Joohi RASTOGI <joohi.rastogi@stericsson.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Joohi RASTOGI <joohi.rastogi@stericsson.com>
Date: Fri, 21 Sep 2012 07:22:33 +0200
Subject: [PATCH BlueZ V7 4/5] AVRCP: Register/Unregister Browsing handler
Message-ID: <3176460F0F455A44B2E93431E34FC86C228F881F34@EXDCVYMBSTM005.EQ1STM.local>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From 0c8f6e695ce76d3660ae890f04b1c03529fce108 Mon Sep 17 00:00:00 2001
From: Joohi Rastogi <joohi.rastogi@stericsson.com>
Date: Fri, 21 Sep 2012 10:26:42 +0530
Subject: [PATCH] Add functions to register and unregister Browsing handler

---
 audio/avctp.c |   24 ++++++++++++++++++++++++
 audio/avctp.h |    8 +++++++-
 2 files changed, 31 insertions(+), 1 deletions(-)
 mode change 100755 => 100644 audio/avctp.h

diff --git a/audio/avctp.c b/audio/avctp.c
index 5a95d8d..fb5689e 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -158,6 +158,11 @@ struct avctp_pdu_handler {
 	unsigned int id;
 };
 
+struct avctp_browsing_pdu_handler {
+	avctp_browsing_pdu_cb cb;
+	void *user_data;
+};
+
 static struct {
 	const char *name;
 	uint8_t avc;
@@ -177,6 +182,7 @@ static GSList *callbacks = NULL;
 static GSList *servers = NULL;
 static GSList *control_handlers = NULL;
 static uint8_t id = 0;
+static struct avctp_browsing_pdu_handler *browsing_handler = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
 
@@ -1261,6 +1267,18 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 	return handler->id;
 }
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+					void *user_data)
+{
+	unsigned int id = 0;
+
+	browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
+	browsing_handler->cb = cb;
+	browsing_handler->user_data = user_data;
+
+	return ++id;
+}
+
 gboolean avctp_unregister_pdu_handler(unsigned int id)
 {
 	GSList *l;
@@ -1278,6 +1296,12 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
 	return FALSE;
 }
 
+gboolean avctp_unregister_browsing_pdu_handler()
+{
+	g_free(browsing_handler);
+	return TRUE;
+}
+
 struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	struct avctp *session;
diff --git a/audio/avctp.h b/audio/avctp.h
old mode 100755
new mode 100644
index 53919de..ae5c556
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -82,6 +82,10 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session, uint8_t transacti
 typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data);
+typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
+					uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data);
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
@@ -96,7 +100,9 @@ void avctp_disconnect(struct avctp *session);
 unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 							void *user_data);
 gboolean avctp_unregister_pdu_handler(unsigned int id);
-
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data);
+gboolean avctp_unregister_browsing_pdu_handler();
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
-- 
1.7.5.4

Regards
Joohi
