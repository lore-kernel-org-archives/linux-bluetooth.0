Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 07/10] android/client: Add GATT complex type parsing
Date: Thu, 31 Oct 2013 11:45:12 +0100
Message-ID: <1383216315-30627-8-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383216315-30627-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds code to parse: UUID, service ID, characteristic ID,
and general hex string filed.
---
 android/client/if-gatt.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index 70dbb24..62e0a81 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -136,10 +136,79 @@ static char *gatt_uuid_t2str(const bt_uuid_t *uuid, char *buf)
  */
 static void scan_field(const char *str, int len, uint8_t *out, int out_size)
 {
+	int i;
+
+	memset(out, 0, out_size);
+	if (out_size * 2 > len + 1)
+		out_size = (len + 1) / 2;
+
+	for (i = 0; i < out_size && len > 0; ++i) {
+		len -= 2;
+		if (len >= 0)
+			sscanf(str + len, "%02hhx", &out[i]);
+		else
+			sscanf(str, "%1hhx", &out[i]);
+	}
 }
 
+/* Like strchr but with upper limit instead of 0 terminated string */
+static const char *strchrlimit(const char *p, const char *e, int c)
+{
+	while (p < e && *p != (char) c)
+		++p;
+
+	return p < e ? p : NULL;
+}
+
+/*
+ * converts string to uuid
+ * it accepts uuid in following forms:
+ *	123
+ *	0000123
+ *	0000123-0014-1234-0000-000056789abc
+ *	0000123001412340000000056789abc
+ *	123-14-1234-0-56789abc
+ */
 static void gatt_str2bt_uuid_t(const char *str, int len, bt_uuid_t *uuid)
 {
+	int dash_cnt = 0;
+	int dashes[6] = {-1}; /* indexes of '-' or \0 */
+	static uint8_t filed_offset[] = { 16, 12, 10, 8, 6, 0 };
+	const char *p = str;
+	const char *e;
+	int i;
+
+	e = str + ((len >= 0) ? len : (int) strlen(str));
+
+	while (p != NULL && dash_cnt < 5) {
+		const char *f = strchrlimit(p, e, '-');
+
+		if (f != NULL)
+			dashes[++dash_cnt] = f++ - str;
+		p = f;
+	}
+
+	/* get index of \0 to dashes table */
+	if (dash_cnt < 5)
+		dashes[++dash_cnt] = e - str;
+
+	memcpy(uuid, GATT_BASE_UUID, sizeof(bt_uuid_t));
+
+	/* whole uuid in one string without dashes */
+	if (dash_cnt == 1 && dashes[1] > 8) {
+		if (dashes[1] > 32)
+			dashes[1] = 32;
+		scan_field(str, dashes[1],
+				&uuid->uu[16 - (dashes[1] + 1) / 2],
+				(dashes[1] + 1) / 2);
+	} else {
+		for (i = 0; i < dash_cnt; ++i) {
+			scan_field(str + dashes[i] + 1,
+					dashes[i + 1] - dashes[i] - 1,
+					&uuid->uu[filed_offset[i + 1]],
+					filed_offset[i] - filed_offset[i + 1]);
+		}
+	}
 }
 
 /* char_id formating function */
@@ -155,6 +224,26 @@ static char *btgatt_char_id_t2str(const btgatt_char_id_t *char_id, char *buf)
 /* Parse btgatt_char_id_t */
 static void str2btgatt_char_id_t(const char *buf, btgatt_char_id_t *char_id)
 {
+	const char *e;
+
+	memcpy(&char_id->uuid, &GATT_BASE_UUID, sizeof(bt_uuid_t));
+	char_id->inst_id = 0;
+
+	if (*buf == '{')
+		buf++;
+	e = strpbrk(buf, " ,}");
+	if (e == NULL)
+		e = buf + strlen(buf);
+
+	gatt_str2bt_uuid_t(buf, e - buf, &char_id->uuid);
+	if (*e == ',') {
+		buf = e + 1;
+		e = strpbrk(buf, " ,}");
+		if (e == NULL)
+			e = buf + strlen(buf);
+		if (buf < e)
+			char_id->inst_id = atoi(buf);
+	}
 }
 
 /* service_id formating function */
@@ -170,6 +259,36 @@ static char *btgatt_srvc_id_t2str(const btgatt_srvc_id_t *srvc_id, char *buf)
 /* Parse btgatt_srvc_id_t */
 static void str2btgatt_srvc_id_t(const char *buf, btgatt_srvc_id_t *srvc_id)
 {
+	const char *e;
+
+	memcpy(&srvc_id->id.uuid, &GATT_BASE_UUID, sizeof(bt_uuid_t));
+	srvc_id->id.inst_id = 0;
+	srvc_id->is_primary = 1;
+
+	if (*buf == '{')
+		buf++;
+	e = strpbrk(buf, " ,}");
+	if (e == NULL)
+		e = buf + strlen(buf);
+
+	gatt_str2bt_uuid_t(buf, e - buf, &srvc_id->id.uuid);
+	if (*e == ',') {
+		buf = e + 1;
+		e = strpbrk(buf, " ,}");
+		if (e == NULL)
+			e = buf + strlen(buf);
+		if (buf < e)
+			srvc_id->id.inst_id = atoi(buf);
+	}
+
+	if (*e == ',') {
+		buf = e + 1;
+		e = strpbrk(buf, " ,}");
+		if (e == NULL)
+			e = buf + strlen(buf);
+		if (buf < e)
+			srvc_id->is_primary = atoi(buf);
+	}
 }
 
 /* Converts array of uint8_t to string representation */
-- 
1.7.9.5

