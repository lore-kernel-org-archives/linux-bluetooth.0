Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 04/14] deviceinfo: Move UUID string definition to lib
Date: Thu, 31 May 2012 15:43:28 +0200
Message-Id: <1338471818-20894-5-git-send-email-wagi@monom.org>
In-Reply-To: <1338471818-20894-1-git-send-email-wagi@monom.org>
References: <1338471818-20894-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 deviceinfo/deviceinfo.c |    2 --
 deviceinfo/manager.c    |    2 --
 lib/uuid.h              |    3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/deviceinfo/deviceinfo.c b/deviceinfo/deviceinfo.c
index 5dd9293..8c3af93 100644
--- a/deviceinfo/deviceinfo.c
+++ b/deviceinfo/deviceinfo.c
@@ -37,8 +37,6 @@
 #include "log.h"
 #include "deviceinfo.h"
 
-#define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
-
 struct deviceinfo {
 	struct btd_device	*dev;		/* Device reference */
 	GAttrib			*attrib;	/* GATT connection */
diff --git a/deviceinfo/manager.c b/deviceinfo/manager.c
index c2378c2..1d59918 100644
--- a/deviceinfo/manager.c
+++ b/deviceinfo/manager.c
@@ -32,8 +32,6 @@
 #include "deviceinfo.h"
 #include "manager.h"
 
-#define DEVICE_INFORMATION_UUID		"0000180a-0000-1000-8000-00805f9b34fb"
-
 static gint primary_uuid_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct gatt_primary *prim = a;
diff --git a/lib/uuid.h b/lib/uuid.h
index 848baed..713075e 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -53,6 +53,9 @@ extern "C" {
 #define GN_UUID			"00001117-0000-1000-8000-00805f9b34fb"
 #define BNEP_SVC_UUID		"0000000f-0000-1000-8000-00805f9b34fb"
 
+#define PNPID_UUID		"00002a50-0000-1000-8000-00805f9b34fb"
+#define DEVICE_INFORMATION_UUID	"0000180a-0000-1000-8000-00805f9b34fb"
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
1.7.10.130.g36e6c

