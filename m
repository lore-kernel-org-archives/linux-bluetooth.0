Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/4] Add basic support for MAP folder listing
Date: Mon, 12 Dec 2011 16:31:06 +0100
Message-Id: <1323703867-20577-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For now just basic functionality - returning whole listing as a string
(no parsing for now) and no apparams handling.
---
 client/map.c    |   54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 test/map-client |    5 +++++
 2 files changed, 58 insertions(+), 1 deletions(-)

diff --git a/client/map.c b/client/map.c
index 51a7711..0511e4c 100644
--- a/client/map.c
+++ b/client/map.c
@@ -104,8 +104,60 @@ static DBusMessage *map_setpath(DBusConnection *connection,
 	return NULL;
 }
 
+static void buffer_cb(struct obc_session *session, GError *err,
+							void *user_data)
+{
+	struct obc_transfer *transfer = obc_session_get_transfer(session);
+	struct map_data *map = user_data;
+	DBusMessage *reply;
+	const char *buf;
+	int size;
+
+	if (err != NULL) {
+		reply = g_dbus_create_error(map->msg,
+						"org.openobex.Error.Failed",
+						"%s", err->message);
+		goto done;
+	}
+
+	buf = obc_transfer_get_buffer(transfer, &size);
+	if (size == 0)
+		buf = "";
+
+	reply = g_dbus_create_reply(map->msg, DBUS_TYPE_STRING, &buf,
+							DBUS_TYPE_INVALID);
+
+	obc_transfer_clear_buffer(transfer);
+
+done:
+	g_dbus_send_message(conn, reply);
+	dbus_message_unref(map->msg);
+	obc_transfer_unregister(transfer);
+}
+
+static DBusMessage *map_get_folder_listing(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	int err;
+
+	err = obc_session_get(map->session, "x-obex/folder-listing",
+							NULL, NULL, NULL, 0,
+							buffer_cb, map);
+	if (err < 0)
+		return g_dbus_create_error(message, "org.openobex.Error.Failed",
+									NULL);
+
+	map->msg = dbus_message_ref(message);
+
+	return NULL;
+}
+
 static GDBusMethodTable map_methods[] = {
-	{ "SetFolder",	"s",	"",	map_setpath, G_DBUS_METHOD_FLAG_ASYNC },
+	{ "SetFolder",		"s", "",	map_setpath,
+						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetFolderListing",	"a{ss}", "s",	map_get_folder_listing,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
diff --git a/test/map-client b/test/map-client
index 5ee4331..bcd2e66 100755
--- a/test/map-client
+++ b/test/map-client
@@ -11,6 +11,8 @@ def parse_options():
                       help="Device to connect", metavar="DEVICE")
     parser.add_option("-c", "--chdir", dest="new_dir",
                       help="Change current directory to DIR", metavar="DIR")
+    parser.add_option("-l", "--lsdir", action="store_true", dest="ls_dir",
+                      help="List folders in current directory")
     parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
 
     return parser.parse_args()
@@ -49,4 +51,7 @@ if  __name__ == '__main__':
     if options.new_dir:
         set_folder(map, options.new_dir)
 
+    if options.ls_dir:
+        print map.GetFolderListing(dict())
+
     mainloop.run()
-- 
1.7.4.1

