Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 14/15] GATT server: add characteristic descriptor registration
Date: Wed, 16 Mar 2011 21:00:38 -0400
Message-Id: <1300323639-13296-15-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index 4cf0164..521befe 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -427,6 +427,45 @@ static uint16_t service_size(struct gatt_service *svc)
 	return size;
 }
 
+static void register_descriptors(gpointer data, gpointer user_data)
+{
+	struct gatt_descriptor *desc = data;
+	GSList **attrs = user_data, *l;
+	struct attribute *a;
+	uint8_t atval[ATT_MAX_VALUE_LEN];
+	uint16_t handle;
+	bt_uuid_t uuid;
+
+	DBG("descriptor: type=0x%04x", desc->type);
+
+	l = g_slist_last(*attrs);
+	g_assert(l != NULL);
+
+	a = l->data;
+	handle = a->handle + 1;
+
+	bt_uuid16_create(&uuid, desc->type);
+	if (desc->type == GATT_CHARAC_USER_DESC_UUID)
+		a = attrib_db_add(handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+					(uint8_t *) desc->data.description,
+					strlen(desc->data.description));
+	else if (desc->type == GATT_CHARAC_FMT_UUID) {
+		atval[0] = desc->data.presentation.format;
+		atval[1] = desc->data.presentation.exponent;
+		att_put_u16(desc->data.presentation.unit, &atval[2]);
+		atval[4] = desc->data.presentation.namespace;
+		att_put_u16(desc->data.presentation.description, &atval[5]);
+		a = attrib_db_add(handle, &uuid, ATT_NONE, ATT_NOT_PERMITTED,
+								atval, 7);
+	} else {
+		error("Unsupported descriptor type: 0x%04x", desc->type);
+		return;
+	}
+
+	g_assert(a != NULL);
+	*attrs = g_slist_append(*attrs, a);
+}
+
 static void register_characteristics(gpointer data, gpointer user_data)
 {
 	struct gatt_characteristic *chr = data;
@@ -468,6 +507,8 @@ static void register_characteristics(gpointer data, gpointer user_data)
 				ATT_NOT_PERMITTED, chr->value, chr->vlen);
 	g_assert(a != NULL);
 	*attrs = g_slist_append(*attrs, a);
+
+	g_slist_foreach(chr->descriptors, register_descriptors, attrs);
 }
 
 static void register_services(gpointer data, gpointer user_data)
-- 
1.7.0.4

