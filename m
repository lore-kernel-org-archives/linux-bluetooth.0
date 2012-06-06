Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 17/17] test: Pass remote address and port number to test-sap-server
Date: Wed, 6 Jun 2012 15:19:27 +0200
Message-ID: <1338988767-19467-17-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to pass remote SAP server address and optional port number.
Also exit script error if not able to connect SAP client to server.
---
 test/test-sap-server |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/test/test-sap-server b/test/test-sap-server
index f5ad1c8..93c0092 100755
--- a/test/test-sap-server
+++ b/test/test-sap-server
@@ -2,6 +2,7 @@
 
 from sap_client import *
 import time
+import sys
 
 def connect_disconnect_by_client(sap):
 
@@ -122,13 +123,23 @@ def power_sim_off_on(sap):
 
 if __name__ == "__main__":
 
-    host = "00:00:00:00:00:0"  # server bd_addr
+    host = None  # server bd_addr
     port = 8  # sap server port
 
+    if (len(sys.argv) < 2):
+        print "Usage: %s <address> [port]" % (sys.argv[0])
+        sys.exit(1)
+
+    host = sys.argv[1]
+
+    if (len(sys.argv) == 3):
+        port = sys.argv[2]
+
     try:
         s = SAPClient(host, port)
     except BluetoothError , e:
-        print "Error " + str(e)
+        print "Error: " + str(e)
+        sys.exit(1)
 
     connect_disconnect_by_client(s)
     connect_disconnect_by_server_gracefully(s)
-- 
on behalf of ST-Ericsson

