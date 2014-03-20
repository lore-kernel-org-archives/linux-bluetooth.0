Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 42/62] Replace att_get_u16() by get_le16()
Date: Thu, 20 Mar 2014 11:43:07 -0300
Message-Id: <1395326607-27068-43-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att.c                         | 44 ++++++++++++++++++------------------
 attrib/gatt.c                        | 14 ++++++------
 attrib/gattrib.c                     |  3 ++-
 attrib/gatttool.c                    |  6 ++---
 attrib/interactive.c                 |  6 ++---
 profiles/cyclingspeed/cyclingspeed.c | 12 +++++-----
 profiles/deviceinfo/deviceinfo.c     |  5 ++--
 profiles/gatt/gas.c                  | 11 +++++----
 profiles/heartrate/heartrate.c       | 11 +++++----
 profiles/input/hog.c                 |  9 ++++----
 profiles/scanparam/scan.c            |  5 ++--
 profiles/thermometer/thermometer.c   | 14 ++++++------
 src/attrib-server.c                  |  5 ++--
 13 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/attrib/att.c b/attrib/att.c
index b353499..1df6190 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -165,8 +165,8 @@ uint16_t dec_read_by_grp_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (len != (min_len + 2) && len != (min_len + 16))
 		return 0;
 
-	*start = att_get_u16(&pdu[1]);
-	*end = att_get_u16(&pdu[3]);
+	*start = get_le16(&pdu[1]);
+	*end = get_le16(&pdu[3]);
 	if (len == min_len + 2)
 		bt_uuid16_create(uuid, get_le16(&pdu[5]));
 	else
@@ -293,9 +293,9 @@ uint16_t dec_find_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 		return 0;
 
 	/* First requested handle number (2 octets) */
-	*start = att_get_u16(&pdu[1]);
+	*start = get_le16(&pdu[1]);
 	/* Last requested handle number (2 octets) */
-	*end = att_get_u16(&pdu[3]);
+	*end = get_le16(&pdu[3]);
 	/* 16-bit UUID to find (2 octets) */
 	bt_uuid16_create(uuid, get_le16(&pdu[5]));
 
@@ -354,8 +354,8 @@ GSList *dec_find_by_type_resp(const uint8_t *pdu, size_t len)
 				len >= (offset + sizeof(uint16_t) * 2);
 				offset += sizeof(uint16_t) * 2) {
 		range = g_new0(struct att_range, 1);
-		range->start = att_get_u16(&pdu[offset]);
-		range->end = att_get_u16(&pdu[offset + 2]);
+		range->start = get_le16(&pdu[offset]);
+		range->end = get_le16(&pdu[offset + 2]);
 
 		matches = g_slist_append(matches, range);
 	}
@@ -407,8 +407,8 @@ uint16_t dec_read_by_type_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (pdu[0] != ATT_OP_READ_BY_TYPE_REQ)
 		return 0;
 
-	*start = att_get_u16(&pdu[1]);
-	*end = att_get_u16(&pdu[3]);
+	*start = get_le16(&pdu[1]);
+	*end = get_le16(&pdu[3]);
 
 	if (len == min_len + 2)
 		bt_uuid16_create(uuid, get_le16(&pdu[5]));
@@ -527,7 +527,7 @@ uint16_t dec_write_cmd(const uint8_t *pdu, size_t len, uint16_t *handle,
 	if (pdu[0] != ATT_OP_WRITE_CMD)
 		return 0;
 
-	*handle = att_get_u16(&pdu[1]);
+	*handle = get_le16(&pdu[1]);
 	memcpy(value, pdu + min_len, len - min_len);
 	*vlen = len - min_len;
 
@@ -573,7 +573,7 @@ uint16_t dec_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
 	if (pdu[0] != ATT_OP_WRITE_REQ)
 		return 0;
 
-	*handle = att_get_u16(&pdu[1]);
+	*handle = get_le16(&pdu[1]);
 	*vlen = len - min_len;
 	if (*vlen > 0)
 		memcpy(value, pdu + min_len, *vlen);
@@ -647,7 +647,7 @@ uint16_t dec_read_req(const uint8_t *pdu, size_t len, uint16_t *handle)
 	if (pdu[0] != ATT_OP_READ_REQ)
 		return 0;
 
-	*handle = att_get_u16(&pdu[1]);
+	*handle = get_le16(&pdu[1]);
 
 	return min_len;
 }
