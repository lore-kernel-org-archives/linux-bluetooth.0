Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/3] Include log.h before plugin.h
Date: Tue, 26 Jul 2011 15:57:10 +0200
Message-ID: <1311688632-19334-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
References: <1311688632-19334-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a preparation for fixing up debug messages logging from
external plugins.
---
 audio/main.c           |    2 +-
 health/hdp_main.c      |    1 +
 input/main.c           |    2 +-
 network/main.c         |    1 +
 plugins/adaptername.c  |    2 +-
 plugins/formfactor.c   |    2 +-
 plugins/gatt-example.c |    2 +-
 plugins/hciops.c       |    2 +-
 plugins/mgmtops.c      |    2 +-
 plugins/service.c      |    2 +-
 plugins/storage.c      |    2 +-
 sap/main.c             |    1 +
 serial/main.c          |    1 +
 13 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/audio/main.c b/audio/main.c
index 745c307..f2042f0 100644
--- a/audio/main.c
+++ b/audio/main.c
@@ -39,8 +39,8 @@
 
 #include "glib-helper.h"
 #include "btio.h"
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "device.h"
 #include "headset.h"
 #include "manager.h"
diff --git a/health/hdp_main.c b/health/hdp_main.c
index b40a37c..ae2340d 100644
--- a/health/hdp_main.c
+++ b/health/hdp_main.c
@@ -31,6 +31,7 @@
 
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hdp_manager.h"
 
diff --git a/input/main.c b/input/main.c
index e165ab4..33d7493 100644
--- a/input/main.c
+++ b/input/main.c
@@ -31,8 +31,8 @@
 
 #include <gdbus.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "manager.h"
 
 static GKeyFile *load_config_file(const char *file)
diff --git a/network/main.c b/network/main.c
index 88e77ee..17e5731 100644
--- a/network/main.c
+++ b/network/main.c
@@ -29,6 +29,7 @@
 
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
diff --git a/plugins/adaptername.c b/plugins/adaptername.c
index 2a54cc0..ddf50d2 100644
--- a/plugins/adaptername.c
+++ b/plugins/adaptername.c
@@ -36,13 +36,13 @@
 #include <glib.h>
 #include <bluetooth/bluetooth.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hcid.h" /* For main_opts */
 #include "adapter.h"
 #include "manager.h"
 #include "device.h" /* Needed for storage.h */
 #include "storage.h"
-#include "log.h"
 
 #include <sys/inotify.h>
 #define EVENT_SIZE  (sizeof (struct inotify_event))
diff --git a/plugins/formfactor.c b/plugins/formfactor.c
index 758d481..300e723 100644
--- a/plugins/formfactor.c
+++ b/plugins/formfactor.c
@@ -30,9 +30,9 @@
 
 #include <bluetooth/bluetooth.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "adapter.h"
-#include "log.h"
 
 #define DMI_CHASSIS_FILE "/sys/class/dmi/id/chassis_type"
 #define DMI_CHASSIS_FILE_FALLBACK "/sys/devices/virtual/dmi/id/chassis_type"
diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index f86e76d..40f19aa 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -29,9 +29,9 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "hcid.h"
-#include "log.h"
 #include "attrib-server.h"
 #include "att.h"
 
diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecc0e86..da4738d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -46,8 +46,8 @@
 #include "btio.h"
 #include "adapter.h"
 #include "device.h"
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "storage.h"
 #include "event.h"
 #include "manager.h"
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..5647065 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -41,8 +41,8 @@
 #include <bluetooth/sdp_lib.h>
 #include <bluetooth/mgmt.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 #include "adapter.h"
 #include "manager.h"
 #include "device.h"
diff --git a/plugins/service.c b/plugins/service.c
index d73cdea..01ed7bb 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -38,10 +38,10 @@
 
 #include "sdpd.h"
 #include "sdp-xml.h"
+#include "log.h"
 #include "plugin.h"
 #include "adapter.h"
 #include "error.h"
-#include "log.h"
 
 #define SERVICE_INTERFACE "org.bluez.Service"
 
diff --git a/plugins/storage.c b/plugins/storage.c
index 04a02c7..56ee04a 100644
--- a/plugins/storage.c
+++ b/plugins/storage.c
@@ -27,8 +27,8 @@
 
 #include <bluetooth/bluetooth.h>
 
-#include "plugin.h"
 #include "log.h"
+#include "plugin.h"
 
 static int storage_init(void)
 {
diff --git a/sap/main.c b/sap/main.c
index c9c90bd..57a7028 100644
--- a/sap/main.c
+++ b/sap/main.c
@@ -24,6 +24,7 @@
 
 #include <errno.h>
 #include <gdbus.h>
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
diff --git a/serial/main.c b/serial/main.c
index 38ded03..d640aba 100644
--- a/serial/main.c
+++ b/serial/main.c
@@ -29,6 +29,7 @@
 
 #include <gdbus.h>
 
+#include "log.h"
 #include "plugin.h"
 #include "manager.h"
 
-- 
on behalf of ST-Ericsson

