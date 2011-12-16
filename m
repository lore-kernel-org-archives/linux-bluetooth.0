Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 3/3] map: Add basic GetMessage support
Date: Fri, 16 Dec 2011 14:23:10 +0100
Message-Id: <1324041790-17559-3-git-send-email-bulislaw@linux.com>
In-Reply-To: <1324041790-17559-1-git-send-email-bulislaw@linux.com>
References: <1324041790-17559-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/map.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
 test/map-client |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/client/map.c b/client/map.c
index cdd2725..1ee8b04 100644
--- a/client/map.c
+++ b/client/map.c
@@ -181,6 +181,50 @@ static DBusMessage *map_get_message_listing(DBusConnection *connection,
 	return NULL;
 }
 
+static DBusMessage *map_get_message(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct map_data *map = user_data;
+	int err;
+	const char *handle, *path, *transfer_path;
+	DBusMessageIter msg_iter;
+	struct obc_transfer *transfer;
+
+	dbus_message_iter_init(message, &msg_iter);
+
+	if (dbus_message_iter_get_arg_type(&msg_iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&msg_iter, &handle);
+
+	dbus_message_iter_next(&msg_iter);
+
+	if (dbus_message_iter_get_arg_type(&msg_iter) != DBUS_TYPE_ARRAY)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_next(&msg_iter);
+
+	if (dbus_message_iter_get_arg_type(&msg_iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
+
+	dbus_message_iter_get_basic(&msg_iter, &path);
+
+	err = obc_session_get(map->session, "x-bt/message", handle, path,
+							NULL, 0, NULL, NULL);
+	if (err < 0)
+		return g_dbus_create_error(message, "org.openobex.Error.Failed",
+									NULL);
+
+	transfer = obc_session_get_transfer(map->session);
+	transfer_path = obc_transfer_get_path(transfer);
+
+	return g_dbus_create_reply(message, DBUS_TYPE_OBJECT_PATH,
+					&transfer_path, DBUS_TYPE_INVALID);
+}
+
 static GDBusMethodTable map_methods[] = {
 	{ "SetFolder",		"s", "",	map_setpath,
 						G_DBUS_METHOD_FLAG_ASYNC },
@@ -188,6 +232,7 @@ static GDBusMethodTable map_methods[] = {
 						G_DBUS_METHOD_FLAG_ASYNC },
 	{ "GetMessageListing",	"sa{ss}", "s",	map_get_message_listing,
 						G_DBUS_METHOD_FLAG_ASYNC },
+	{ "GetMessage",		"sa{ss}s", "o",	map_get_message },
 	{ }
 };
 
diff --git a/test/map-client b/test/map-client
index 5c7c447..027d3e8 100755
--- a/test/map-client
+++ b/test/map-client
@@ -3,9 +3,45 @@
 import gobject
 
 import dbus
+import dbus.service
 import dbus.mainloop.glib
 from optparse import OptionParser
 
+class Agent(dbus.service.Object):
+    def __init__(self, conn=None, obj_path=None, verbose=False):
+        dbus.service.Object.__init__(self, conn, obj_path)
+        self.verbose = verbose
+
+    @dbus.service.method("org.openobex.Agent",
+                    in_signature="o", out_signature="s")
+    def Request(self, path):
+        return ""
+
+    @dbus.service.method("org.openobex.Agent",
+                    in_signature="ot", out_signature="")
+    def Progress(self, path, transferred):
+        if self.verbose:
+            print "Transfer progress (%d bytes)" % (transferred)
+        return
+
+    @dbus.service.method("org.openobex.Agent",
+                    in_signature="o", out_signature="")
+    def Complete(self, path):
+        if self.verbose:
+            print "Transfer finished"
+        mainloop.quit()
+
+    @dbus.service.method("org.openobex.Agent",
+                    in_signature="os", out_signature="")
+    def Error(self, path, error):
+        print "Transfer finished with an error: %s" % (error)
+        mainloop.quit()
+
+    @dbus.service.method("org.openobex.Agent",
+                    in_signature="", out_signature="")
+    def Release(self):
+        mainloop.quit()
+
 def parse_options():
     parser.add_option("-d", "--device", dest="device",
                       help="Device to connect", metavar="DEVICE")
@@ -16,6 +52,11 @@ def parse_options():
     parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
     parser.add_option("-L", "--lsmsg", action="store", dest="ls_msg",
                       help="List messages in supplied CWD subdir")
+    parser.add_option("-g", "--getmsg", action="store", dest="get_msg",
+		      metavar="HANDLE", help="Pull message with given handle")
+    parser.add_option("-f", "--dest-file", action="store", dest="dest_file",
+                      metavar="FILE", default="msg.bmsg",
+                      help="Local file to store message")
 
     return parser.parse_args()
 
@@ -38,6 +79,9 @@ if  __name__ == '__main__':
     bus = dbus.SessionBus()
     mainloop = gobject.MainLoop()
 
+    path = "/test/agent"
+    agent = Agent(bus, path, options.verbose)
+
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
 
@@ -47,6 +91,8 @@ if  __name__ == '__main__':
     session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.Session")
 
+    session.AssignAgent(path)
+
     map = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.MessageAccess")
 
@@ -59,4 +105,9 @@ if  __name__ == '__main__':
     if options.ls_msg is not None:
 	print map.GetMessageListing(options.ls_msg, dict())
 
+    if options.get_msg:
+        xfer = map.GetMessage(options.get_msg, dict(), options.dest_file)
+        if options.verbose:
+            print xfer
+
     mainloop.run()
-- 
1.7.4.1

