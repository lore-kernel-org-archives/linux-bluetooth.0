Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/gatt: Change name to more approperiate for cache all services
Date: Fri, 11 Apr 2014 17:58:57 +0200
Message-Id: <1397231937-29475-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1397231937-29475-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1397231937-29475-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes name of caching function from "primary callback" to "cache
all services".
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d8c63bf..d540736 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -589,7 +589,7 @@ static struct service *create_service(uint8_t id, bool primary, char *uuid,
 	return s;
 }
 
-static void primary_cb(GSList *services, struct gatt_device *dev)
+static void cache_all_srvc(GSList *services, struct gatt_device *dev)
 {
 	GSList *l;
 	uint8_t instance_id;
@@ -1242,7 +1242,7 @@ static void discover_srvc_cb(uint8_t status, GSList *services, void *user_data)
 	}
 
 	/* Caching primary and included services from remote */
-	primary_cb(services, cb_data->dev);
+	cache_all_srvc(services, cb_data->dev);
 
 	/* Send filtered service by uuid */
 	if (cb_data->number) {
-- 
1.9.1

