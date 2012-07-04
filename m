Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 12/28] serial: remove unneeded headers include
Date: Wed,  4 Jul 2012 10:17:31 +0200
Message-Id: <1341389867-30749-13-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 serial/manager.c |   21 ---------------------
 serial/port.c    |    8 --------
 2 files changed, 29 deletions(-)

diff --git a/serial/manager.c b/serial/manager.c
index a84ce03..6f3fc1f 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -25,43 +25,22 @@
 #include <config.h>
 #endif
 
-#include <ctype.h>
-#include <dirent.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <termios.h>
-#include <unistd.h>
-#include <arpa/inet.h>
-#include <sys/param.h>
-#include <sys/ioctl.h>
-#include <sys/stat.h>
-#include <sys/types.h>
-#include <sys/un.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
-#include <bluetooth/rfcomm.h>
 #include <bluetooth/uuid.h>
 
-#include <glib.h>
 #include <gdbus.h>
 
-#include "../src/dbus-common.h"
 #include "adapter.h"
 #include "device.h"
 
 #include "log.h"
 
-#include "error.h"
 #include "port.h"
-#include "storage.h"
 #include "manager.h"
-#include "sdpd.h"
-#include "glib-helper.h"
 
 static DBusConnection *connection = NULL;
 
diff --git a/serial/port.c b/serial/port.c
index f90bb6a..2422cfe 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -26,15 +26,9 @@
 #endif
 
 #include <errno.h>
-#include <stdio.h>
-#include <stdint.h>
 #include <stdlib.h>
-#include <string.h>
-#include <termios.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <fcntl.h>
 
 #include <bluetooth/bluetooth.h>
@@ -45,8 +39,6 @@
 #include <glib.h>
 #include <gdbus.h>
 
-#include "../src/dbus-common.h"
-
 #include "log.h"
 #include "glib-helper.h"
 #include "sdp-client.h"
-- 
1.7.10.2

