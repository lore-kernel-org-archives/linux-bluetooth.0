Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v4] Add partial mas.c - messages-*.c API.
Date: Fri,  6 May 2011 10:48:15 +0200
Message-Id: <1304671695-6153-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds stubs of functions needed for message browsing and retrieval.
---
Changes according to the discussion on the IRC. Changed the way the
parameters are returned. Some documentation changes. Packed boolean
arguments to messages_get_message into a single bit mask.

 plugins/messages-dummy.c |   69 +++++++++++++
 plugins/messages.h       |  245 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 314 insertions(+), 0 deletions(-)

diff --git a/plugins/messages-dummy.c b/plugins/messages-dummy.c
index fd9679d..a536d81 100644
--- a/plugins/messages-dummy.c
+++ b/plugins/messages-dummy.c
@@ -25,4 +25,73 @@
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
+		void (*callback)(void *session, int err, uint16_t size,
+			const char *name, void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+int messages_get_messages_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset, struct messages_filter *filter,
+		void (*callback)(void *session, int err, uint16_t size,
+			gboolean newmsg, const struct messages_message *message,
+			void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+int messages_get_message(void *session,
+		const char *handle,
+		unsigned long flags,
+		void (*callback)(void *session, int err, gboolean fmore,
+			const char *chunk, void *user_data),
+		void *user_data)
+{
+	return -EINVAL;
+}
+
+void messages_abort(void *session)
+{
+}
diff --git a/plugins/messages.h b/plugins/messages.h
index c510244..c862b07 100644
--- a/plugins/messages.h
+++ b/plugins/messages.h
@@ -20,3 +20,248 @@
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
+ * Functions for GetMessagesListing, GetFolder listing and GetMessage call their
+ * callbacks multiple times - one for each listing entry or message body chunk.
+ * To indicate the end of operation backend must call callback with the data
+ * pointer parameter set to NULL.
+ *
+ * If err == -EAGAIN the transport * plugin does not wake IO.
+ *
+ * Keep in mind that application parameters has to be send first. Therefore the
+ * first time err == 0 and thus sending is started, callback will use provided
+ * parameters (e.g. size in case of folder listing) to build applications
+ * parameters header used in response. In any other case those parameters will
+ * be ignored.
+ *
+ * If err != 0 && err != -EAGAIN, the operation is finished immediately and err
+ * value is used to set the error code in OBEX response.
+ ******************************************************************************/
+
+/* Registers for messaging events notifications.
+ *
+ * session: Backend session.
+ * send_event: Function that will be called to indicate a new event.
+ *
+ * To unregister currently registered notifications, call this with send_event
+ * set to NULL.
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
+ * size: Total size of listing to be returned.
+ *
+ * Callback shall be called for every entry of the listing. 'name' is the
+ * subdirectory name.
+ */
+int messages_get_folder_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset,
+		void (*callback)(void *session, int err, uint16_t size,
+			const char *name, void *user_data),
+		void *user_data);
+
+/* Retrieves messages listing from a current directory.
+ *
+ * session: Backend session.
+ * name: Optional subdirectory name.
+ * max: Maximum number of entries to retrieve.
+ * filter: Filter to apply on returned message listing.
+ * size: Total size of listing to be returned.
+ * newmsg: Indicates presence of unread messages.
+ *
+ * Callback shall be called for every entry of the listing, giving message data
+ * in 'message'.
+ */
+int messages_get_messages_listing(void *session,
+		const char *name,
+		uint16_t max, uint16_t offset, struct messages_filter *filter,
+		void (*callback)(void *session, int err, uint16_t size,
+			gboolean newmsg, const struct messages_message *message,
+			void *user_data),
+		void *user_data);
+
+#define MESSAGES_ATTACHMENT	(1 << 0)
+#define MESSAGES_UTF8		(1 << 1)
+#define MESSAGES_FRACTION	(1 << 2)
+#define MESSAGES_NEXT		(1 << 3)
+
+/* Retrieves bMessage object (see MAP specification, ch. 3.1.3) of a given
+ * message.
+ *
+ * session: Backend session.
+ * handle: Handle of the message to retrieve.
+ * flags: or-ed mask of following:
+ *	MESSAGES_ATTACHMENT: Selects whether or not attachments (if any) are to
+ *		be included.
+ *	MESSAGES_UTF8: If true, convert message to utf-8. Otherwise use native
+ *		encoding.
+ *	MESSAGES_FRACTION: If true, deliver fractioned message.
+ *	MESSAGES_NEXT: If fraction is true this indicates whether to retrieve
+ *		first fraction
+ *	or the next one.
+ * fmore: Indicates whether next fraction is available.
+ * chunk: chunk of bMessage body
+ *
+ * Callback allows for returning bMessage in chunks.
+ */
+int messages_get_message(void *session,
+		const char *handle,
+		unsigned long flags,
+		void (*callback)(void *session, int err, gboolean fmore,
+			const char *chunk, void *user_data),
+		void *user_data);
+
+/* Aborts currently pending request.
+ *
+ * session: Backend session.
+ */
+void messages_abort(void *session);
-- 
1.7.4.1

