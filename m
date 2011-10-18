Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/2] Fix leak of dbus message
Date: Tue, 18 Oct 2011 21:24:39 -0200
Message-Id: <1318980279-2331-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1318980279-2331-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1318980279-2331-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/mpris-player.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/test/mpris-player.c b/test/mpris-player.c
index 9e63b4b..29bea46 100644
--- a/test/mpris-player.c
+++ b/test/mpris-player.c
@@ -122,6 +122,7 @@ static dbus_bool_t emit_property_changed(DBusConnection *conn,
 {
 	DBusMessage *signal;
 	DBusMessageIter iter;
+	dbus_bool_t result;
 
 	signal = dbus_message_new_signal(path, interface, "PropertyChanged");
 
@@ -137,7 +138,10 @@ static dbus_bool_t emit_property_changed(DBusConnection *conn,
 
 	append_variant(&iter, type, value);
 
-	return dbus_connection_send(conn, signal, NULL);
+	result = dbus_connection_send(conn, signal, NULL);
+	dbus_message_unref(signal);
+
+	return result;
 }
 
 static int parse_property(DBusConnection *conn, const char *path,
-- 
1.7.7

