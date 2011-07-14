Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/2 v2] Add tracker backend stump for MAP
Date: Thu, 14 Jul 2011 16:07:39 +0200
Message-Id: <1310652459-16881-1-git-send-email-bulislaw@linux.com>
In-Reply-To: <20110714135911.GG2770@dell.ger.corp.intel.com>
References: <20110714135911.GG2770@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am                |    2 +-
 plugins/messages-tracker.c |   98 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletions(-)
 create mode 100644 plugins/messages-tracker.c

diff --git a/Makefile.am b/Makefile.am
index 14ab6e9..12d0b9c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -143,7 +143,7 @@ EXTRA_DIST = src/genbuiltin $(doc_files) $(test_files) \
 			src/obexd.service.in client/obex-client.service.in \
 			plugins/phonebook-dummy.c plugins/phonebook-ebook.c \
 			plugins/phonebook-tracker.c \
-			plugins/messages-dummy.c
+			plugins/messages-dummy.c plugins/messages-tracker.c
 
 DISTCHECK_CONFIGURE_FLAGS = --enable-client --enable-server
 
diff --git a/plugins/messages-tracker.c b/plugins/messages-tracker.c
new file mode 100644
index 0000000..88e7493
--- /dev/null
+++ b/plugins/messages-tracker.c
@@ -0,0 +1,98 @@
+/*
+ *
+ *  OBEX Server
+ *
+ *  Copyright (C) 2010-2011  Nokia Corporation
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include "messages.h"
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
+int messages_connect(void **s)
+{
+	*s = NULL;
+
+	return 0;
+}
+
+void messages_disconnect(void *s)
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
+int messages_set_folder(void *s, const char *name, gboolean cdup)
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
-- 
1.7.4.1