@@ -673,8 +673,8 @@ uint16_t dec_read_blob_req(const uint8_t *pdu, size_t len, uint16_t *handle,
 	if (pdu[0] != ATT_OP_READ_BLOB_REQ)
 		return 0;
 
-	*handle = att_get_u16(&pdu[1]);
-	*offset = att_get_u16(&pdu[3]);
+	*handle = get_le16(&pdu[1]);
+	*offset = get_le16(&pdu[3]);
 
 	return min_len;
 }
@@ -782,8 +782,8 @@ uint16_t dec_find_info_req(const uint8_t *pdu, size_t len, uint16_t *start,
 	if (pdu[0] != ATT_OP_FIND_INFO_REQ)
 		return 0;
 
-	*start = att_get_u16(&pdu[1]);
-	*end = att_get_u16(&pdu[3]);
+	*start = get_le16(&pdu[1]);
+	*end = get_le16(&pdu[3]);
 
 	return min_len;
 }
@@ -910,7 +910,7 @@ uint16_t dec_indication(const uint8_t *pdu, size_t len, uint16_t *handle,
 	dlen = MIN(len - min_len, vlen);
 
 	if (handle)
-		*handle = att_get_u16(&pdu[1]);
+		*handle = get_le16(&pdu[1]);
 
 	memcpy(value, &pdu[3], dlen);
 
@@ -957,7 +957,7 @@ uint16_t dec_mtu_req(const uint8_t *pdu, size_t len, uint16_t *mtu)
 	if (pdu[0] != ATT_OP_MTU_REQ)
 		return 0;
 
-	*mtu = att_get_u16(&pdu[1]);
+	*mtu = get_le16(&pdu[1]);
 
 	return min_len;
 }
@@ -991,7 +991,7 @@ uint16_t dec_mtu_resp(const uint8_t *pdu, size_t len, uint16_t *mtu)
 	if (pdu[0] != ATT_OP_MTU_RESP)
 		return 0;
 
-	*mtu = att_get_u16(&pdu[1]);
+	*mtu = get_le16(&pdu[1]);
 
 	return min_len;
 }
