Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 04/18] cyclingspeed: Discover characteristics CCC
Date: Thu, 25 Oct 2012 16:43:34 +0200
Message-ID: <1351176228-5789-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1351176228-5789-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/cyclingspeed/cyclingspeed.c | 82 +++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 5744891..0191f1b 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -52,9 +52,15 @@ struct csc {
 
 	struct att_range	*svc_range;
 
+	uint16_t		measurement_ccc_handle;
 	uint16_t		controlpoint_val_handle;
 };
 
+struct characteristic {
+	struct csc	*csc;
+	char		uuid[MAX_LEN_UUID_STR + 1];
+};
+
 static GSList *csc_adapters = NULL;
 
 static gint cmp_adapter(gconstpointer a, gconstpointer b)
@@ -111,6 +117,76 @@ static void destroy_csc(gpointer user_data)
 	g_free(csc);
 }
 
+static void discover_desc_cb(guint8 status, const guint8 *pdu,
+					guint16 len, gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	struct att_data_list *list = NULL;
+	uint8_t format;
+	int i;
+
+	if (status != 0) {
+		error("Discover %s descriptors failed: %s", ch->uuid,
+							att_ecode2str(status));
+		goto done;
+	}
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (list == NULL)
+		goto done;
+
+	if (format != ATT_FIND_INFO_RESP_FMT_16BIT)
+		goto done;
+
+	for (i = 0; i < list->num; i++) {
+		uint8_t *value;
+		uint16_t handle, uuid;
+
+		value = list->data[i];
+		handle = att_get_u16(value);
+		uuid = att_get_u16(value + 2);
+
+		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
+			continue;
+
+		if (g_strcmp0(ch->uuid, CSC_MEASUREMENT_UUID) == 0)
+			ch->csc->measurement_ccc_handle = handle;
+
+		/* We only want CCC, can break here */
+		break;
+	}
+
+done:
+	if (list)
+		att_data_list_free(list);
+	g_free(ch);
+}
+
+static void discover_desc(struct csc *csc, struct gatt_char *c,
+						struct gatt_char *c_next)
+{
+	struct characteristic *ch;
+	uint16_t start, end;
+
+	start = c->value_handle + 1;
+
+	if (c_next != NULL) {
+		if (start == c_next->handle)
+			return;
+		end = c_next->handle - 1;
+	} else if (c->value_handle != csc->svc_range->end) {
+		end = csc->svc_range->end;
+	} else {
+		return;
+	}
+
+	ch = g_new0(struct characteristic, 1);
+	ch->csc = csc;
+	memcpy(ch->uuid, c->uuid, sizeof(c->uuid));
+
+	gatt_find_info(csc->attrib, start, end, discover_desc_cb, ch);
+}
+
 static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct csc *csc = user_data;
@@ -123,9 +199,11 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 
 	for (; chars; chars = chars->next) {
 		struct gatt_char *c = chars->data;
+		struct gatt_char *c_next =
+				(chars->next ? chars->next->data : NULL);
 
 		if (g_strcmp0(c->uuid, CSC_MEASUREMENT_UUID) == 0) {
-			/* TODO: discover CCC handle */
+			discover_desc(csc, c, c_next);
 		} else if (g_strcmp0(c->uuid, CSC_FEATURE_UUID) == 0) {
 			/* TODO: read characterictic value */
 		} else if (g_strcmp0(c->uuid, SENSOR_LOCATION_UUID) == 0) {
@@ -134,7 +212,7 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 		} else if (g_strcmp0(c->uuid, SC_CONTROL_POINT_UUID) == 0) {
 			DBG("SC Control Point supported");
 			csc->controlpoint_val_handle = c->value_handle;
-			/* TODO: discover CCC handle */
+			discover_desc(csc, c, c_next);
 		}
 	}
 }
-- 
1.8.0

