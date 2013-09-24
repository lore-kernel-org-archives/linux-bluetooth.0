Return-Path: <cyrus@holtmann.org>
From: Wu Zheng <wu.zheng@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Wu Zheng <wu.zheng@intel.com>
Subject: [PATCH 1/2] obexd:Add Operation property to transfer properties
Date: Tue, 24 Sep 2013 15:37:01 +0800
Message-Id: <1380008221-30501-1-git-send-email-wu.zheng@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sometime, operation property is needed by the Bluetooth APP.
Therefore, add the property to transfer properties
---
 obexd/src/manager.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index f64b7b9..96976ec 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -35,6 +35,7 @@
 
 #include <btio/btio.h>
 #include <gobex/gobex.h>
+#include <gobex/gobex-packet.h>
 
 #include "obexd.h"
 #include "obex.h"
@@ -515,6 +516,41 @@ static gboolean transfer_get_filename(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean transfer_operation_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct obex_transfer *transfer = data;
+	struct obex_session *session = transfer->session;
+
+	if (session->cmd == G_OBEX_OP_PUT &&
+				session->size != OBJECT_SIZE_DELETE)
+		return TRUE;
+	else if (session->cmd == G_OBEX_OP_GET)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+static gboolean transfer_get_operation(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obex_transfer *transfer = data;
+	struct obex_session *session = transfer->session;
+	const char *operation;
+
+	if (session->cmd == G_OBEX_OP_PUT &&
+				session->size != OBJECT_SIZE_DELETE)
+		operation = "PUT";
+	else if (session->cmd == G_OBEX_OP_GET)
+		operation = "GET";
+	else
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &operation);
+
+	return TRUE;
+}
+
 static gboolean transfer_get_transferred(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -549,6 +585,8 @@ static const GDBusPropertyTable transfer_properties[] = {
 	{ "Time", "t", transfer_get_time, NULL, transfer_time_exists },
 	{ "Filename", "s", transfer_get_filename, NULL,
 						transfer_filename_exists },
+	{ "Operation", "s", transfer_get_operation, NULL,
+						transfer_operation_exists },
 	{ "Transferred", "t", transfer_get_transferred },
 	{ }
 };
-- 
1.7.7

