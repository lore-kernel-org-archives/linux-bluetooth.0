Return-Path: <cyrus@holtmann.org>
From: Vani-dineshbhai PATEL <vani.patel@stericsson.com>
To: User Name <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto <luiz.dentz@gmail.com>,
	Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: Vani <vani.patel@stericsson.com>,
	Joohi <Joohi.rastogi@stericsson.com>, Vani <vani273@gmail.com>
Subject: [PATCH BlueZ 4/5] AVRCP: Register/Unregister Browsing handler
Date: Thu, 7 Jun 2012 17:03:45 +0530
Message-ID: <1339068825-23963-1-git-send-email-vani.patel@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add functions to register and unregister Browsing
handler
---
 audio/avctp.c |   28 ++++++++++++++++++++++++++++
 audio/avctp.h |    8 ++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 42eb7df..0b50611 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -159,6 +159,12 @@ struct avctp_pdu_handler {
 	unsigned int id;
 };
 
+struct avctp_browsing_pdu_handler {
+	avctp_browsing_pdu_cb cb;
+	void *user_data;
+	unsigned int id;
+};
+
 static struct {
 	const char *name;
 	uint8_t avc;
@@ -178,6 +184,7 @@ static GSList *callbacks = NULL;
 static GSList *servers = NULL;
 static GSList *control_handlers = NULL;
 static uint8_t id = 0;
+static struct avctp_browsing_pdu_handler *browsing_handler = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
 
@@ -1265,6 +1272,19 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 	return handler->id;
 }
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data)
+{
+	static unsigned int id = 0;
+
+	browsing_handler = g_new(struct avctp_browsing_pdu_handler, 1);
+	browsing_handler->cb = cb;
+	browsing_handler->user_data = user_data;
+	browsing_handler->id = ++id;
+
+	return browsing_handler->id;
+}
+
 gboolean avctp_unregister_pdu_handler(unsigned int id)
 {
 	GSList *l;
@@ -1283,6 +1303,14 @@ gboolean avctp_unregister_pdu_handler(unsigned int id)
 	return FALSE;
 }
 
+gboolean avctp_unregister_browsing_pdu_handler()
+{
+	if (browsing_handler)
+		g_free(browsing_handler);
+
+	return TRUE;
+}
+
 struct avctp *avctp_connect(const bdaddr_t *src, const bdaddr_t *dst)
 {
 	struct avctp *session;
diff --git a/audio/avctp.h b/audio/avctp.h
index b80e300..fa6eebf 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -83,6 +83,10 @@ typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
 typedef gboolean (*avctp_rsp_cb) (struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data);
+typedef void (*avctp_browsing_pdu_cb) (struct avctp *session,
+					uint8_t transaction,
+					uint8_t *operands, size_t operand_count,
+					void *user_data);
 
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
@@ -98,6 +102,10 @@ unsigned int avctp_register_pdu_handler(uint8_t opcode, avctp_control_pdu_cb cb,
 							void *user_data);
 gboolean avctp_unregister_pdu_handler(unsigned int id);
 
+unsigned int avctp_register_browsing_pdu_handler(avctp_browsing_pdu_cb cb,
+							void *user_data);
+
+gboolean avctp_unregister_browsing_pdu_handler();
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
-- 
1.7.0.4

