Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 08/15] GATT server: parse characteristic value
Date: Wed, 16 Mar 2011 21:00:32 -0400
Message-Id: <1300323639-13296-9-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300323639-13296-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.h           |    1 +
 plugins/gatt-profile.c |   39 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 7a83bfa..4d176dd 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -109,6 +109,7 @@
 #define ATT_MAX_MTU				256
 #define ATT_DEFAULT_L2CAP_MTU			48
 #define ATT_DEFAULT_LE_MTU			23
+#define ATT_MAX_VALUE_LEN			512
 
 /* Requirements for read/write operations */
 enum {
diff --git a/plugins/gatt-profile.c b/plugins/gatt-profile.c
index 728c2ab..b0256ba 100644
--- a/plugins/gatt-profile.c
+++ b/plugins/gatt-profile.c
@@ -62,6 +62,8 @@ struct gatt_descriptor {
 
 struct gatt_characteristic {
 	uint8_t props;
+	uint8_t *value;
+	size_t vlen;
 	bt_uuid_t value_uuid;
 	GSList *descriptors;
 };
@@ -138,16 +140,20 @@ static void parse_characteristic(const gchar **attribute_names,
 						struct gatt_service *cur_svc)
 {
 	struct gatt_characteristic *chr;
-	const gchar *uuid = NULL, *props = NULL;
+	const gchar *uuid = NULL, *props = NULL, *value = NULL;
+	uint8_t atval[ATT_MAX_VALUE_LEN];
 	uint16_t u16 = 0x00;
 	bt_uuid_t value_uuid;
-	int i;
+	unsigned int i;
+	size_t vlen;
 
 	for (i = 0; attribute_names[i]; i++) {
 		if (g_strcmp0(attribute_names[i], "uuid") == 0)
 			uuid = attribute_values[i];
 		else if (g_strcmp0(attribute_names[i], "properties") == 0)
 			props = attribute_values[i];
+		else if (g_strcmp0(attribute_names[i], "value") == 0)
+			value = attribute_values[i];
 		else
 			error("Invalid XML attribute: %s", attribute_names[i]);
 	}
@@ -167,8 +173,36 @@ static void parse_characteristic(const gchar **attribute_names,
 		return;
 	}
 
+	if (value == NULL) {
+		error("Missing value for characteristic");
+		return;
+	}
+
+	vlen = strlen(value);
+
+	if (vlen == 0 || vlen % 2 != 0) {
+		error("Characteristic value must be even and not empty");
+		return;
+	}
+
+	if (vlen > ATT_MAX_VALUE_LEN * 2) {
+		error("Characteristic value too long (%zu bytes, maximum is %d"
+				" bytes)", vlen, ATT_MAX_VALUE_LEN * 2);
+		return;
+	}
+
+	for (i = 0; i < vlen / 2; i++) {
+		if (sscanf(value + (i * 2), "%02hhX", &atval[i]) != 1) {
+			error("Characteristic value contains invalid "
+								"character");
+			return;
+		}
+	}
+
 	chr = g_new0(struct gatt_characteristic, 1);
 	chr->props = u16;
+	chr->vlen = vlen / 2;
+	chr->value = g_memdup(atval, chr->vlen);
 	memcpy(&chr->value_uuid, &value_uuid, sizeof(chr->value_uuid));
 
 	DBG("New characteristic with UUID %s, properties 0x%02x", uuid,
@@ -389,6 +423,7 @@ static void free_services(gpointer data, gpointer user_data)
 		}
 
 		g_slist_free(chr->descriptors);
+		g_free(chr->value);
 		g_free(chr);
 	}
 
-- 
1.7.0.4

