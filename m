Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v3 4/7] core/gatt: Create CEP for external characteristic
Date: Tue,  3 Mar 2015 20:30:08 -0800
Message-Id: <1425443411-11958-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1425443411-11958-1-git-send-email-armansito@chromium.org>
References: <1425443411-11958-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for adding a Characteristic Extended
Properties descriptor entry for an external characteristic, if
it has the 'reliable-write' or 'writable-auxiliaries' property.
---
 src/gatt-database.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index e7f849e..915461c 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1187,6 +1187,12 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 			return;
 		}
 
+		if (chrc->ext_props && !incr_attr_count(service, 1)) {
+			error("Failed to increment attribute count for CEP");
+			service->failed = true;
+			return;
+		}
+
 		queue_push_tail(service->chrcs, chrc);
 	} else
 		return;
@@ -1610,6 +1616,12 @@ static void property_changed_cb(GDBusProxy *proxy, const char *name,
 static bool create_ccc_entry(struct external_service *service,
 						struct external_chrc *chrc)
 {
+	if (!(chrc->props & BT_GATT_CHRC_PROP_NOTIFY) &&
+				!(chrc->props & BT_GATT_CHRC_PROP_INDICATE)) {
+		DBG("No need to create CCC entry for characteristic");
+		return true;
+	}
+
 	chrc->ccc = service_add_ccc(service->attrib, service->database,
 						ccc_write_cb, chrc, NULL);
 	if (!chrc->ccc) {
@@ -1626,6 +1638,48 @@ static bool create_ccc_entry(struct external_service *service,
 	return true;
 }
 
+static void cep_write_cb(struct gatt_db_attribute *attrib, int err,
+								void *user_data)
+{
+	if (err)
+		DBG("Failed to store CEP value in the database");
+	else
+		DBG("Stored CEP value in the database");
+}
+
+static bool create_cep_entry(struct external_service *service,
+						struct external_chrc *chrc)
+{
+	struct gatt_db_attribute *cep;
+	bt_uuid_t uuid;
+	uint8_t value[2];
+
+	if (!chrc->ext_props) {
+		DBG("No need to create CEP entry for characteristic");
+		return true;
+	}
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_EXT_PROPER_UUID);
+	cep = gatt_db_service_add_descriptor(service->attrib, &uuid,
+							BT_ATT_PERM_READ,
+							NULL, NULL, NULL);
+	if (!cep) {
+		error("Failed to create CEP entry for characteristic");
+		return false;
+	}
+
+	memset(value, 0, sizeof(value));
+	value[0] = chrc->ext_props;
+
+	if (!gatt_db_attribute_write(cep, 0, value, sizeof(value), 0, NULL,
+							cep_write_cb, NULL)) {
+		DBG("Failed to store CEP value in the database");
+		return false;
+	}
+
+	return true;
+}
+
 static bool database_add_chrc(struct external_service *service,
 						struct external_chrc *chrc)
 {
@@ -1657,9 +1711,11 @@ static bool database_add_chrc(struct external_service *service,
 		return false;
 	}
 
-	if (chrc->props & BT_GATT_CHRC_PROP_NOTIFY ||
-				chrc->props & BT_GATT_CHRC_PROP_INDICATE)
-		return create_ccc_entry(service, chrc);
+	if (!create_ccc_entry(service, chrc))
+		return false;
+
+	if (!create_cep_entry(service, chrc))
+		return false;
 
 	return true;
 }
-- 
2.2.0.rc0.207.ga3a616c

