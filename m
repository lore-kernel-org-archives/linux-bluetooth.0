Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] android/avrcp-lib: Add avrcp_set_passthrough_handlers
Date: Thu, 20 Feb 2014 16:40:55 +0200
Message-Id: <1392907255-29758-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392907255-29758-1-git-send-email-luiz.dentz@gmail.com>
References: <1392907255-29758-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds avrcp_set_passthrough_handlers which can be used to set
pass-through PDU handlers table and user data.
---
 android/avrcp-lib.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 android/avrcp-lib.h |  8 ++++++++
 2 files changed, 52 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index c508516..d46e3d3 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -98,6 +98,10 @@ struct avrcp {
 	const struct avrcp_control_handler *control_handlers;
 	void *control_data;
 	unsigned int control_id;
+
+	const struct avrcp_passthrough_handler *passthrough_handlers;
+	void *passthrough_data;
+	unsigned int passthrough_id;
 };
 
 void avrcp_shutdown(struct avrcp *session)
@@ -106,6 +110,9 @@ void avrcp_shutdown(struct avrcp *session)
 		if (session->control_id > 0)
 			avctp_unregister_pdu_handler(session->conn,
 							session->control_id);
+		if (session->passthrough_id > 0)
+			avctp_unregister_passthrough_handler(session->conn,
+						session->passthrough_id);
 		avctp_shutdown(session->conn);
 	}
 
@@ -168,6 +175,31 @@ reject:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+static bool handle_passthrough_pdu(struct avctp *conn, uint8_t op,
+						bool pressed, void *user_data)
+{
+	struct avrcp *session = user_data;
+	const struct avrcp_passthrough_handler *handler;
+
+	if (!session->passthrough_handlers)
+		return false;
+
+	for (handler = session->passthrough_handlers; handler->func;
+								handler++) {
+		if (handler->op == op)
+			break;
+	}
+
+	if (handler->func == NULL)
+		return false;
+
+	/* Do not trigger handler on release */
+	if (!pressed)
+		return true;
+
+	return handler->func(session);
+}
+
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 {
 	struct avrcp *session;
@@ -180,6 +212,10 @@ struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 		return NULL;
 	}
 
+	session->passthrough_id = avctp_register_passthrough_handler(
+							session->conn,
+							handle_passthrough_pdu,
+							session);
 	session->control_id = avctp_register_pdu_handler(session->conn,
 							AVC_OP_VENDORDEP,
 							handle_vendordep_pdu,
@@ -202,6 +238,14 @@ void avrcp_set_control_handlers(struct avrcp *session,
 	session->control_data = user_data;
 }
 
+void avrcp_set_passthrough_handlers(struct avrcp *session,
+			const struct avrcp_passthrough_handler *handlers,
+			void *user_data)
+{
+	session->passthrough_handlers = handlers;
+	session->passthrough_data = user_data;
+}
+
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address)
 {
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index 1a135cc..2337429 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -55,6 +55,11 @@ struct avrcp_control_handler {
 			uint16_t *params_len, uint8_t *params, void *user_data);
 };
 
+struct avrcp_passthrough_handler {
+	uint8_t op;
+	bool (*func) (struct avrcp *session);
+};
+
 typedef void (*avrcp_destroy_cb_t) (void *user_data);
 
 struct avrcp *avrcp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
@@ -64,5 +69,8 @@ void avrcp_set_destroy_cb(struct avrcp *session, avrcp_destroy_cb_t cb,
 void avrcp_set_control_handlers(struct avrcp *session,
 				const struct avrcp_control_handler *handlers,
 				void *user_data);
+void avrcp_set_passthrough_handlers(struct avrcp *session,
+			const struct avrcp_passthrough_handler *handlers,
+			void *user_data);
 int avrcp_init_uinput(struct avrcp *session, const char *name,
 							const char *address);
-- 
1.8.5.3

