Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 1/2] Provide return status in gatt_service_add function
Date: Thu, 24 Nov 2011 11:08:09 +0100
Message-Id: <1322129290-10767-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Service plugins using the new GATT API may need to know if their attributes
were successfuly retgistered. In this way, plugins might abort loading
operation if they weren't registered.
---
 attrib/gatt-service.c |   15 +++++++++------
 attrib/gatt-service.h |    2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index ead3f8e..b904ce6 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -244,7 +244,7 @@ static void free_gatt_info(void *data)
 	g_free(info);
 }
 
-void gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...)
+gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...)
 {
 	uint16_t start_handle, h;
 	unsigned int size;
@@ -265,7 +265,8 @@ void gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...)
 	start_handle = attrib_db_find_avail(size);
 	if (start_handle == 0) {
 		error("Not enough free handles to register service");
-		goto done;
+		g_slist_free_full(chrs, free_gatt_info);
+		return FALSE;
 	}
 
 	DBG("New service: handle 0x%04x, UUID 0x%04x, %d attributes",
@@ -282,13 +283,15 @@ void gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...)
 		struct gatt_info *info = l->data;
 
 		DBG("New characteristic: handle 0x%04x", h);
-		if (!add_characteristic(&h, info))
-			goto done;
+		if (!add_characteristic(&h, info)) {
+			g_slist_free_full(chrs, free_gatt_info);
+			return FALSE;
+		}
 	}
 
 	g_assert(size < USHRT_MAX);
 	g_assert(h - start_handle == (uint16_t) size);
-
-done:
 	g_slist_free_full(chrs, free_gatt_info);
+
+	return TRUE;
 }
diff --git a/attrib/gatt-service.h b/attrib/gatt-service.h
index 6525dc0..95064c0 100644
--- a/attrib/gatt-service.h
+++ b/attrib/gatt-service.h
@@ -47,4 +47,4 @@ typedef enum {
 	ATTRIB_WRITE,
 } attrib_event_t;
 
-void gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...);
+gboolean gatt_service_add(uint16_t uuid, uint16_t svc_uuid, gatt_option opt1, ...);
-- 
1.7.7.4

