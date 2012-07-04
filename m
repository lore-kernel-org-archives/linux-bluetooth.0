Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 05/19] input: remove unneeded header inclusions
Date: Wed,  4 Jul 2012 14:51:21 +0200
Message-Id: <1341406295-7669-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341406295-7669-1-git-send-email-gustavo@padovan.org>
References: <1341406295-7669-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 input/device.c  |    5 -----
 input/fakehid.c |    4 ----
 input/manager.c |    3 ---
 3 files changed, 12 deletions(-)

diff --git a/input/device.c b/input/device.c
index c08ba18..f3ceabb 100644
--- a/input/device.c
+++ b/input/device.c
@@ -29,9 +29,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <sys/stat.h>
-#include <sys/ioctl.h>
-#include <sys/socket.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hidp.h>
@@ -39,8 +36,6 @@
 #include <bluetooth/sdp_lib.h>
 #include <bluetooth/uuid.h>
 
-#include <glib.h>
-#include <dbus/dbus.h>
 #include <gdbus.h>
 
 #include "log.h"
diff --git a/input/fakehid.c b/input/fakehid.c
index 3181538..3be1489 100644
--- a/input/fakehid.c
+++ b/input/fakehid.c
@@ -25,12 +25,8 @@
 #include <config.h>
 #endif
 
-#include <stdio.h>
-#include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <stdlib.h>
-#include <sys/types.h>
 
 #include <bluetooth/bluetooth.h>
 
diff --git a/input/manager.c b/input/manager.c
index 5cc552b..3572ea9 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -28,13 +28,10 @@
 #include <errno.h>
 
 #include <bluetooth/bluetooth.h>
-#include <bluetooth/hci.h>
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 #include <bluetooth/uuid.h>
 
-#include <gdbus.h>
-
 #include "log.h"
 #include "../src/adapter.h"
 #include "../src/device.h"
-- 
1.7.10.2

