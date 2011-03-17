Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 13/15] GATT server: add characteristic registration
Date: Wed, 16 Mar 2011 21:00:37 -0400
Message-Id: <1300323639-13296-14-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/gatt-profile.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index 83006fb..4cf0164 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -427,6 +427,49 @@ static uint16_t service_size(struct gatt_service *svc)
 	return size;
 }
 
+static void register_characteristics(gpointer data, gpointer user_data)
+{
+	struct gatt_characteristic *chr = data;
+	GSList **attrs = user_data, *l;
+	struct attribute *a;
+	uint16_t handle;
+	bt_uuid_t uuid;
+	char uuidstr[MAX_LEN_UUID_STR];
+	uint8_t atval[ATT_MAX_VALUE_LEN];
+	int atlen;
+
+	bt_uuid_to_string(&chr->value_uuid, uuidstr, MAX_LEN_UUID_STR);
+	DBG("characteristic: props=0x%02x, value_uuid=%s", chr->props, uuidstr);
+
+	bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
+
+	l = g_slist_last(*attrs);
+	g_assert(l != NULL);
+
+	a = l->data;
+	handle = a->handle + 1;
+
+	atval[0] = chr->props;
+	att_put_u16(handle + 1, &atval[1]);
+	att_put_uuid(chr->value_uuid, &atval[3]);
+	if (chr->value_uuid.type == BT_UUID16)
+		atlen = 2;
+	else
+		atlen = 16;
+
+	/* Characteristic declaration attribute */
+	a = attrib_db_add(handle++, &uuid, ATT_NONE, ATT_NOT_PERMITTED, atval,
+								atlen + 3);
+	g_assert(a != NULL);
+	*attrs = g_slist_append(*attrs, a);
+
+	/* Characteristic value attribute */
+	a = attrib_db_add(handle, &chr->value_uuid, ATT_NONE,
+				ATT_NOT_PERMITTED, chr->value, chr->vlen);
+	g_assert(a != NULL);
+	*attrs = g_slist_append(*attrs, a);
+}
+
 static void register_services(gpointer data, gpointer user_data)
 {
 	struct gatt_service *svc = data;
@@ -477,6 +520,8 @@ static void register_services(gpointer data, gpointer user_data)
 
 		DBG("include: handle=0x%04x", a->handle);
 	}
+
+	g_slist_foreach(svc->chars, register_characteristics, &svc->attrs);
 }
 
 static void free_services(gpointer data, gpointer user_data)
-- 
1.7.0.4

