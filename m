Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] shared/gatt-db: Add gatt_db_insert_included
Date: Wed, 10 May 2017 15:48:29 +0300
Message-Id: <20170510124835.17462-5-luiz.dentz@gmail.com>
In-Reply-To: <20170510124835.17462-1-luiz.dentz@gmail.com>
References: <20170510124835.17462-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces gatt_db_insert_included which is similar to
gatt_db_service_insert_included but doesn't require the caller to
know the service where the attribute should be inserted.
---
 src/shared/gatt-db.c | 13 +++++++++++++
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2cb80ec..376e705 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -913,6 +913,19 @@ gatt_db_service_insert_included(struct gatt_db_attribute *attrib,
 	return service_insert_included(attrib->service, handle, include);
 }
 
+struct gatt_db_attribute *
+gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
+			struct gatt_db_attribute *include)
+{
+	struct gatt_db_attribute *attrib;
+
+	attrib = gatt_db_get_service(db, handle);
+	if (!attrib)
+		return NULL;
+
+	return service_insert_included(attrib->service, handle, include);
+}
+
 bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
 {
 	struct gatt_db_service *service;
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 19583e7..fa7897b 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -94,6 +94,10 @@ gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
 					void *user_data);
 
 struct gatt_db_attribute *
+gatt_db_insert_included(struct gatt_db *db, uint16_t handle,
+			struct gatt_db_attribute *include);
+
+struct gatt_db_attribute *
 gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 					struct gatt_db_attribute *include);
 struct gatt_db_attribute *
-- 
2.9.3

