Return-Path: <cyrus@holtmann.org>
From: Danilo Cesar Lemes de Paula <danilo.eu@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Danilo Cesar Lemes de Paula <danilo.cesar@openbossa.org>
Subject: [PATCH] Support relative path on send-files example
Date: Fri,  5 Mar 2010 15:46:46 -0300
Message-Id: <1267814806-6806-1-git-send-email-danilo.cesar@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Agent should receive the absolute path as it runs on a different CWD
---
 test/send-files |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/test/send-files b/test/send-files
index caf00b9..85ea3f5 100755
--- a/test/send-files
+++ b/test/send-files
@@ -2,6 +2,7 @@
 
 import gobject
 
+import os
 import sys
 import dbus
 import dbus.service
@@ -61,7 +62,8 @@ if __name__ == '__main__':
 	agent = Agent(bus, path)
 
 	mainloop = gobject.MainLoop()
+	files = [os.path.realpath(f) for f in sys.argv[2:]]
 
-	client.SendFiles({ "Destination": sys.argv[1] }, sys.argv[2:], path)
+	client.SendFiles({ "Destination": sys.argv[1] }, files, path)
 
 	mainloop.run()
-- 
1.7.0

