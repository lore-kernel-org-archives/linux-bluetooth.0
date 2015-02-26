Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 02/16] attrib/gatt: Improve robustness on search primary services
Date: Thu, 26 Feb 2015 10:39:29 +0100
Message-Id: <1424943583-30061-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this it is possible to put BlueZ into infinite loop when
doing primary service search on remote device.

Issue happens when remote device replies with ending handle which is
lower than start handle we use for search.

This patch fixes that

Found on robustness session on UPF50
---
 attrib/gatt.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index aafd3f7..b8d766c 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -43,6 +43,7 @@ struct discover_primary {
 	GAttrib *attrib;
 	unsigned int id;
 	bt_uuid_t uuid;
+	uint16_t start;
 	GSList *primaries;
 	gatt_cb_t cb;
 	void *user_data;
@@ -255,8 +256,19 @@ static void primary_by_uuid_cb(guint8 status, const guint8 *ipdu,
 	if (range->end == 0xffff)
 		goto done;
 
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (range->end < dp->start) {
+		err = ATT_ECODE_UNLIKELY;
+		goto done;
+	}
+
+	dp->start = range->end + 1;
+
 	buf = g_attrib_get_buffer(dp->attrib, &buflen);
-	oplen = encode_discover_primary(range->end + 1, 0xffff, &dp->uuid,
+	oplen = encode_discover_primary(dp->start, 0xffff, &dp->uuid,
 								buf, buflen);
 
 	if (oplen == 0)
@@ -325,12 +337,24 @@ static void primary_all_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	att_data_list_free(list);
 	err = 0;
 
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (end < dp->start) {
+		err = ATT_ECODE_UNLIKELY;
+		goto done;
+	}
+
+	dp->start = end + 1;
+
 	if (end != 0xffff) {
 		size_t buflen;
 		uint8_t *buf = g_attrib_get_buffer(dp->attrib, &buflen);
-		guint16 oplen = encode_discover_primary(end + 1, 0xffff, NULL,
+		guint16 oplen = encode_discover_primary(dp->start, 0xffff, NULL,
 								buf, buflen);
 
+
 		g_attrib_send(dp->attrib, dp->id, buf, oplen, primary_all_cb,
 						discover_primary_ref(dp),
 						discover_primary_unref);
@@ -362,6 +386,7 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	dp->attrib = g_attrib_ref(attrib);
 	dp->cb = func;
 	dp->user_data = user_data;
+	dp->start = 0x0001;
 
 	if (uuid) {
 		dp->uuid = *uuid;
-- 
1.8.4

