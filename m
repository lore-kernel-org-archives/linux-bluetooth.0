Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 1/7] build-sys: Define _GNU_SOURCE in config.h
Date: Wed,  5 Dec 2012 09:22:49 -0200
Message-Id: <1354706575-4718-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Instead of defining _GNU_SOURCE in each source file (and potentially
forgetting in some), tell the build system we use extensions and let it
define _GNU_SOURCE in config.h.
---
 configure.ac                | 1 +
 monitor/btsnoop.c           | 1 -
 monitor/sdp.c               | 1 -
 profiles/input/hog_device.c | 1 -
 src/adapter.c               | 1 -
 src/mgmt.c                  | 1 -
 src/sdp-xml.c               | 1 -
 src/textfile.c              | 1 -
 tools/btsnoop.c             | 1 -
 tools/ciptool.c             | 1 -
 tools/hciattach.c           | 1 -
 tools/rfcomm.c              | 1 -
 12 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index c97d403..48e2817 100644
--- a/configure.ac
+++ b/configure.ac
@@ -3,6 +3,7 @@ AC_INIT(bluez, 5.x)
 
 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
 AM_CONFIG_HEADER(config.h)
+AC_USE_SYSTEM_EXTENSIONS
 
 m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
 
diff --git a/monitor/btsnoop.c b/monitor/btsnoop.c
index 9f4e5f3..04a6dff 100644
--- a/monitor/btsnoop.c
+++ b/monitor/btsnoop.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/monitor/sdp.c b/monitor/sdp.c
index 5812098..45ee59b 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 8fdc3c6..a873eac 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -27,7 +27,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdbool.h>
 #include <errno.h>
diff --git a/src/adapter.c b/src/adapter.c
index 3c5d277..bf3672f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/src/mgmt.c b/src/mgmt.c
index 95b7433..81b0494 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 32eeaea..7d5f626 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/src/textfile.c b/src/textfile.c
index 9d88fbc..b6a7e1f 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 0a01adf..dcb4a26 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/ciptool.c b/tools/ciptool.c
index edce9da..e240f38 100644
--- a/tools/ciptool.c
+++ b/tools/ciptool.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <stdlib.h>
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 09aed24..e1e80af 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -27,7 +27,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index e8bdd0f..affdbc7 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -25,7 +25,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <fcntl.h>
-- 
1.8.0.1

