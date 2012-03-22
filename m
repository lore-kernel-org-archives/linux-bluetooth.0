Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 5/7] media: add dbus method MediaTransport.Reconfigure
Date: Thu, 22 Mar 2012 17:37:53 +0100
Message-Id: <1332434275-25394-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/transport.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index 38e44c2..f9b924a 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -837,6 +837,22 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static DBusMessage *reconfigure(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	DBusMessageIter iter;
+	const char *endpoint;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+	dbus_message_iter_get_basic(&iter, &endpoint);
+
+
+	return NULL;
+}
+
 static void get_properties_a2dp(struct media_transport *transport,
 						DBusMessageIter *dict)
 {
@@ -950,6 +966,8 @@ static GDBusMethodTable transport_methods[] = {
 	{ "Release",		"s",	"",		release,
 						G_DBUS_METHOD_FLAG_ASYNC},
 	{ "SetProperty",	"sv",	"",		set_property },
+	{ "Reconfigure",	"s",	"",		reconfigure,
+						G_DBUS_METHOD_FLAG_ASYNC},
 	{ },
 };
 
-- 
1.7.5.4

