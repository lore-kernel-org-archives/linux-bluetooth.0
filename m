Return-Path: <cyrus@holtmann.org>
From: martin.xu@linux.intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Martin Xu <martin.xu@linux.intel.com>
Subject: [PATCH] obex/session: Export the right target uuid
Date: Thu, 18 Jul 2013 10:38:30 +0800
Message-Id: <1374115110-11780-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Xu <martin.xu@linux.intel.com>

---
 obexd/client/session.c |   20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 361c921..f451093 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -675,13 +675,27 @@ static const GDBusMethodTable session_methods[] = {
 	{ }
 };
 
+static char *target2str(const uint8_t *t)
+{
+	if (t == NULL)
+		return NULL;
+
+	return g_strdup_printf("%02X%02X%02X%02X-%02X%02X-%02X%02X-"
+				"%02X%02X-%02X%02X%02X%02X%02X%02X",
+				t[0], t[1], t[2], t[3], t[4], t[5], t[6], t[7],
+				t[8], t[9], t[10], t[11], t[12], t[13], t[14],
+				t[15]);
+}
+
 static gboolean get_target(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct obc_session *session = data;
+	char *uuid;
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
-						&session->driver->uuid);
+	uuid = target2str(session->driver->target);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
+	g_free(uuid);
 
 	return TRUE;
 }
@@ -690,7 +704,7 @@ static gboolean target_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct obc_session *session = data;
 
-	return session->driver->uuid != NULL;
+	return session->driver->target != NULL;
 }
 
 static const GDBusPropertyTable session_properties[] = {
-- 
1.7.10.4

