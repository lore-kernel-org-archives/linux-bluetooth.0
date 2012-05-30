Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v2 12/15] device: Move UUID definition to uuid.h
Date: Wed, 30 May 2012 15:00:05 +0200
Message-Id: <1338382808-29725-13-git-send-email-wagi@monom.org>
In-Reply-To: <1338382808-29725-1-git-send-email-wagi@monom.org>
References: <1338382808-29725-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 src/device.c |    2 +-
 src/uuid.h   |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 7ff09aa..928ea2b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -59,6 +59,7 @@
 #include "agent.h"
 #include "sdp-xml.h"
 #include "storage.h"
+#include "uuid.h"
 #include "btio.h"
 #include "attrib-server.h"
 #include "attrib/client.h"
@@ -71,7 +72,6 @@
 /* When all services should trust a remote device */
 #define GLOBAL_TRUST "[all]"
 
-#define GAP_SVC_UUID "00001800-0000-1000-8000-00805f9b34fb"
 #define APPEARANCE_CHR_UUID 0x2a01
 
 struct btd_disconnect_data {
diff --git a/src/uuid.h b/src/uuid.h
index 534a245..70408a0 100644
--- a/src/uuid.h
+++ b/src/uuid.h
@@ -67,3 +67,5 @@
 #define HID_UUID		"00001124-0000-1000-8000-00805f9b34fb"
 
 #define DUN_GW_UUID		"00001103-0000-1000-8000-00805f9b34fb"
+
+#define GAP_SVC_UUID		"00001800-0000-1000-8000-00805f9b34fb"
-- 
1.7.10.130.g36e6c

