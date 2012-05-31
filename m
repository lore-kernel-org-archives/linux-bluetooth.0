Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 09/14] health: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:33 +0200
Message-Id: <1338471818-20894-10-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 health/hdp_manager.c |    1 +
 health/hdp_types.h   |    4 ----
 health/hdp_util.c    |    1 +
 lib/uuid.h           |    4 ++++
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/health/hdp_manager.c b/health/hdp_manager.c
index cccb1a6..ffaed5d 100644
--- a/health/hdp_manager.c
+++ b/health/hdp_manager.c
@@ -26,6 +26,7 @@
 
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 
 #include <btio.h>
 #include <adapter.h>
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
index 3b48e44..744e390 100644
--- a/health/hdp_util.c
+++ b/health/hdp_util.c
@@ -35,6 +35,7 @@
 
 #include <sdpd.h>
 #include <bluetooth/sdp_lib.h>
+#include <bluetooth/uuid.h>
 #include <sdp-client.h>
 #include <glib-helper.h>
 
diff --git a/lib/uuid.h b/lib/uuid.h
index 1ed90e0..32f51b7 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -71,6 +71,10 @@ extern "C" {
 
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
 
+#define HDP_UUID		"00001400-0000-1000-8000-00805f9b34fb"
+#define HDP_SOURCE_UUID		"00001401-0000-1000-8000-00805f9b34fb"
+#define HDP_SINK_UUID		"00001402-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
1.7.10.130.g36e6c

