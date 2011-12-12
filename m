Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 4/4] Add support for PullMessagesListing in MAP client
Date: Mon, 12 Dec 2011 16:31:07 +0100
Message-Id: <1323703867-20577-4-git-send-email-bulislaw@linux.com>
In-Reply-To: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
References: <1323703867-20577-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just basic functionality for now, returning whole listing as a string
(no parsing) and no apparams handling.
---
 client/map.c    |   30 ++++++++++++++++++++++++++++++
 test/map-client |    5 +++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/client/map.c b/client/map.c
index 0511e4c..f37a8b6 100644
--- a/client/map.c
+++ b/client/map.c
@@ -153,11 +153,41 @@ static DBusMessage *map_get_folder_listing(DBusConnection *connection,
 	return NULL;
 }
 
+static DBusMessage *map_get_messages_listing(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	int err;
+	const char *folder;
+	DBusMessageIter msg_iter;
+
+	dbus_message_iter_init(message, &msg_iter);
+
+	if (dbus_message_iter_get_arg_type(&msg_iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&msg_iter, &folder);
+
+	err = obc_session_get(map->session, "x-bt/MAP-msg-listing", folder,
+							NULL, NULL, 0,
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
 	{ "SetFolder",		"s", "",	map_setpath,
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetFolderListing",	"a{ss}", "s",	map_get_folder_listing,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetMessagesListing",	"sa{ss}", "s",	map_get_messages_listing,
+						G_DBUS_METHOD_FLAG_ASYNC },
 	{ }
 };
 
diff --git a/test/map-client b/test/map-client
index bcd2e66..1a4afdb 100755
--- a/test/map-client
+++ b/test/map-client
@@ -14,6 +14,8 @@ def parse_options():
     parser.add_option("-l", "--lsdir", action="store_true", dest="ls_dir",
                       help="List folders in current directory")
     parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
+    parser.add_option("-L", "--lsmsg", action="store", dest="ls_msg",
+                      help="List messages in supplied CWD subdir")
 
     return parser.parse_args()
 
@@ -54,4 +56,7 @@ if  __name__ == '__main__':
     if options.ls_dir:
         print map.GetFolderListing(dict())
 
+    if options.ls_msg is not None:
+	print map.GetMessagesListing(options.ls_msg, dict())
+
     mainloop.run()
-- 
1.7.4.1

