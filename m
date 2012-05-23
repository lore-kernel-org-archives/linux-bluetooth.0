Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 16/16] client-test: Remove agent from ftp-client
Date: Wed, 23 May 2012 17:00:18 +0200
Message-Id: <1337785218-8661-17-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1337785218-8661-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This updated test script is limited because the current transitional
D-Bus API is incomplete. The reason behind is that the transfer path is
not being returned by methods that initiate such a transfer. Therefore
the client cannot know when the transfer has succeeded or failed, and
neither can receive progress reports in a reliable way.
---
 test/ftp-client |   49 +++++++++----------------------------------------
 1 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index 825f591..da15116 100755
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
@@ -74,6 +38,9 @@ def error(err):
 def void_reply():
     pass
 
+def transfer_complete():
+    print "SOME transfer finished (could not check if path matches)"
+
 def change_folder(session, new_dir):
     for node in new_dir.split("/"):
         session.ChangeFolder(node)
@@ -129,8 +96,12 @@ if  __name__ == '__main__':
     bus = dbus.SessionBus()
     mainloop = gobject.MainLoop()
 
-    path = "/test/agent"
-    agent = Agent(bus, path, options.verbose)
+    bus.add_signal_receiver(transfer_complete,
+                            dbus_interface="org.openobex.Transfer",
+                            signal_name="Complete")
+    bus.add_signal_receiver(error,
+                            dbus_interface="org.openobex.Transfer",
+                            signal_name="Error")
 
     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
                             "org.openobex.Client")
@@ -140,8 +111,6 @@ if  __name__ == '__main__':
     session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.Session")
 
-    session.AssignAgent(path)
-
     ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
                  "org.openobex.FileTransfer")
 
-- 
1.7.7.6

