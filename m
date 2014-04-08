Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/15] android/gatt: Minor change in get_include_data
Date: Tue, 8 Apr 2014 11:22:24 +0200
Message-ID: <1396948952-2035-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change service to prim so it is more readable that this is primary
service
---
 android/gatt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 6259176..6ac930d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1208,7 +1208,7 @@ static struct service *find_service_by_uuid(struct gatt_device *device,
 }
 
 struct get_included_data {
-	struct service *service;
+	struct service *prim;
 	struct gatt_device *device;
 };
 
@@ -1217,7 +1217,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	struct hal_ev_gatt_client_get_inc_service ev;
 	struct get_included_data *data = user_data;
 	struct gatt_device *device = data->device;
-	struct service *service = data->service;
+	struct service *service = data->prim;
 	bt_uuid_t uuid;
 
 	DBG("");
@@ -1304,7 +1304,7 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	data->service = service;
+	data->prim = service;
 	data->device = device;
 
 	gatt_find_included(device->attrib, service->prim.range.start,
-- 
1.8.4

