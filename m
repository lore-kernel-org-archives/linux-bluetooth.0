Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 5/6] session: add Source and Destination properties
Date: Tue, 28 May 2013 14:45:22 -0300
Message-Id: <1369763123-17949-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
References: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This is useful when we want to know where a incoming OPP transfer, for
example, is from.
---
 obexd/src/manager.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index b86565c..a116a3e 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -265,6 +265,30 @@ static DBusMessage *unregister_agent(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static gboolean get_source(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obex_session *os = data;
+	char *s;
+
+	s = os->src;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &s);
+
+	return TRUE;
+}
+
+static gboolean get_destination(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct obex_session *os = data;
+	char *s;
+
+	s = os->dst;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &s);
+
+	return TRUE;
+}
+
 static gboolean session_target_exists(const GDBusPropertyTable *property,
 								void *data)
 {
@@ -529,6 +553,8 @@ static const GDBusPropertyTable transfer_properties[] = {
 };
 
 static const GDBusPropertyTable session_properties[] = {
+	{ "Source", "s", get_source },
+	{ "Destination", "s", get_destination },
 	{ "Target", "s", get_target, NULL, session_target_exists },
 	{ "Root", "s", get_root },
 	{ }
-- 
1.8.1.4

