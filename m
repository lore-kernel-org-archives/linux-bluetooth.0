Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] fix implicit declaration of 'g_slist_free_full'
Date: Tue, 18 Oct 2011 12:10:53 +0200
Message-Id: <1318932653-15433-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

audio/avrcp.c: In function 'avrcp_unregister':
audio/avrcp.c:1253: error: implicit declaration of function 'g_slist_free_full'

thermometer/thermometer.c: In function 'destroy_char':
thermometer/thermometer.c:79: error: implicit declaration of function 'g_slist_free_full'
---
 audio/avrcp.c             |    2 +-
 thermometer/thermometer.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index 75a8384..e908bf4 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -52,7 +52,7 @@
 #include "avctp.h"
 #include "avrcp.h"
 #include "sdpd.h"
-#include "glib-helper.h"
+#include "glib-compat.h"
 #include "dbus-common.h"
 
 /* Company IDs for vendor dependent commands */
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 7621926..0d85102 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -20,6 +20,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <gdbus.h>
 #include <errno.h>
 #include <bluetooth/uuid.h>
@@ -34,6 +38,7 @@
 #include "att.h"
 #include "gatt.h"
 #include "thermometer.h"
+#include "glib-compat.h"
 
 #define THERMOMETER_INTERFACE "org.bluez.Thermometer"
 
-- 
1.7.1

