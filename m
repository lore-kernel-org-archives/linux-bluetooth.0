Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 05/16] attrib/gatt: Improve robustness when searching for characteristics
Date: Thu, 26 Feb 2015 10:39:32 +0100
Message-Id: <1424943583-30061-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1424943583-30061-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this patch it is possible to enter infinite loop when searching
characteristics on remote device.
This patch fixes that.

Issue happens when remote device replies with ending handle which is
lower than start handle we use for search.

Found on robustness session on UPF50
---
 attrib/gatt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 4bffd64..2749c46 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -72,6 +72,7 @@ struct discover_char {
 	unsigned int id;
 	bt_uuid_t *uuid;
 	uint16_t end;
+	uint16_t start;
 	GSList *characteristics;
 	gatt_cb_t cb;
 	void *user_data;
@@ -629,7 +630,18 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 	att_data_list_free(list);
 
-	if (last != 0 && (last + 1 < dc->end)) {
+	/*
+	 * If last handle is lower from previous start handle then it is smth
+	 * wrong. Let's stop search, otherwise we might enter infinite loop.
+	 */
+	if (last < dc->start) {
+		err = ATT_ECODE_UNLIKELY;
+		goto done;
+	}
+
+	dc->start = last + 1;
+
+	if (last != 0 && (dc->start < dc->end)) {
 		bt_uuid_t uuid;
 		guint16 oplen;
 		size_t buflen;
@@ -639,7 +651,7 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 
 		bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
 
-		oplen = enc_read_by_type_req(last + 1, dc->end, &uuid, buf,
+		oplen = enc_read_by_type_req(dc->start, dc->end, &uuid, buf,
 									buflen);
 
 		if (oplen == 0)
@@ -680,6 +692,7 @@ guint gatt_discover_char(GAttrib *attrib, uint16_t start, uint16_t end,
 	dc->cb = func;
 	dc->user_data = user_data;
 	dc->end = end;
+	dc->start = start;
 	dc->uuid = g_memdup(uuid, sizeof(bt_uuid_t));
 
 	dc->id = g_attrib_send(attrib, 0, buf, plen, char_discovered_cb,
-- 
1.8.4

