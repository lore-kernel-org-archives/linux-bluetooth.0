Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/4] gatt-service: Delete attributes when service registration fails.
Date: Fri, 30 Dec 2011 12:45:07 +0100
Message-Id: <1325245509-14359-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1325245509-14359-1-git-send-email-sancane@gmail.com>
References: <1325245509-14359-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Whenever a regitration operation fails, the attributes stored in
the data base of handles remain. This patches removes all attributes
registered by a service when the operation is not succesful. In this
way, either all service attributes are registered or none of them
are stored in the data base.
---
 attrib/gatt-service.c |   29 +++++++++++++++++++++++++----
 1 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index 3bfa565..93cbf74 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -198,12 +198,16 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	atval[0] = info->props;
 	att_put_u16(h + 1, &atval[1]);
 	att_put_u16(info->uuid.value.u16, &atval[3]);
-	attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
-							atval, sizeof(atval));
+	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
+						atval, sizeof(atval)) == NULL)
+		return FALSE;
 
 	/* characteristic value */
 	a = attrib_db_add(adapter, h++, &info->uuid, read_reqs, write_reqs,
 								NULL, 0);
+	if (a == NULL)
+		return FALSE;
+
 	for (l = info->callbacks; l != NULL; l = l->next) {
 		struct attrib_cb *cb = l->data;
 
@@ -229,6 +233,8 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 		cfg_val[1] = 0x00;
 		a = attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE,
 				ATT_AUTHENTICATION, cfg_val, sizeof(cfg_val));
+		if (a == NULL)
+			return FALSE;
 
 		if (info->ccc_handle != NULL)
 			*info->ccc_handle = a->handle;
@@ -247,6 +253,16 @@ static void free_gatt_info(void *data)
 	g_free(info);
 }
 
+static void service_attr_del(struct btd_adapter *adapter, uint16_t start_handle,
+							uint16_t end_handle)
+{
+	uint16_t handle;
+
+	for (handle = start_handle; handle <= end_handle; handle++)
+		if (attrib_db_del(adapter, handle) < 0)
+			error("Can't delete handle 0x%04x", handle);
+}
+
 gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 				uint16_t svc_uuid, gatt_option opt1, ...)
 {
@@ -279,14 +295,19 @@ gboolean gatt_service_add(struct btd_adapter *adapter, uint16_t uuid,
 	h = start_handle;
 	bt_uuid16_create(&bt_uuid, uuid);
 	att_put_u16(svc_uuid, &atval[0]);
-	attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
-							atval, sizeof(atval));
+	if (attrib_db_add(adapter, h++, &bt_uuid, ATT_NONE, ATT_NOT_PERMITTED,
+						atval, sizeof(atval)) == NULL) {
+		g_slist_free_full(chrs, free_gatt_info);
+		return FALSE;
+	}
+
 	for (l = chrs; l != NULL; l = l->next) {
 		struct gatt_info *info = l->data;
 
 		DBG("New characteristic: handle 0x%04x", h);
 		if (!add_characteristic(adapter, &h, info)) {
 			g_slist_free_full(chrs, free_gatt_info);
+			service_attr_del(adapter, start_handle, h - 1);
 			return FALSE;
 		}
 	}
-- 
1.7.8.1

