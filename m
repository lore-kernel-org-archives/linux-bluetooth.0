Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 03/11] attrib-server: Add attributes in adapter database
Date: Fri, 16 Dec 2011 17:09:51 +0100
Message-Id: <1324051799-21439-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-3-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each adapter has its own database so the global database list
will be removed. This patch makes a wrapper over attrib_db_add
function to get the default adapter in order to add attributes
in the default adapter, int his way we keep backward compatibility
with the gatt server interface until the api is updated.
---
 src/attrib-server.c |   68 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5a5024c..b2f0edb 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -331,6 +331,33 @@ static uint32_t attrib_create_sdp_new(struct gatt_adapter *gatt_adapter,
 	return 0;
 }
 
+static struct attribute *attrib_db_add_new(struct gatt_adapter *gatt_adapter,
+				uint16_t handle, bt_uuid_t *uuid, int read_reqs,
+				int write_reqs, const uint8_t *value, int len)
+{
+	struct attribute *a;
+	guint h = handle;
+
+	DBG("handle=0x%04x", handle);
+
+	if (g_slist_find_custom(gatt_adapter->database, GUINT_TO_POINTER(h),
+								handle_cmp))
+		return NULL;
+
+	a = g_new0(struct attribute, 1);
+	a->len = len;
+	a->data = g_memdup(value, len);
+	a->handle = handle;
+	a->uuid = *uuid;
+	a->read_reqs = read_reqs;
+	a->write_reqs = write_reqs;
+
+	gatt_adapter->database = g_slist_insert_sorted(gatt_adapter->database,
+							a, attribute_cmp);
+
+	return a;
+}
+
 static uint8_t att_check_reqs(struct gatt_channel *channel, uint8_t opcode,
 								int reqs)
 {
@@ -1075,7 +1102,8 @@ static gboolean register_core_services(struct gatt_adapter *gatt_adapter)
 	/* GAP service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ACCESS_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0001, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add_new(gatt_adapter, 0x0001, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 2);
 
 	/* GAP service: device name characteristic */
 	name_handle = 0x0006;
@@ -1083,12 +1111,13 @@ static gboolean register_core_services(struct gatt_adapter *gatt_adapter)
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(name_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_DEVICE_NAME, &atval[3]);
-	attrib_db_add(0x0004, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add_new(gatt_adapter, 0x0004, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device name attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_DEVICE_NAME);
-	attrib_db_add(name_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
-								NULL, 0);
+	attrib_db_add_new(gatt_adapter, name_handle, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, NULL, 0);
 
 	/* GAP service: device appearance characteristic */
 	appearance_handle = 0x0008;
@@ -1096,13 +1125,14 @@ static gboolean register_core_services(struct gatt_adapter *gatt_adapter)
 	atval[0] = ATT_CHAR_PROPER_READ;
 	att_put_u16(appearance_handle, &atval[1]);
 	att_put_u16(GATT_CHARAC_APPEARANCE, &atval[3]);
-	attrib_db_add(0x0007, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 5);
+	attrib_db_add_new(gatt_adapter, 0x0007, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 5);
 
 	/* GAP service: device appearance attribute */
 	bt_uuid16_create(&uuid, GATT_CHARAC_APPEARANCE);
 	att_put_u16(appearance, &atval[0]);
-	attrib_db_add(appearance_handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
-								atval, 2);
+	attrib_db_add_new(gatt_adapter, appearance_handle, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 2);
 
 	gatt_adapter->gap_sdp_handle = attrib_create_sdp_new(gatt_adapter,
 					0x0001, "Generic Access Profile");
@@ -1114,7 +1144,8 @@ static gboolean register_core_services(struct gatt_adapter *gatt_adapter)
 	/* GATT service: primary service definition */
 	bt_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	att_put_u16(GENERIC_ATTRIB_PROFILE_ID, &atval[0]);
-	attrib_db_add(0x0010, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval, 2);
+	attrib_db_add_new(gatt_adapter, 0x0010, &uuid, ATT_NONE,
+						ATT_NOT_PERMITTED, atval, 2);
 
 	gatt_adapter->gatt_sdp_handle = attrib_create_sdp_new(gatt_adapter,
 					0x0010, "Generic Attribute Profile");
@@ -1260,25 +1291,16 @@ uint16_t attrib_db_find_avail(uint16_t nitems)
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len)
 {
-	struct attribute *a;
-	guint h = handle;
+	struct gatt_adapter *gatt_adapter;
 
-	DBG("handle=0x%04x", handle);
+	DBG("Deprecated function!");
 
-	if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
+	gatt_adapter = get_default_gatt_adapter();
+	if (gatt_adapter == NULL)
 		return NULL;
 
-	a = g_new0(struct attribute, 1);
-	a->len = len;
-	a->data = g_memdup(value, len);
-	a->handle = handle;
-	a->uuid = *uuid;
-	a->read_reqs = read_reqs;
-	a->write_reqs = write_reqs;
-
-	database = g_slist_insert_sorted(database, a, attribute_cmp);
-
-	return a;
+	return attrib_db_add_new(gatt_adapter, handle, uuid, read_reqs, write_reqs,
+								value, len);
 }
 
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
-- 
1.7.8

