Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/2] Update gatt-exmaple to check if attributes were registered.
Date: Thu, 24 Nov 2011 11:08:10 +0100
Message-Id: <1322129290-10767-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1322129290-10767-1-git-send-email-sancane@gmail.com>
References: <1322129290-10767-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-example.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 1456284..6d9b6b8 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -28,6 +28,7 @@
 
 #include <glib.h>
 #include <bluetooth/uuid.h>
+#include <errno.h>
 
 #include "plugin.h"
 #include "hcid.h"
@@ -68,9 +69,9 @@ static uint8_t battery_state_read(struct attribute *a, gpointer user_data)
 	return 0;
 }
 
-static void register_battery_service(void)
+static gboolean register_battery_service(void)
 {
-	gatt_service_add(GATT_PRIM_SVC_UUID, BATTERY_STATE_SVC_UUID,
+	return gatt_service_add(GATT_PRIM_SVC_UUID, BATTERY_STATE_SVC_UUID,
 			/* battery state characteristic */
 			GATT_OPT_CHR_UUID, BATTERY_STATE_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
@@ -445,7 +446,11 @@ static int gatt_example_init(void)
 		return -1;
 	}
 
-	register_battery_service();
+	if (!register_battery_service()) {
+		DBG("Battery service could not be registered");
+		return -EIO;
+	}
+
 	register_manuf1_service(manuf1_range);
 	register_manuf2_service(manuf2_range);
 	register_termometer_service(manuf1_range, manuf2_range);
-- 
1.7.7.4

