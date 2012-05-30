Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v3 14/14] client-test: Remove agent from ftp-client
Date: Wed, 30 May 2012 17:50:23 +0200
Message-Id: <1338393023-29941-15-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Remove the use of the agent in the test script. Most of the
functionality is still there with the exception of progress reporting,
which is not possible due to some transitional limitations in the D-Bus
API.
---
 test/ftp-client |   50 +++++++-------------------------------------------
 1 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index 825f591..8421ade 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -9,42 +9,6 @@ import dbus.mainloop.glib
 import os.path
 from optparse import OptionParser
 
-class Agent(dbus.service.Object):
-    def __init__(self, conn=None, obj_path=None, verbose=False):
-        dbus.service.Object.__init__(self, conn, obj_path)
-        self.verbose = verbose
-
-    @dbus.service.method("org.openobex.Agent",
-                    in_signature="o", out_signature="s")
-    def Request(self, path):
-        return ""
-
-    @dbus.service.method("org.openobex.Agent",
-                    in_signature="ot", out_signature="")
-    def Progress(self, path, transferred):
-        if self.verbose:
-            print "Transfer progress (%d bytes)" % (transferred)
-        return
-
-    @dbus.service.method("org.openobex.Agent",
-                    in_signature="o", out_signature="")
-    def Complete(self, path):
-        if self.verbose:
-            print "Transfer finished"
-        mainloop.quit()
-
-    @dbus.service.method("org.openobex.Agent",
-                    in_signature="os", out_signature="")
-    def Error(self, path, error):
-        print "Transfer finished with an error: %s" % (error)
-        mainloop.quit()
-
-    @dbus.service.method("org.openobex.Agent",
-                    in_signature="", out_signature="")
-    def Release(self):
-        mainloop.quit()
-
-
 def parse_options():
     parser.add_option("-d", "--device", dest="device",
                       help="Device to connect", metavar="DEVICE")
@@ -74,6 +38,11 @@ def error(err):
 def void_reply():
     pass
 
+def transfer_complete():
+    if options.verbose:
+        print "Transfer finished"
+    mainloop.quit()
+
 def change_folder(session, new_dir):
     for node in new_dir.split("/"):
         session.ChangeFolder(node)
@@ -88,13 +57,13 @@ def list_folder(session):
 def put_file(session, filename):
     session.PutFile(os.path.abspath(filename),
                     os.path.basename(filename),
-                    reply_handler=void_reply,
+                    reply_handler=transfer_complete,
                     error_handler=error)
 
 def get_file(session, filename):
     session.GetFile(os.path.abspath(filename),
                     os.path.basename(filename),
-                    reply_handler=void_reply,
+                    reply_handler=transfer_complete,
                     error_handler=error)
 
 def remove_file(session, filename):
@@ -129,9 +98,6 @@ if  __name__ == '__main__':
     bus = dbus.SessionBus()
     mainloop = gobject.MainLoop()
 
-    path = "/test/agent"
-    agent = Agent(bus, path, options.verbose)
-
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
 
@@ -140,8 +106,6 @@ if  __name__ == '__main__':
     session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.Session")
 
-    session.AssignAgent(path)
-
     ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.FileTransfer")
 
-- 
1.7.7.6