@@ -1039,8 +1039,8 @@ uint16_t dec_prep_write_req(const uint8_t *pdu, size_t len, uint16_t *handle,
 	if (pdu[0] != ATT_OP_PREP_WRITE_REQ)
 		return 0;
 
-	*handle = att_get_u16(&pdu[1]);
-	*offset = att_get_u16(&pdu[3]);
+	*handle = get_le16(&pdu[1]);
+	*offset = get_le16(&pdu[3]);
 
 	*vlen = len - min_len;
 	if (*vlen > 0)
@@ -1092,8 +1092,8 @@ uint16_t dec_prep_write_resp(const uint8_t *pdu, size_t len, uint16_t *handle,
 	if (pdu[0] != ATT_OP_PREP_WRITE_REQ)
 		return 0;
 
-	*handle = att_get_u16(&pdu[1]);
-	*offset = att_get_u16(&pdu[3]);
+	*handle = get_le16(&pdu[1]);
+	*offset = get_le16(&pdu[3]);
 	*vlen = len - min_len;
 	if (*vlen > 0)
 		memcpy(value, pdu + min_len, *vlen);
diff --git a/attrib/gatt.c b/attrib/gatt.c
index 0d43913..83692f4 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -242,8 +242,8 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		struct gatt_primary *primary;
 		bt_uuid_t uuid;
 
-		start = att_get_u16(&data[0]);
-		end = att_get_u16(&data[2]);
+		start = get_le16(&data[0]);
+		end = get_le16(&data[2]);
 
 		if (list->len == 6) {
 			bt_uuid_t uuid16;
@@ -381,9 +381,9 @@ static struct gatt_included *included_from_buf(const uint8_t *buf, gsize len)
 {
 	struct gatt_included *incl = g_new0(struct gatt_included, 1);
 
-	incl->handle = att_get_u16(&buf[0]);
-	incl->range.start = att_get_u16(&buf[2]);
-	incl->range.end = att_get_u16(&buf[4]);
+	incl->handle = get_le16(&buf[0]);
+	incl->range.start = get_le16(&buf[2]);
+	incl->range.end = get_le16(&buf[4]);
 
 	if (len == 8) {
 		bt_uuid_t uuid128;
@@ -505,7 +505,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		struct gatt_char *chars;
 		bt_uuid_t uuid;
 
-		last = att_get_u16(value);
+		last = get_le16(value);
 
 		if (list->len == 7) {
 			bt_uuid_t uuid16;
@@ -526,7 +526,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 		chars->handle = last;
 		chars->properties = value[2];
-		chars->value_handle = att_get_u16(&value[3]);
+		chars->value_handle = get_le16(&value[3]);
 		bt_uuid_to_string(&uuid, chars->uuid, sizeof(chars->uuid));
 		dc->characteristics = g_slist_append(dc->characteristics,
 									chars);
diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 31450a3..912dffb 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -37,6 +37,7 @@
 
 #include "btio/btio.h"
 #include "lib/uuid.h"
+#include "src/shared/util.h"
 #include "src/log.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
@@ -381,7 +382,7 @@ static bool match_event(struct event *evt, const uint8_t *pdu, gsize len)
 	if (len < 3)
 		return false;
 
-	handle = att_get_u16(&pdu[1]);
+	handle = get_le16(&pdu[1]);
 
 	if (evt->expected == pdu[0] && evt->handle == handle)
 		return true;
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 10415a8..4eb2528 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -79,7 +79,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	uint16_t handle, i, olen = 0;
 	size_t plen;
 
-	handle = att_get_u16(&pdu[1]);
+	handle = get_le16(&pdu[1]);
 
 	switch (pdu[0]) {
 	case ATT_OP_HANDLE_NOTIFY:
@@ -272,7 +272,7 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		uint8_t *value = list->data[i];
 		int j;
 
-		g_print("handle: 0x%04x \t value: ", att_get_u16(value));
+		g_print("handle: 0x%04x \t value: ", get_le16(value));
 		value += 2;
 		for (j = 0; j < list->len - 2; j++, value++)
 			g_print("%02x ", *value);
@@ -424,7 +424,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		bt_uuid_t uuid;
 
 		value = list->data[i];
-		handle = att_get_u16(value);
+		handle = get_le16(value);
 
 		if (format == 0x01)
 			bt_uuid16_create(&uuid, get_le16(&value[2]));
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 38403dd..5dd47ec 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -114,7 +114,7 @@ static void events_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	size_t plen;
 	GString *s;
 
-	handle = att_get_u16(&pdu[1]);
+	handle = get_le16(&pdu[1]);
 
 	switch (pdu[0]) {
 	case ATT_OP_HANDLE_NOTIFY:
@@ -293,7 +293,7 @@ static void char_desc_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		bt_uuid_t uuid;
 
 		value = list->data[i];
-		handle = att_get_u16(value);
+		handle = get_le16(value);
 
 		if (format == 0x01)
 			bt_uuid16_create(&uuid, get_le16(&value[2]));
@@ -362,7 +362,7 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 		int j;
 
 		g_string_printf(s, "handle: 0x%04x \t value: ",
-							att_get_u16(value));
+							get_le16(value));
 		value += 2;
 		for (j = 0; j < list->len - 2; j++, value++)
 			g_string_append_printf(s, "%02x ", *value);
diff --git a/profiles/cyclingspeed/cyclingspeed.c b/profiles/cyclingspeed/cyclingspeed.c
index 1222532..63e969a 100644
--- a/profiles/cyclingspeed/cyclingspeed.c
+++ b/profiles/cyclingspeed/cyclingspeed.c
@@ -381,7 +381,7 @@ static void read_feature_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	csc->feature = att_get_u16(value);
+	csc->feature = get_le16(value);
 
 	if ((csc->feature & MULTI_SENSOR_LOC_SUPPORT)
 						&& (csc->locations == NULL))
@@ -447,8 +447,8 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu,
 		char *msg;
 
 		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid = att_get_u16(value + 2);
+		handle = get_le16(value);
+		uuid = get_le16(value + 2);
 
 		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
 			continue;
@@ -575,7 +575,7 @@ static void process_measurement(struct csc *csc, const uint8_t *pdu,
 
 		m.has_wheel_rev = true;
 		m.wheel_rev = get_le32(pdu);
-		m.last_wheel_time = att_get_u16(pdu + 4);
+		m.last_wheel_time = get_le16(pdu + 4);
 		pdu += 6;
 		len -= 6;
 	}
@@ -587,8 +587,8 @@ static void process_measurement(struct csc *csc, const uint8_t *pdu,
 		}
 
 		m.has_crank_rev = true;
-		m.crank_rev = att_get_u16(pdu);
-		m.last_crank_time = att_get_u16(pdu + 2);
+		m.crank_rev = get_le16(pdu);
+		m.last_crank_time = get_le16(pdu + 2);
 		pdu += 4;
 		len -= 4;
 	}
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 661a5dc..208598a 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -35,6 +35,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/util.h"
 #include "attrib/gattrib.h"
 #include "src/attio.h"
 #include "attrib/att.h"
@@ -96,8 +97,8 @@ static void read_pnpid_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	btd_device_set_pnpid(ch->d->dev, value[0], att_get_u16(&value[1]),
-				att_get_u16(&value[3]), att_get_u16(&value[5]));
+	btd_device_set_pnpid(ch->d->dev, value[0], get_le16(&value[1]),
+				get_le16(&value[3]), get_le16(&value[5]));
 }
 
 static void process_deviceinfo_char(struct characteristic *ch)
diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index c0526e5..38f5e72 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -40,6 +40,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/util.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "src/attio.h"
@@ -165,7 +166,7 @@ static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	atval = list->data[0] + 2; /* skip handle value */
-	app = att_get_u16(atval);
+	app = get_le16(atval);
 
 	DBG("GAP Appearance: 0x%04x", app);
 
@@ -188,8 +189,8 @@ static void indication_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 		return;
 	}
 
-	start = att_get_u16(&pdu[3]);
-	end = att_get_u16(&pdu[5]);
+	start = get_le16(&pdu[3]);
+	end = get_le16(&pdu[5]);
 
 	DBG("Service Changed start: 0x%04X end: 0x%04X", start, end);
 
@@ -263,8 +264,8 @@ static void gatt_descriptors_cb(guint8 status, const guint8 *pdu, guint16 len,
 		uint8_t *value;
 
 		value = list->data[i];
-		ccc = att_get_u16(value);
-		uuid16 = att_get_u16(&value[2]);
+		ccc = get_le16(value);
+		uuid16 = get_le16(&value[2]);
 		DBG("CCC: 0x%04x UUID: 0x%04x", ccc, uuid16);
 		write_ccc(gas->attrib, ccc, user_data);
 	}
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 97af02e..15ccdfd 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -35,6 +35,7 @@
 #include "src/dbus-common.h"
 #include "src/device.h"
 #include "src/profile.h"
+#include "src/shared/util.h"
 #include "src/service.h"
 #include "src/error.h"
 #include "attrib/gattrib.h"
@@ -324,7 +325,7 @@ static void process_measurement(struct heartrate *hr, const uint8_t *pdu,
 			return;
 		}
 
-		m.value = att_get_u16(pdu);
+		m.value = get_le16(pdu);
 		pdu += 2;
 		len -= 2;
 	} else {
@@ -345,7 +346,7 @@ static void process_measurement(struct heartrate *hr, const uint8_t *pdu,
 		}
 
 		m.has_energy = TRUE;
-		m.energy = att_get_u16(pdu);
+		m.energy = get_le16(pdu);
 		pdu += 2;
 		len -= 2;
 	}
@@ -362,7 +363,7 @@ static void process_measurement(struct heartrate *hr, const uint8_t *pdu,
 		m.interval = g_new(uint16_t, m.num_interval);
 
 		for (i = 0; i < m.num_interval; pdu += 2, i++)
-			m.interval[i] = att_get_u16(pdu);
+			m.interval[i] = get_le16(pdu);
 	}
 
 	if (flags & SENSOR_CONTACT_SUPPORT) {
@@ -418,8 +419,8 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 		uint8_t attr_val[2];
 
 		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid = att_get_u16(value + 2);
+		handle = get_le16(value);
+		uuid = get_le16(value + 2);
 
 		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
 			continue;
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index fd72e36..25985ec 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -47,6 +47,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/util.h"
 
 #include "src/plugin.h"
 
@@ -234,8 +235,8 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		uint8_t *value;
 
 		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid16 = att_get_u16(&value[2]);
+		handle = get_le16(value);
+		uuid16 = get_le16(&value[2]);
 
 		switch (uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
@@ -336,7 +337,7 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	uuid16 = att_get_u16(&pdu[1]);
+	uuid16 = get_le16(&pdu[1]);
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
 	bt_uuid16_create(&uuid, uuid16);
@@ -431,7 +432,7 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	hogdev->bcdhid = att_get_u16(&value[0]);
+	hogdev->bcdhid = get_le16(&value[0]);
 	hogdev->bcountrycode = value[2];
 	hogdev->flags = value[3];
 
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 4fd8f53..d6e477e 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -36,6 +36,7 @@
 #include "src/device.h"
 #include "src/profile.h"
 #include "src/service.h"
+#include "src/shared/util.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
@@ -119,8 +120,8 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		goto done;
 
 	ptr = list->data[0];
-	handle = att_get_u16(ptr);
-	uuid16 = att_get_u16(&ptr[2]);
+	handle = get_le16(ptr);
+	uuid16 = get_le16(&ptr[2]);
 
 	if (uuid16 != GATT_CLIENT_CHARAC_CFG_UUID)
 		goto done;
diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index d2ea56b..5b90792 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -383,7 +383,7 @@ static void proc_measurement(struct thermometer *t, const uint8_t *pdu,
 			return;
 		}
 
-		ts.tm_year = att_get_u16(pdu) - 1900;
+		ts.tm_year = get_le16(pdu) - 1900;
 		ts.tm_mon = *(pdu + 2) - 1;
 		ts.tm_mday = *(pdu + 3);
 		ts.tm_hour = *(pdu + 4);
@@ -467,7 +467,7 @@ static void interval_ind_handler(const uint8_t *pdu, uint16_t len,
 		return;
 	}
 
-	interval = att_get_u16(pdu + 3);
+	interval = get_le16(pdu + 3);
 	change_property(t, "Interval", &interval);
 
 	opdu = g_attrib_get_buffer(t->attrib, &plen);
@@ -502,8 +502,8 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	min = att_get_u16(&value[0]);
-	max = att_get_u16(&value[2]);
+	min = get_le16(&value[0]);
+	max = get_le16(&value[2]);
 
 	if (min == 0 || min > max) {
 		DBG("Invalid range");
@@ -600,8 +600,8 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 		uint16_t handle, uuid;
 
 		value = list->data[i];
-		handle = att_get_u16(value);
-		uuid = att_get_u16(value + 2);
+		handle = get_le16(value);
+		uuid = get_le16(value + 2);
 
 		process_thermometer_desc(ch, uuid, handle);
 	}
@@ -690,7 +690,7 @@ static void read_interval_cb(guint8 status, const guint8 *pdu, guint16 len,
 		return;
 	}
 
-	interval = att_get_u16(&value[0]);
+	interval = get_le16(&value[0]);
 	change_property(t, "Interval", &interval);
 }
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 3f579bb..5c6b1f8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -47,6 +47,7 @@
 #include "hcid.h"
 #include "adapter.h"
 #include "device.h"
+#include "src/shared/util.h"
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
 #include "attrib/gatt.h"
@@ -307,7 +308,7 @@ static uint32_t attrib_create_sdp_new(struct gatt_server *server,
 		return 0;
 
 	if (a->len == 2)
-		sdp_uuid16_create(&svc, att_get_u16(a->data));
+		sdp_uuid16_create(&svc, get_le16(a->data));
 	else if (a->len == 16)
 		sdp_uuid128_create(&svc, a->data);
 	else
@@ -894,7 +895,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 							status, pdu, len);
 		}
 	} else {
-		uint16_t cccval = att_get_u16(value);
+		uint16_t cccval = get_le16(value);
 		char *filename;
 		GKeyFile *key_file;
 		char group[6], value[5];
-- 
1.8.3.1

