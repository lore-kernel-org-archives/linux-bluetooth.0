Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/5] core: device: Don't check ready in service_removed
Date: Thu, 29 Jan 2015 15:15:12 -0800
Message-Id: <1422573313-30825-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1422573313-30825-1-git-send-email-armansito@chromium.org>
References: <1422573313-30825-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

shared/gatt-client clears a given gatt-db if there's an error during its
init sequence, even if the given gatt-db was previously populated (e.g.
from a cache). This is to make sure that the database contents are at no
point invalid.

This patch removes a check for bt_gatt_client_is_ready and the
corresponding early-return from btd_device's service_removed handler, so
that other layers can be notified of invalidated gatt_db_attribute
pointers.
---
 src/device.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7c8ae74..29a8f23 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2927,8 +2927,21 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
 	bt_uuid_t uuid;
 	char uuid_str[MAX_LEN_UUID_STR];
 
-	if (!bt_gatt_client_is_ready(device->client))
-		return;
+	/*
+	 * NOTE: shared/gatt-client clears the database in case of failure. This
+	 * triggers the service_removed callback for all affected services.
+	 * Hence, this function will be called in the following cases:
+	 *
+	 *    1. When a GATT service gets removed due to "Service Changed".
+	 *
+	 *    2. When a GATT service gets removed when the database get cleared
+	 *       upon disconnection with a non-bonded device.
+	 *
+	 *    3. When a GATT service gets removed when the database get cleared
+	 *       by shared/gatt-client when its initialization procedure fails,
+	 *       e.g. due to an ATT protocol error or an unexpected disconnect.
+	 *       In this case the gatt-client will not be ready.
+	 */
 
 	gatt_db_attribute_get_service_data(attr, &start, &end, NULL, &uuid);
 
-- 
2.2.0.rc0.207.ga3a616c

