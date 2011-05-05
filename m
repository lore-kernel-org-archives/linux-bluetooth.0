Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2] Add partial mas.c - messages-*.c API.
Date: Thu,  5 May 2011 14:30:20 +0200
Message-Id: <1304598620-1442-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds stubs of functions needed for message browsing and retrieval.
---
Fixed typos pointed out by Daniele Forsi. Changes coming from
discussion on the IRC.

 plugins/messages-dummy.c |   71 ++++++++++++++
 plugins/messages.h       |  229 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 300 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index fd9679d..819f952 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -25,4 +25,75 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
+
 #include "messages.h"
+
+int messages_init(void)
+{
+	return 0;
+}
+
+void messages_exit(void)
+{
+}
+
+int messages_connect(void **session)
+{
+	*session = 0;
+	return 0;
+}
+
+void messages_disconnect(void *session)
+{
+}
+
+int messages_set_notification_registration(void *session,
+		void (*send_event)(void *session,
+			struct messages_event *event, void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+int messages_set_folder(void *session, const char *name, gboolean cdup)
+{
+	return -EINVAL;
+}
+
+int messages_get_folder_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset,
+		void (*callback)(void *session, int err, const char *name,
+			void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+int messages_get_messages_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset, struct messages_filter *filter,
+		uint16_t *size, gboolean *newmsg,
+		void (*callback)(void *session, int err,
+			const struct messages_message *message, void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+int messages_get_message(void *session,
+		const char *handle,
+		gboolean attachment, gboolean utf8,
+		gboolean fraction, gboolean next,
+		gboolean *fmore,
+		void (*callback)(void *session, int err, const char *chunk,
+			void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+void messages_abort(void *session)
+{
+}
diff --git a/plugins/messages.h b/plugins/messages.h
index c510244..1c4c9db 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -20,3 +20,232 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  *
  */
+
+#include <glib.h>
+#include <stdint.h>
+
+/* Those are used by backend to notify transport plugin which properties did it
+ * send.
+ */
+#define PMASK_SUBJECT			0x0001
+#define PMASK_DATETIME			0x0002
+#define PMASK_SENDER_NAME		0x0004
+#define PMASK_SENDER_ADDRESSING		0x0008
+#define PMASK_RECIPIENT_NAME		0x0010
+#define PMASK_RECIPIENT_ADDRESSING	0x0020
+#define PMASK_TYPE			0x0040
+#define PMASK_SIZE			0x0080
+#define PMASK_RECEPTION_STATUS		0x0100
+#define PMASK_TEXT			0x0200
+#define PMASK_ATTACHMENT_SIZE		0x0400
+#define PMASK_PRIORITY			0x0800
+#define PMASK_READ			0x1000
+#define PMASK_SENT			0x2000
+#define PMASK_PROTECTED			0x4000
+#define PMASK_REPLYTO_ADDRESSING	0x8000
+
+/* This one is used in a response to GetMessagesListing. Use PMASK_* values to
+ * notify the plugin which members are actually set. Backend shall not omit
+ * properties required by MAP specification (subject, datetime,
+ * recipient_addressing, type, size, reception_status, attachment_size) unless
+ * ordered by PARAMETERMASK. Boolean values should be probably
+ * always sent (need checking). Handle is mandatory. Plugin will filter out any
+ * properties that were not wanted by MCE.
+ *
+ * Handle shall be set to hexadecimal representation with upper-case letters. No
+ * prefix shall be appended and without no zeros. This corresponds to PTS
+ * behaviour described in comments to the MAP specification.
+ *
+ * The rest of char * fields shall be set according to the MAP specification
+ * rules.
+ */
+struct messages_message {
+	uint32_t mask;
+	char *handle;
+	char *subject;
+	char *datetime;
+	char *sender_name;
+	char *sender_addressing;
+	char *replyto_addressing;
+	char *recipient_name;
+	char *recipient_addressing;
+	char *type;
+	char *reception_status;
+	char *size;
+	char *attachment_size;
+	gboolean text;
+	gboolean read;
+	gboolean sent;
+	gboolean protect;
+	gboolean priority;
+};
+
+/* Type of message event to be delivered to MNS server */
+enum messages_event_type {
+	MET_NEW_MESSAGE,
+	MET_DELIVERY_SUCCESS,
+	MET_SENDING_SUCCESS,
+	MET_DELIVERY_FAILURE,
+	MET_SENDING_FAILURE,
+	MET_MEMORY_FULL,
+	MET_MEMORY_AVAILABLE,
+	MET_MESSAGE_DELETED,
+	MET_MESSAGE_SHIFT
+};
+
+/* Data for sending MNS notification. Handle shall be formatted as described in
+ * messages_message.
+ */
+struct messages_event {
+	enum messages_event_type type;
+	uint8_t instance_id;
+	char *handle;
+	char *folder;
+	char *old_folder;
+	char *msg_type;
+};
+
+/* parameter_mask: |-ed PMASK_* values
+ * See MAP specification for the rest.
+ */
+struct messages_filter {
+	uint32_t parameter_mask;
+	uint8_t type;
+	char *period_begin;
+	char *period_end;
+	uint8_t *read_status;
+	char *recipient;
+	char *originator;
+	uint8_t priority;
+};
+
+/* This is called once after server starts.
+ *
+ * Returns value less than zero if error. This will prevent MAP plugin from
+ * starting.
+ */
+int messages_init(void);
+
+/* This gets called right before server finishes
+ */
+void messages_exit(void);
+
+/* Starts a new MAP session.
+ *
+ * session: variable to store pointer to backend session data. This one shall be
+ * passed to all in-session calls.
+ *
+ * If session start succeeded, backend shall return 0. Otherwise the error value
+ * will be sent as a response to OBEX connect.
+ */
+int messages_connect(void **session);
+
+/* Closes a MAP session.
+ *
+ * This call should free buffer reserved by messages_connect.
+ */
+void messages_disconnect(void *session);
+
+/******************************************************************************
+ * NOTE on callbacks.
+ *
+ * All functions requiring callbacks have to call them asynchronously.
+ * 'user_data' is for passing arbitrary user data.
+ *
+ * If 'err' is negative it is used to send error to the
+ * OBEX request.
+ *
+ * The special case is err == -EAGAIN. This notifies transport
+ * plugin to not wake IO. This is especially useful to postpone sending
+ * application headers if backend did not set proper return values for
+ * parameters yet.
+ *
+ * In case of folder/message listing and get message, end of data is indicated
+ * by calling callback with parameter carrying data (e.g. chunk) set to NULL.
+ ******************************************************************************/
+
+/* Registers for messaging events notifications.
+ *
+ * session: Backend session.
+ * enable: If true, register, otherwise unregister.
+ * send_event: Function that will be called to indicate a new event.
+ */
+int messages_set_notification_registration(void *session,
+		void (*send_event)(void *session,
+			struct messages_event *event, void *user_data),
+		void *user_data);
+
+/* Changes current directory.
+ *
+ * session: Backend session.
+ * name: Subdirectory to go to. If empty or null and cdup is false, go to the
+ *	root directory.
+ * cdup: If true, go up one level first.
+ */
+int messages_set_folder(void *session, const char *name, gboolean cdup);
+
+/* Retrieves subdirectories listing from a current directory.
+ *
+ * session: Backend session.
+ * name: Optional subdirectory name (not strictly required by MAP).
+ * max: Maximum number of entries to retrieve.
+ * offset: Offset of the first entry.
+ *
+ * Callback shall be called for every entry of the listing. 'name' is the
+ * subdirectory name.
+ */
+int messages_get_folder_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset,
+		void (*callback)(void *session, int err, const char *name,
+			void *user_data),
+		void *user_data);
+
+/* Retrieves messages listing from a current directory.
+ *
+ * session: Backend session.
+ * name: Optional subdirectory name.
+ * max: Maximum number of entries to retrieve.
+ * filter: Filter to apply on returned message listing.
+ * size: Pointer to return message listing size.
+ * newmsg: Pointer to return indicator of presence of unread messages.
+ *
+ * Callback shall be called for every entry of the listing, giving message data
+ * in 'message'.
+ */
+int messages_get_messages_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset, struct messages_filter *filter,
+		uint16_t *size, gboolean *newmsg,
+		void (*callback)(void *session, int err,
+			const struct messages_message *message, void *user_data),
+		void *user_data);
+
+/* Retrieves bMessage object (see MAP specification, ch. 3.1.3) of a given
+ * message.
+ *
+ * session: Backend session.
+ * handle: Handle of the message to retrieve.
+ * attachment: Selects whether or not attachments (if any) are to be included.
+ * utf8: If true, convert message to utf-8. Otherwise use native encoding.
+ * fraction: If true, deliver fractioned message.
+ * next: If fraction is true this indicates whether to retrieve first fraction
+ *	or the next one.
+ * fmore: Pointer to return indicator of whether next fraction is available.
+ *
+ * Callback allows for returning bMessage in chunks.
+ */
+int messages_get_message(void *session,
+		const char *handle,
+		gboolean attachment, gboolean utf8,
+		gboolean fraction, gboolean next,
+		gboolean *fmore,
+		void (*callback)(void *session, int err, const char *chunk,
+			void *user_data),
+		void *user_data);
+
+/* Aborts currently pending request.
+ *
+ * session: Backend session.
+ */
+void messages_abort(void *session);
-- 
1.7.4.1

