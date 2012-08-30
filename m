Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] build: Use AC_USE_SYSTEM_EXTENSIONS for POSIX/C extensions
Date: Thu, 30 Aug 2012 09:19:00 -0400
Message-Id: <1346332740-29319-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using this macro in configure.ac enables certain extensions that BlueZ
currently depends on. The macro is recommended instead of defining
_GNU_SOURCE on each C file.
---
 configure.ac      |    2 ++
 src/adapter.c     |    1 -
 src/event.c       |    1 -
 src/sdp-xml.c     |    1 -
 src/textfile.c    |    1 -
 tools/ciptool.c   |    1 -
 tools/hciattach.c |    1 -
 tools/rfcomm.c    |    1 -
 8 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7d9a34d..6c897d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -10,6 +10,8 @@ AM_MAINTAINER_MODE
 
 PKG_PROG_PKG_CONFIG
 
+AC_USE_SYSTEM_EXTENSIONS
+
 AC_INIT_BLUEZ
 
 COMPILER_FLAGS
diff --git a/src/adapter.c b/src/adapter.c
index 50779fd..e400603 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
diff --git a/src/event.c b/src/event.c
index 1586293..3b49dce 100644
--- a/src/event.c
+++ b/src/event.c
@@ -26,7 +26,6 @@
 #include <config.h>
 #endif
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <ctype.h>
 #include <errno.h>
diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 52df285..1aca776 100644
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
index d19fa33..e166730 100644
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
1.7.9.5

