Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 08/14] serial: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:32 +0200
Message-Id: <1338471818-20894-9-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 lib/uuid.h       |    2 ++
 serial/manager.c |    3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/uuid.h b/lib/uuid.h
index d47a6af..1ed90e0 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -69,6 +69,8 @@ extern "C" {
 #define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
 
+#define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
diff --git a/serial/manager.c b/serial/manager.c
index b609054..438ba6c 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -45,6 +45,7 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 #include <bluetooth/rfcomm.h>
+#include <bluetooth/uuid.h>
 
 #include <glib.h>
 #include <gdbus.h>
@@ -63,8 +64,6 @@
 #include "sdpd.h"
 #include "glib-helper.h"
 
-#define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805F9B34FB"
-
 static DBusConnection *connection = NULL;
 
 static int serial_probe(struct btd_device *device, const char *uuid)
-- 
1.7.10.130.g36e6c

