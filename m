Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/4] session: only add Target if it exists
Date: Mon, 27 May 2013 20:07:01 -0300
Message-Id: <1369696024-27434-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 obexd/src/manager.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index b67567b..b86565c 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -265,6 +265,14 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean session_target_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct obex_session *os = data;
+
+	return os->service->target ? TRUE : FALSE;
+}
+
 static char *target2str(const uint8_t *t)
 {
 	if (!t)
@@ -521,7 +529,7 @@ static const GDBusPropertyTable transfer_properties[] = {
 };
 
 static const GDBusPropertyTable session_properties[] = {
-	{ "Target", "s", get_target },
+	{ "Target", "s", get_target, NULL, session_target_exists },
 	{ "Root", "s", get_root },
 	{ }
 };
-- 
1.8.1.4

