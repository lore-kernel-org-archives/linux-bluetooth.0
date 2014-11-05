Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/gatt: Search included services in Secondary Services
Date: Wed,  5 Nov 2014 14:01:50 +0100
Message-Id: <1415192511-7651-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415192511-7651-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415192511-7651-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check type of service and perform include service discovery with valid
range.
---
 android/gatt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 87a7a12..1edc8b0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2412,6 +2412,7 @@ static bool search_included_services(struct app_connection *connection,
 							struct service *service)
 {
 	struct get_included_data *data;
+	uint16_t start, end;
 
 	data = new0(struct get_included_data, 1);
 	if (!data) {
@@ -2422,9 +2423,17 @@ static bool search_included_services(struct app_connection *connection,
 	data->prim = service;
 	data->conn = connection;
 
-	gatt_find_included(connection->device->attrib,
-				service->prim.range.start,
-				service->prim.range.end, get_included_cb, data);
+	if (service->primary) {
+		start = service->prim.range.start;
+		end = service->prim.range.end;
+	} else {
+		start = service->incl.range.start;
+		end = service->incl.range.end;
+	}
+
+	gatt_find_included(connection->device->attrib, start, end,
+							get_included_cb, data);
+
 	return true;
 }
 
-- 
1.9.3

