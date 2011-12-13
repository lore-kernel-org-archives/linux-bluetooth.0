Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 19/20] client: PhonebookAccess sessions return transfers
Date: Tue, 13 Dec 2011 17:44:22 +0100
Message-ID: <1323794663-2711-20-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/pbap.c    |  128 ++++++++++++++++++++----------------
 test/pbap-client |  193 ++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 229 insertions(+), 92 deletions(-)

diff --git a/client/pbap.c b/client/pbap.c
index 6e5d2b7..2d10f0d 100644
--- a/client/pbap.c
+++ b/client/pbap.c
@@ -411,39 +411,6 @@ static void read_return_apparam(const struct obc_transfer *transfer,
 	}
 }
 
-static void pull_phonebook_callback(struct obc_session *session,
-					GError *err,
-					const struct obc_transfer *transfer,
-					void *user_data)
-{
-	struct pbap_data *pbap = user_data;
-	DBusMessage *reply;
-	const void *buf;
-
-	if (pbap->msg == NULL)
-		return;
-
-	if (err) {
-		reply = g_dbus_create_error(pbap->msg,
-						"org.openobex.Error.Failed",
-						"%s", err->message);
-		goto send;
-	}
-
-	reply = dbus_message_new_method_return(pbap->msg);
-
-	buf = obc_transfer_get_buffer(transfer);
-
-	dbus_message_append_args(reply,
-			DBUS_TYPE_STRING, &buf,
-			DBUS_TYPE_INVALID);
-
-send:
-	g_dbus_send_message(conn, reply);
-	dbus_message_unref(pbap->msg);
-	pbap->msg = NULL;
-}
-
 static void phonebook_size_callback(struct obc_session *session,
 					GError *err,
 					const struct obc_transfer *transfer,
@@ -521,13 +488,17 @@ send:
 
 static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 					DBusMessage *message, guint8 type,
-					const char *name, uint64_t filter,
+					const char *name,
+					const char *targetname,
+					uint64_t filter,
 					guint8 format, guint16 maxlistcount,
-					guint16 liststartoffset)
+					guint16 liststartoffset,
+					struct obc_transfer **result_transfer)
 {
 	struct pullphonebook_apparam apparam;
 	session_transfer_callback_t func;
 	gboolean dbus_expose;
+	struct obc_transfer *transfer;
 	int err;
 
 	if (pbap->msg)
@@ -550,7 +521,7 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 
 	switch (type) {
 	case PULLPHONEBOOK:
-		func = pull_phonebook_callback;
+		func = NULL;
 		dbus_expose = TRUE;
 		break;
 	case GETPHONEBOOKSIZE:
@@ -562,14 +533,26 @@ static DBusMessage *pull_phonebook(struct pbap_data *pbap,
 		return NULL;
 	}
 
-	if (obc_session_get_mem(pbap->session, "x-bt/phonebook", name,
-					(guint8 *) &apparam, sizeof(apparam),
-					func, pbap, dbus_expose, &err) == NULL)
+	if (targetname != NULL)
+		transfer = obc_session_get(pbap->session, "x-bt/phonebook",
+					name, targetname,
+					&apparam, sizeof(apparam),
+					func, pbap, dbus_expose, &err);
+	else
+		transfer = obc_session_get_mem(pbap->session, "x-bt/phonebook",
+					name, &apparam, sizeof(apparam),
+					func, pbap, dbus_expose, &err);
+
+	if (err < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"%s", strerror(err));
 
-	pbap->msg = dbus_message_ref(message);
+	if (result_transfer != NULL)
+		*result_transfer = transfer;
+
+	if (func != NULL)
+		pbap->msg = dbus_message_ref(message);
 
 	return NULL;
 }
@@ -801,18 +784,40 @@ static DBusMessage *pbap_pull_all(DBusConnection *connection,
 	struct pbap_data *pbap = user_data;
 	DBusMessage * err;
 	char *name;
+	const char *target_file;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
+
+	if (dbus_message_get_args(message, NULL,
+				DBUS_TYPE_STRING, &target_file,
+				DBUS_TYPE_INVALID) == FALSE)
+		return g_dbus_create_error(message,
+				"org.openobex.Error.InvalidArguments", NULL);
 
 	if (!pbap->path)
 		return g_dbus_create_error(message,
-				ERROR_INF ".Forbidden", "Call Select first of all");
+			ERROR_INF ".Forbidden", "Call Select first of all");
 
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	err = pull_phonebook(pbap, message, PULLPHONEBOOK, name,
+	err = pull_phonebook(pbap, message, PULLPHONEBOOK, name, target_file,
 				pbap->filter, pbap->format,
-				DEFAULT_COUNT, DEFAULT_OFFSET);
+				DEFAULT_COUNT, DEFAULT_OFFSET, &transfer);
 	g_free(name);
-	return err;
+
+	if (err != NULL)
+		return err;
+
+	path = obc_transfer_get_path(transfer);
+
+	reply = dbus_message_new_method_return(message);
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
@@ -820,7 +825,10 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 {
 	struct pbap_data *pbap = user_data;
 	struct pullvcardentry_apparam apparam;
-	const char *name;
+	const char *name, *target_file;
+	DBusMessage *reply;
+	struct obc_transfer *transfer;
+	const char *path;
 	int err;
 
 	if (!pbap->path)
@@ -830,6 +838,7 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 
 	if (dbus_message_get_args(message, NULL,
 			DBUS_TYPE_STRING, &name,
+			DBUS_TYPE_STRING, &target_file,
 			DBUS_TYPE_INVALID) == FALSE)
 		return g_dbus_create_error(message,
 				ERROR_INF ".InvalidArguments", NULL);
@@ -846,15 +855,24 @@ static DBusMessage *pbap_pull_vcard(DBusConnection *connection,
 	apparam.format_len = FORMAT_LEN;
 	apparam.format = pbap->format;
 
-	if (obc_session_get_mem(pbap->session, "x-bt/vcard", name,
-			(guint8 *) &apparam, sizeof(apparam),
-			pull_phonebook_callback, pbap, TRUE, &err) == NULL)
+	transfer = obc_session_get(pbap->session, "x-bt/vcard", name,
+			target_file, &apparam, sizeof(apparam),
+			NULL, NULL, TRUE, &err);
+
+	if (err < 0)
 		return g_dbus_create_error(message,
 				"org.openobex.Error.Failed",
 				"%s", strerror(err));
 
-	pbap->msg = dbus_message_ref(message);
-	return NULL;
+	path = obc_transfer_get_path(transfer);
+
+	reply = dbus_message_new_method_return(message);
+
+	dbus_message_append_args(reply,
+			DBUS_TYPE_OBJECT_PATH, &path,
+			DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage *pbap_list(DBusConnection *connection,
@@ -917,9 +935,9 @@ static DBusMessage *pbap_get_size(DBusConnection *connection,
 
 	name = g_strconcat(pbap->path, ".vcf", NULL);
 
-	err = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name,
+	err = pull_phonebook(pbap, message, GETPHONEBOOKSIZE, name, NULL,
 				pbap->filter, pbap->format, 0,
-				DEFAULT_OFFSET);
+				DEFAULT_OFFSET, NULL);
 	g_free(name);
 	return err;
 }
@@ -1032,10 +1050,8 @@ static DBusMessage *pbap_list_filter_fields(DBusConnection *connection,
 static GDBusMethodTable pbap_methods[] = {
 	{ "Select",	"ss",	"",	pbap_select,
 					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "PullAll",	"",	"s",	pbap_pull_all,
-					G_DBUS_METHOD_FLAG_ASYNC },
-	{ "Pull",	"s",	"s",	pbap_pull_vcard,
-					G_DBUS_METHOD_FLAG_ASYNC },
+	{ "PullAll",	"s",	"o",	pbap_pull_all },
+	{ "Pull",	"ss",	"o",	pbap_pull_vcard },
 	{ "List",	"",	"a(ss)",	pbap_list,
 					G_DBUS_METHOD_FLAG_ASYNC },
 	{ "Search",	"ss",	"a(ss)",	pbap_search,
diff --git a/test/pbap-client b/test/pbap-client
index ecca14f..c574580 100755
--- a/test/pbap-client
+++ b/test/pbap-client
@@ -1,41 +1,162 @@
 #!/usr/bin/python
 
+import gobject
+
 import sys
 import dbus
+import dbus.service
+import dbus.mainloop.glib
+
+class Transfer:
+    def __init__(self, callback_func):
+        self.callback_func = callback_func
+        self.path = None
+        self.filename = None
+
+class PbapClient:
+    def __init__(self, session_path):
+        self.pending_transfers = 0
+        self.transfer_dict = dict()
+        self.flush_func = None
+        bus = dbus.SessionBus()
+        self.session = dbus.Interface(bus.get_object("org.openobex.client",
+                                                     session_path),
+                                      "org.openobex.Session")
+        self.pbap = dbus.Interface(bus.get_object("org.openobex.client",
+                                                  session_path),
+                                   "org.openobex.PhonebookAccess")
+        bus.add_signal_receiver(
+            self.transfer_added,
+            dbus_interface="org.openobex.Session",
+            signal_name="TransferAdded")
+        bus.add_signal_receiver(
+            self.transfer_complete,
+            dbus_interface="org.openobex.Transfer",
+            signal_name="Complete",
+            path_keyword="path")
+        bus.add_signal_receiver(
+            self.transfer_error,
+            dbus_interface="org.openobex.Transfer",
+            signal_name="Error",
+            path_keyword="path")
+
+    def register(self, path, transfer):
+        print "Transfer created: %s" % path
+        transfer.path = path
+        self.transfer_dict[path] = transfer
+
+    def error(self, err):
+        print err
+        mainloop.quit()
+
+    def transfer_added(self, path, properties):
+        req = self.transfer_dict.get(path)
+        if req == None:
+            return
+        req.filename = properties.get("Location")
+
+    def transfer_complete(self, path):
+        req = self.transfer_dict.get(path)
+        if req == None:
+            return
+        self.pending_transfers -= 1
+        print "Transfer %s finished an stored in %s" % (path, req.filename)
+        f = open(req.filename, "r")
+        lines = f.readlines()
+        del self.transfer_dict[path]
+        req.callback_func(lines)
+
+        if (len(self.transfer_dict) == 0) and (self.pending_transfers == 0):
+            if self.flush_func != None:
+                f = self.flush_func
+                self.flush_func = None
+                f()
+
+    def transfer_error(self, error, path):
+        req = self.transfer_dict.get(path)
+        if req == None:
+            return
+        print "Transfer %s finished with an error: %s" % (path, error)
+        mainloop.quit()
+
+    def pull(self, vcard, func):
+        req = Transfer(func)
+        self.pbap.Pull(vcard, "",
+                       reply_handler=lambda p: self.register(p, req),
+                       error_handler=self.error)
+        self.pending_transfers += 1
+
+    def pull_all(self, func):
+        req = Transfer(func)
+        self.pbap.PullAll("",
+                          reply_handler=lambda p: self.register(p, req),
+                          error_handler=self.error)
+        self.pending_transfers += 1
+
+    def flush_transfers(self, func):
+        if (len(self.transfer_dict) == 0) and (self.pending_transfers == 0):
+            return
+        self.flush_func = func
+
+    def interface(self):
+        return self.pbap
+
+if  __name__ == '__main__':
+
+    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+
+    bus = dbus.SessionBus()
+    mainloop = gobject.MainLoop()
+
+    client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
+                            "org.openobex.Client")
+
+    if (len(sys.argv) < 2):
+	print "Usage: %s <device>" % (sys.argv[0])
+	sys.exit(1)
+
+    print "Creating Session"
+    session_path = client.CreateSession(sys.argv[1], { "Target": "PBAP" })
+
+    pbap_client = PbapClient(session_path)
+
+    def process_result(lines, header):
+        if header != None:
+            print header
+        for line in lines:
+            print line,
+        print
+
+    def test_paths(paths):
+        if len(paths) == 0:
+            print
+            print "FINISHED"
+            mainloop.quit()
+            return
+
+        path = paths[0]
+
+        print "\n--- Select Phonebook %s ---\n" % (path)
+        pbap_client.interface().Select("int", path)
+
+        print "\n--- GetSize ---\n"
+        ret = pbap_client.interface().GetSize()
+        print "Size = %d\n" % (ret)
+
+        print "\n--- List vCard ---\n"
+        ret = pbap_client.interface().List()
+        for item in ret:
+            print "%s : %s" % (item[0], item[1])
+            pbap_client.interface().SetFormat("vcard30")
+            pbap_client.interface().SetFilter(["VERSION", "FN", "TEL"]);
+            pbap_client.pull(item[0], lambda x: process_result(x, None))
+
+        pbap_client.interface().SetFormat("vcard30")
+        pbap_client.interface().SetFilter(["VERSION", "FN", "TEL"]);
+        pbap_client.pull_all(lambda x: process_result(x, "\n--- PullAll ---\n"))
+
+        pbap_client.flush_transfers(lambda: test_paths(paths[1:]))
+
+    test_paths(["PB", "ICH", "OCH", "MCH", "CCH"])
 
-bus = dbus.SessionBus()
-
-client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
-						"org.openobex.Client")
-
-print "Creating Session"
-session_path = client.CreateSession(sys.argv[1], { "Target": "PBAP" })
-pbap = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-						"org.openobex.PhonebookAccess")
-session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-							"org.openobex.Session")
-
-paths = ["PB", "ICH", "OCH", "MCH", "CCH"]
-
-for path in paths:
-	print "\n--- Select Phonebook %s ---\n" % (path)
-	pbap.Select("int", path)
-
-	print "\n--- GetSize ---\n"
-	ret = pbap.GetSize()
-	print "Size = %d\n" % (ret)
-
-	print "\n--- List vCard ---\n"
-	ret = pbap.List()
-	for item in ret:
-		print "%s : %s" % (item[0], item[1])
-		pbap.SetFormat("vcard30")
-		pbap.SetFilter(["VERSION", "FN", "TEL"]);
-		ret = pbap.Pull(item[0])
-		print "%s" % (ret)
-
-	print "\n--- PullAll ---\n"
-	pbap.SetFormat("vcard30")
-	pbap.SetFilter(["VERSION", "FN", "TEL"]);
-	ret = pbap.PullAll()
-	print "%s" % (ret)
+    mainloop.run()
-- 
1.7.6.4

