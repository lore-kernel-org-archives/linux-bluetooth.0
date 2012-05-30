Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 08/15] serial: Move UUID defintion to core
Date: Wed, 30 May 2012 15:00:01 +0200
Message-Id: <1338382808-29725-9-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 serial/manager.c |    3 +--
 src/uuid.h       |    2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/serial/manager.c b/serial/manager.c
index b609054..a4eb473 100644
--- a/serial/manager.c
+++ b/serial/manager.c
@@ -50,6 +50,7 @@
 #include <gdbus.h>
 
 #include "../src/dbus-common.h"
+#include "../src/uuid.h"
 #include "adapter.h"
 #include "device.h"
 
@@ -63,8 +64,6 @@
 #include "sdpd.h"
 #include "glib-helper.h"
 
-#define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805F9B34FB"
-
 static DBusConnection *connection = NULL;
 
 static int serial_probe(struct btd_device *device, const char *uuid)
diff --git a/src/uuid.h b/src/uuid.h
index 24a0e72..4ed7ede 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -57,3 +57,5 @@
 #define TEMPERATURE_TYPE_UUID		"00002a1d-0000-1000-8000-00805f9b34fb"
 #define INTERMEDIATE_TEMPERATURE_UUID	"00002a1e-0000-1000-8000-00805f9b34fb"
 #define MEASUREMENT_INTERVAL_UUID	"00002a21-0000-1000-8000-00805f9b34fb"
+
+#define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

