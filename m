Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sdpd: Remove redundant include
Date: Thu, 11 Jul 2013 14:37:28 +0200
Message-Id: <1373546248-21018-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdpd-database.c |    4 ----
 src/sdpd-request.c  |    5 -----
 src/sdpd-server.c   |    3 ---
 src/sdpd-service.c  |    7 -------
 4 files changed, 19 deletions(-)

diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index ad896a4..cf33f19 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -28,13 +28,9 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
-#include <errno.h>
 #include <stdlib.h>
-#include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/l2cap.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 0d5bf25..fbeb488 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -28,20 +28,15 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
-#include <string.h>
 #include <limits.h>
-#include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include <netinet/in.h>
-
 #include "sdpd.h"
 #include "log.h"
 
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index bc96d3c..181d248 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -28,12 +28,10 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/stat.h>
-#include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
@@ -41,7 +39,6 @@
 #include <bluetooth/sdp_lib.h>
 
 #include <sys/un.h>
-#include <netinet/in.h>
 
 #include <glib.h>
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index b6b135d..38bf808 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -28,26 +28,19 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
 #include <assert.h>
 #include <sys/time.h>
-#include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include <netinet/in.h>
-
 #include <glib.h>
-#include <dbus/dbus.h>
 
-#include "hcid.h"
 #include "sdpd.h"
 #include "log.h"
-#include "adapter.h"
 
 static sdp_record_t *server = NULL;
 static uint32_t fixed_dbts = 0;
-- 
1.7.9.5

