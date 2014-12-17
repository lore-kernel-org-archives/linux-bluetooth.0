Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] android/tester: Refreactor tester-main header includes
Date: Wed, 17 Dec 2014 11:58:16 +0100
Message-Id: <1418813900-29056-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1418813900-29056-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Profile testers should contain necessary headers include instead
of tester-main header.
---
 android/tester-a2dp.c      |  6 ++++--
 android/tester-avrcp.c     |  6 ++++--
 android/tester-bluetooth.c |  2 ++
 android/tester-gatt.c      |  5 ++++-
 android/tester-hdp.c       |  6 +++++-
 android/tester-hidhost.c   |  6 ++++--
 android/tester-main.c      | 14 ++++++++++++--
 android/tester-main.h      | 25 ++-----------------------
 android/tester-pan.c       |  5 ++++-
 android/tester-socket.c    |  3 +++
 10 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 837477e..eb88244 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -19,9 +19,11 @@
 
 #include "emulator/bthost.h"
 #include "src/shared/util.h"
-
-#include "tester-main.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "lib/bluetooth.h"
 #include "android/utils.h"
+#include "tester-main.h"
 
 static struct queue *list;
 
diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 41a5fd3..24953a2 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -19,9 +19,11 @@
 
 #include "emulator/bthost.h"
 #include "src/shared/util.h"
-
-#include "tester-main.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "lib/bluetooth.h"
 #include "android/utils.h"
+#include "tester-main.h"
 
 static struct queue *list;
 
diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
index 2be824d..c61b87c 100644
--- a/android/tester-bluetooth.c
+++ b/android/tester-bluetooth.c
@@ -17,6 +17,8 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
 #include "tester-main.h"
 
 static struct queue *list; /* List of bluetooth test cases */
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index de2a7a7..9ba2049 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -18,8 +18,11 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "tester-main.h"
+#include "lib/bluetooth.h"
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "tester-main.h"
 
 #define ATT_HANDLE_SIZE	2
 
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index ab7666d..7397de4 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -15,11 +15,15 @@
  *
  */
 
+#include <stdlib.h>
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "tester-main.h"
+#include "lib/bluetooth.h"
 #include "android/utils.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "tester-main.h"
 
 typedef enum {
 	HDP_APP_SINK_RELIABLE,
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 95befd9..b3880b3 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -18,9 +18,11 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "tester-main.h"
-
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "lib/bluetooth.h"
 #include "android/utils.h"
+#include "tester-main.h"
 
 #define HID_GET_REPORT_PROTOCOL		0x60
 #define HID_GET_BOOT_PROTOCOL		0x61
diff --git a/android/tester-main.c b/android/tester-main.c
index 6339b3a..aa08126 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -15,12 +15,22 @@
  *
  */
 #include <stdbool.h>
+#include <unistd.h>
+#include <libgen.h>
 
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <sys/signalfd.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
 #include "emulator/bthost.h"
-#include "tester-main.h"
-
 #include "monitor/bt.h"
+#include "tester-main.h"
 
 static char exec_dir[PATH_MAX + 1];
 
diff --git a/android/tester-main.h b/android/tester-main.h
index 474afbb..3674366 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -21,28 +21,7 @@
  *
  */
 
-#include <stdlib.h>
-#include <stdbool.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <limits.h>
-
 #include <glib.h>
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <sys/wait.h>
-#include <libgen.h>
-#include <sys/signalfd.h>
-
-#include "lib/bluetooth.h"
-#include "lib/mgmt.h"
-
-#include "src/shared/tester.h"
-#include "src/shared/mgmt.h"
-#include "src/shared/queue.h"
-#include "emulator/hciemu.h"
-
-#include <hardware/hardware.h>
 #include <hardware/audio.h>
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
@@ -52,8 +31,8 @@
 #include <hardware/bt_av.h>
 #include <hardware/bt_rc.h>
 #include <hardware/bt_gatt.h>
-#include <hardware/bt_gatt_client.h>
-#include <hardware/bt_gatt_server.h>
+
+#include "emulator/hciemu.h"
 
 struct pdu_set {
 	struct iovec req;
diff --git a/android/tester-pan.c b/android/tester-pan.c
index aff1980..4feb6cf 100644
--- a/android/tester-pan.c
+++ b/android/tester-pan.c
@@ -18,8 +18,11 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
-#include "tester-main.h"
+#include "lib/bluetooth.h"
 #include "android/utils.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
+#include "tester-main.h"
 
 static struct queue *list; /* List of pan test cases */
 
diff --git a/android/tester-socket.c b/android/tester-socket.c
index c70d753..3b1dd54 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -16,9 +16,12 @@
  */
 
 #include <fcntl.h>
+#include <unistd.h>
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
+#include "src/shared/tester.h"
+#include "src/shared/queue.h"
 #include "tester-main.h"
 
 static struct queue *list; /* List of socket test cases */
-- 
1.9.3

