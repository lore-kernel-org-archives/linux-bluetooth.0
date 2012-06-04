Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 12/15] client-test: ftp-client uses new API
Date: Mon,  4 Jun 2012 11:37:55 +0200
Message-Id: <1338802678-7009-13-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338802678-7009-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

---
 test/ftp-client |  159 +++++++++++++++++++++++++++++++++---------------------
 1 files changed, 97 insertions(+), 62 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index 8421ade..f8c33e9 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -32,56 +32,94 @@ def parse_options():
 
     return parser.parse_args()
 
-def error(err):
-    print err
-
-def void_reply():
-    pass
-
-def transfer_complete():
-    if options.verbose:
-        print "Transfer finished"
-    mainloop.quit()
-
-def change_folder(session, new_dir):
-    for node in new_dir.split("/"):
-        session.ChangeFolder(node)
-
-def list_folder(session):
-    for i in session.ListFolder():
-        if i["Type"] == "folder":
-            print "%s/" % (i["Name"])
-        else:
-            print "%s" % (i["Name"])
-
-def put_file(session, filename):
-    session.PutFile(os.path.abspath(filename),
-                    os.path.basename(filename),
-                    reply_handler=transfer_complete,
-                    error_handler=error)
-
-def get_file(session, filename):
-    session.GetFile(os.path.abspath(filename),
-                    os.path.basename(filename),
-                    reply_handler=transfer_complete,
-                    error_handler=error)
-
-def remove_file(session, filename):
-    session.Delete(filename,
-                    reply_handler=void_reply,
-                    error_handler=error)
-
-def move_file(session, filename, destname):
-    session.MoveFile(filename,
-                    destname,
-                    reply_handler=void_reply,
-                    error_handler=error)
-
-def copy_file(session, filename, destname):
-    session.CopyFile(filename,
-                    destname,
-                    reply_handler=void_reply,
-                    error_handler=error)
+class FtpClient:
+    def __init__(self, session_path, verbose=False):
+        self.transfer_path = None
+        self.verbose = verbose
+        bus = dbus.SessionBus()
+        self.session = dbus.Interface(bus.get_object("org.openobex.client",
+                                                     session_path),
+                                      "org.openobex.Session")
+        self.ftp = dbus.Interface(bus.get_object("org.openobex.client",
+                                                 session_path),
+                                  "org.openobex.FileTransfer")
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
+    def create_transfer_reply(self, reply):
+        (path, properties) = reply
+        self.transfer_path = path
+        if self.verbose:
+            print "Transfer created: %s" % path
+
+    def generic_reply(self):
+        if self.verbose:
+            print "Operation succeeded"
+
+    def error(self, err):
+        print err
+        mainloop.quit()
+
+    def transfer_complete(self, path):
+        if path != self.transfer_path:
+            return
+        if self.verbose:
+            print "Transfer finished"
+        mainloop.quit()
+
+    def transfer_error(self, code, message, path):
+        if path != self.transfer_path:
+            return
+        print "Transfer finished with error %s: %s" % (code, message)
+        mainloop.quit()
+
+    def change_folder(self, new_dir):
+        for node in new_dir.split("/"):
+            self.ftp.ChangeFolder(node)
+
+    def list_folder(self):
+        for i in self.ftp.ListFolder():
+            if i["Type"] == "folder":
+                print "%s/" % (i["Name"])
+            else:
+                print "%s" % (i["Name"])
+
+    def put_file(self, filename):
+        self.ftp.PutFile(os.path.abspath(filename),
+                         os.path.basename(filename),
+                         reply_handler=self.create_transfer_reply,
+                         error_handler=self.error)
+
+    def get_file(self, filename):
+        self.ftp.GetFile(os.path.abspath(filename),
+                         os.path.basename(filename),
+                         reply_handler=self.create_transfer_reply,
+                         error_handler=self.error)
+
+    def remove_file(self, filename):
+        self.ftp.Delete(filename,
+                        reply_handler=self.generic_reply,
+                        error_handler=self.error)
+
+    def move_file(self, filename, destname):
+        self.ftp.MoveFile(filename,
+                          destname,
+                          reply_handler=self.generic_reply,
+                          error_handler=self.error)
+
+    def copy_file(self, filename, destname):
+        self.ftp.CopyFile(filename,
+                          destname,
+                          reply_handler=self.generic_reply,
+                          error_handler=self.error)
 
 if  __name__ == '__main__':
 
@@ -101,33 +139,30 @@ if  __name__ == '__main__':
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
 
+    print "Creating Session"
     session_path = client.CreateSession(options.device, { "Target": "ftp" })
 
-    session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-                 "org.openobex.Session")
-
-    ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
-                 "org.openobex.FileTransfer")
+    ftp_client = FtpClient(session_path)
 
     if options.new_dir:
-        change_folder(ftp, options.new_dir)
+        ftp_client.change_folder(options.new_dir)
 
     if options.list_dir:
-        list_folder(ftp)
+        ftp_client.list_folder()
 
     if options.get_file:
-        get_file(ftp, options.get_file)
+        ftp_client.get_file(options.get_file)
 
     if options.put_file:
-        put_file(ftp, options.put_file)
+        ftp_client.put_file(options.put_file)
 
     if options.move_file:
-        move_file(ftp, options.move_file, options.dest_file)
+        ftp_client.move_file(options.move_file, options.dest_file)
 
     if options.copy_file:
-        copy_file(ftp, options.copy_file, options.dest_file)
+        ftp_client.copy_file(options.copy_file, options.dest_file)
 
     if options.remove_file:
-       remove_file(ftp, options.remove_file)
+       ftp_client.remove_file(options.remove_file)
 
     mainloop.run()
-- 
1.7.7.6

