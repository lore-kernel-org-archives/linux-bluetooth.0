Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 11/16] core: gatt: Add btd_gatt_database_notify function
Date: Fri, 27 Feb 2015 00:16:34 -0800
Message-Id: <1425024999-29789-12-git-send-email-armansito@chromium.org>
In-Reply-To: <1425024999-29789-1-git-send-email-armansito@chromium.org>
References: <1425024999-29789-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add the btd_gatt_database_notify function to database's
public API. This allows upper layers to send out notifications
and indications to all connected devices that have configured the
specified CCC descriptor.
---
 src/gatt-database.c | 4 ++--
 src/gatt-database.h | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index ebfcf2d..d75b971 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -737,7 +737,7 @@ static void send_notification_to_device(void *data, void *user_data)
 							NULL, NULL);
 }
 
-static void send_notification_to_devices(struct btd_gatt_database *database,
+void btd_gatt_database_notify(struct btd_gatt_database *database,
 					uint16_t handle, const uint8_t *value,
 					uint16_t len, uint16_t ccc_handle,
 					bool indicate)
@@ -781,7 +781,7 @@ static void send_service_changed(struct btd_gatt_database *database,
 	put_le16(start, value);
 	put_le16(end, value + 2);
 
-	send_notification_to_devices(database, handle, value, sizeof(value),
+	btd_gatt_database_notify(database, handle, value, sizeof(value),
 							ccc_handle, true);
 }
 
diff --git a/src/gatt-database.h b/src/gatt-database.h
index 163b601..2a89ad6 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -34,3 +34,8 @@ btd_gatt_database_add_ccc(struct btd_gatt_database *database,
 				btd_gatt_database_ccc_write_t write_callback,
 				void *user_data,
 				btd_gatt_database_destroy_t destroy);
+
+void btd_gatt_database_notify(struct btd_gatt_database *database,
+					uint16_t handle, const uint8_t *value,
+					uint16_t len, uint16_t ccc_handle,
+					bool indicate);
-- 
2.2.0.rc0.207.ga3a616c

