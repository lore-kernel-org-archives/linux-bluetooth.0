Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] android/gatt: Remove unnecessary const to non-const casts
Date: Wed, 14 May 2014 17:27:12 +0200
Message-ID: <1400081232-19459-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400081232-19459-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400081232-19459-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index ebda377..bfc41e0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -384,7 +384,7 @@ static bool match_connection_by_app(const void *data, const void *user_data)
 
 static struct gatt_device *find_device_by_addr(const bdaddr_t *addr)
 {
-	return queue_find(gatt_devices, match_device_by_bdaddr, (void *)addr);
+	return queue_find(gatt_devices, match_device_by_bdaddr, addr);
 }
 
 static struct gatt_device *find_pending_device()
@@ -607,7 +607,7 @@ static int register_app(const uint8_t *uuid, gatt_app_type_t app_type)
 	static int32_t application_id = 1;
 	struct gatt_app *app;
 
-	if (queue_find(gatt_apps, match_app_by_uuid, (void *) uuid)) {
+	if (queue_find(gatt_apps, match_app_by_uuid, uuid)) {
 		error("gatt: app uuid is already on list");
 		return 0;
 	}
-- 
1.9.3

