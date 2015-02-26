Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/16] attrib/gatt: Improve robustness when searching for descriptors
Date: Thu, 26 Feb 2015 10:39:36 +0100
Message-Id: <1424943583-30061-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this patch it is possible to enter infinite loop when
searching descriptors on remote device. This patch fixes that.

Issue happens when remote device replies with ending handle which is
lower than start handle we use for search.
---
 attrib/gatt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index df4e3a7..bc2f92a 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -83,6 +83,7 @@ struct discover_desc {
 	GAttrib *attrib;
 	unsigned int id;
 	bt_uuid_t *uuid;
+	uint16_t start;
 	uint16_t end;
 	GSList *descriptors;
 	gatt_cb_t cb;
@@ -1072,6 +1073,17 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 
 	att_data_list_free(list);
 
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (last < dd->start) {
+		err = ATT_ECODE_UNLIKELY;
+		goto done;
+	}
+
+	dd->start = last + 1;
+
 	if (last < dd->end && !uuid_found) {
 		guint16 oplen;
 		size_t buflen;
@@ -1079,7 +1091,7 @@ static void desc_discovered_cb(guint8 status, const guint8 *ipdu,
 
 		buf = g_attrib_get_buffer(dd->attrib, &buflen);
 
-		oplen = enc_find_info_req(last + 1, dd->end, buf, buflen);
+		oplen = enc_find_info_req(dd->start, dd->end, buf, buflen);
 		if (oplen == 0)
 			return;
 
@@ -1114,6 +1126,7 @@ guint gatt_discover_desc(GAttrib *attrib, uint16_t start, uint16_t end,
 	dd->attrib = g_attrib_ref(attrib);
 	dd->cb = func;
 	dd->user_data = user_data;
+	dd->start = start;
 	dd->end = end;
 	dd->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
 
-- 
1.8.4

