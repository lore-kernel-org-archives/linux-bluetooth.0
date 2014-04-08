Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 10/15] android/gatt: Add helper function to create_service
Date: Tue, 8 Apr 2014 11:22:27 +0200
Message-ID: <1396948952-2035-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will be useful when we start cache also included
services
---
 android/gatt.c | 56 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f88c72a..3500cd4 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -521,6 +521,40 @@ done:
 
 }
 
+static struct service *create_service(bool primary, char *uuid, void *data)
+{
+	struct service *s;
+
+	s = new0(struct service, 1);
+	if (!s) {
+		error("gatt: Cannot allocate memory for gatt_primary");
+		return NULL;
+	}
+
+	s->chars = queue_new();
+	if (!s->chars) {
+		error("gatt: Cannot allocate memory for char cache");
+		free(s);
+		return NULL;
+	}
+
+	if (bt_string_to_uuid(&s->id.uuid, uuid) < 0) {
+		error("gatt: Cannot convert string to uuid");
+		queue_destroy(s->chars, NULL);
+		free(s);
+		return NULL;
+	}
+
+	/* Put primary service to our local list */
+	s->primary = primary;
+	if (s->primary)
+		memcpy(&s->prim, data, sizeof(s->prim));
+	else
+		memcpy(&s->incl, data, sizeof(s->incl));
+
+	return s;
+}
+
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct gatt_device *dev = user_data;
@@ -546,27 +580,9 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		struct gatt_primary *prim = l->data;
 		struct service *p;
 
-		p = new0(struct service, 1);
-		if (!p) {
-			error("gatt: Cannot allocate memory for gatt_primary");
-			continue;
-		}
-
-		p->chars = queue_new();
-		if (!p->chars) {
-			error("gatt: Cannot allocate memory for char cache");
-			free(p);
-			continue;
-		}
-
-		if (bt_string_to_uuid(&p->id.uuid, prim->uuid) < 0) {
-			error("gatt: Cannot convert string to uuid");
+		p = create_service(true, prim->uuid, prim);
+		if (!p)
 			continue;
-		}
-
-		/* Put primary service to our local list */
-		memcpy(&p->prim, prim, sizeof(p->prim));
-		p->primary = true;
 
 		if (!queue_push_tail(dev->services, p)) {
 			error("gatt: Cannot push primary service to the list");
-- 
1.8.4

