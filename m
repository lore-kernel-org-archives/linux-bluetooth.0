Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [RFC v2 05/16] HoG: discover descriptors for all characteristics
Date: Wed, 18 Apr 2012 19:08:13 -0300
Message-Id: <1334786904-26282-6-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

"Report" characteristic has "Report Reference Characteristic" descriptor and
"Client Characteristic Configuration" descriptor.
---
 input/hog_device.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index a1b0bb4..7d2b6c0 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -70,6 +70,55 @@ static void report_free(struct report *report)
 	g_free(report);
 }
 
+static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
+					guint16 len, gpointer user_data)
+{
+	struct report *report = user_data;
+	struct att_data_list *list;
+	uint8_t format;
+	int i;
+
+	if (status != 0) {
+		error("Discover all characteristic descriptors failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	list = dec_find_info_resp(pdu, len, &format);
+	if (list == NULL)
+		return;
+
+	if (format != 0x01)
+		goto done;
+
+	for (i = 0; i < list->num; i++) {
+		uint16_t uuid16;
+		uint8_t *value;
+
+		value = list->data[i];
+		uuid16 = att_get_u16(&value[2]);
+
+		DBG("%s descriptor: 0x%04x", report->decl->uuid, uuid16);
+	}
+
+done:
+	att_data_list_free(list);
+}
+
+static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
+				struct gatt_char *next, gpointer user_data)
+{
+	uint16_t start, end;
+
+	start = chr->value_handle + 1;
+	end = (next ? next->handle - 1 : 0xffff);
+
+	if (start >= end)
+		return;
+
+	gatt_find_info(attrib, start, end, discover_descriptor_cb, user_data);
+}
+
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
@@ -86,9 +135,12 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
 
 	for (l = chars; l; l = g_slist_next(l)) {
-		struct gatt_char *chr = l->data;
+		struct gatt_char *chr, *next;
 		bt_uuid_t uuid;
 
+		chr = l->data;
+		next = l->next ? l->next->data : NULL;
+
 		DBG("0x%04x UUID: %s properties: %02x",
 				chr->handle, chr->uuid, chr->properties);
 
@@ -100,6 +152,8 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 		report = g_new0(struct report, 1);
 		report->decl = g_memdup(chr, sizeof(*chr));
 		hogdev->reports = g_slist_append(hogdev->reports, report);
+
+		discover_descriptor(hogdev->attrib, chr, next, hogdev);
 	}
 }
 
-- 
1.7.7.6

