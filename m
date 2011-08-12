Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/3] Add move and copy support to ftp-client
Date: Fri, 12 Aug 2011 15:46:44 +0300
Message-Id: <1313153204-16301-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313153204-16301-1-git-send-email-luiz.dentz@gmail.com>
References: <1313153204-16301-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 test/ftp-client |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/test/ftp-client b/test/ftp-client
index 4cb4ee5..9bc038d 100755
--- a/test/ftp-client
+++ b/test/ftp-client
@@ -56,6 +56,12 @@ def parse_options():
                       help="Get FILE", metavar="FILE")
     parser.add_option("-p", "--put", dest="put_file",
                       help="Put FILE", metavar="FILE")
+    parser.add_option("-y", "--copy", dest="copy_file",
+                      help="Copy FILE", metavar="FILE")
+    parser.add_option("-m", "--move", dest="move_file",
+                      help="Move FILE", metavar="FILE")
+    parser.add_option("-n", "--destname", dest="dest_file",
+                      help="Destination FILE", metavar="FILE")
     parser.add_option("-r", "--remove", dest="remove_file",
                       help="Remove FILE", metavar="FILE")
     parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
@@ -96,6 +102,18 @@ def remove_file(session, filename):
                     reply_handler=void_reply,
                     error_handler=error)
 
+def move_file(session, filename, destname):
+    session.MoveFile(filename,
+                    destname,
+                    reply_handler=void_reply,
+                    error_handler=error)
+
+def copy_file(session, filename, destname):
+    session.CopyFile(filename,
+                    destname,
+                    reply_handler=void_reply,
+                    error_handler=error)
+
 if  __name__ == '__main__':
 
     dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
@@ -140,6 +158,12 @@ if  __name__ == '__main__':
     if options.put_file:
         put_file(ftp, options.put_file)
 
+    if options.move_file:
+        move_file(ftp, options.move_file, options.dest_file)
+
+    if options.copy_file:
+        copy_file(ftp, options.copy_file, options.dest_file)
+
     if options.remove_file:
        remove_file(ftp, options.remove_file)
 
-- 
1.7.6

