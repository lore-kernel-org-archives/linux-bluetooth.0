Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/4] Remove unneeded header include
Date: Wed, 24 Aug 2011 16:09:48 -0300
Message-Id: <1314212990-13090-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c     |    1 -
 src/dbus-common.c |   11 +----------
 src/device.c      |    1 -
 3 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5878a76..b37441a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -51,7 +51,6 @@
 #include "manager.h"
 #include "device.h"
 #include "dbus-common.h"
-#include "event.h"
 #include "error.h"
 #include "glib-helper.h"
 #include "agent.h"
diff --git a/src/dbus-common.c b/src/dbus-common.c
index 8436100..ef3b375 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -28,13 +28,7 @@
 #endif
 
 #include <stdio.h>
-#include <errno.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-#include <sys/ioctl.h>
-
-#include <bluetooth/bluetooth.h>
+#include <stdint.h>
 
 #include <glib.h>
 #include <dbus/dbus.h>
@@ -42,9 +36,6 @@
 
 #include "log.h"
 
-#include "adapter.h"
-#include "manager.h"
-#include "event.h"
 #include "dbus-common.h"
 
 static DBusConnection *connection = NULL;
diff --git a/src/device.c b/src/device.c
index 96e798f..8e55052 100644
--- a/src/device.c
+++ b/src/device.c
@@ -53,7 +53,6 @@
 #include "attio.h"
 #include "device.h"
 #include "dbus-common.h"
-#include "event.h"
 #include "error.h"
 #include "glib-helper.h"
 #include "gatt.h"
-- 
1.7.6

