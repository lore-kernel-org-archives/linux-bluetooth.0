Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 09/15] health: Move UUID defintion to core
Date: Wed, 30 May 2012 15:00:02 +0200
Message-Id: <1338382808-29725-10-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 health/hdp_manager.c |    2 ++
 health/hdp_types.h   |    4 ----
 health/hdp_util.c    |    2 ++
 src/uuid.h           |    4 ++++
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/health/hdp_manager.c b/health/hdp_manager.c
index cccb1a6..7ca338a 100644
--- a/health/hdp_manager.c
+++ b/health/hdp_manager.c
@@ -27,6 +27,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "../src/uuid.h"
+
 #include <btio.h>
 #include <adapter.h>
 #include <device.h>
diff --git a/health/hdp_types.h b/health/hdp_types.h
index 9a6776f..7f8b015 100644
--- a/health/hdp_types.h
+++ b/health/hdp_types.h
@@ -23,10 +23,6 @@
 #ifndef __HDP_TYPES_H__
 #define __HDP_TYPES_H__
 
-#define HDP_UUID		"00001400-0000-1000-8000-00805F9B34FB"
-#define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805F9B34FB"
-#define HDP_SINK_UUID		"00001402-0000-1000-8000-00805F9B34FB"
-
 #define MANAGER_PATH		"/org/bluez"
 
 #define HEALTH_MANAGER		"org.bluez.HealthManager"
diff --git a/health/hdp_util.c b/health/hdp_util.c
index 3b48e44..8131ff5 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -38,6 +38,8 @@
 #include <sdp-client.h>
 #include <glib-helper.h>
 
+#include "../src/uuid.h"
+
 #include <btio.h>
 
 #include <log.h>
diff --git a/src/uuid.h b/src/uuid.h
index 4ed7ede..27e8ab5 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -59,3 +59,7 @@
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
 
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
+
+#define HDP_UUID		"00001400-0000-1000-8000-00805f9b34fb"
+#define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805f9b34fb"
+#define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

