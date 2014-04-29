Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] hog: Fix checking for Report ID item
Date: Tue, 29 Apr 2014 11:29:39 +0200
Message-ID: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Report ID item is detected by just looking for possible item prefixes
anywhere in report map. This could lead to false-positive detection if
value we look for is inside item data.

This patch adds simple parser which can split report map into proper
items and check for Report ID item in reliable way.
---
 profiles/input/hog.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index a11e04e..ab88414 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -345,6 +345,39 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					external_service_char_cb, hogdev);
 }
 
+static bool parse_descriptor_item(uint8_t *buf, ssize_t blen, ssize_t *len,
+								bool *is_long)
+{
+	if (!blen)
+		return false;
+
+	if (buf[0] == 0xFE) {
+		if (blen < 3)
+			return false;
+		/* long item:
+		 * byte 0 -> 0xFE
+		 * byte 1 -> data size
+		 * byte 2 -> tag
+		 * + data
+		 */
+		*len = buf[1] + 3;
+		*is_long = true;
+	} else {
+		uint8_t b_size;
+		/* short item:
+		 * byte 0[1..0] -> data size (=0, 1, 2, 4)
+		 * byte 0[3..2] -> type
+		 * byte 0[7..4] -> tag
+		 * + data
+		 */
+		b_size = buf[0] & 0x03;
+		*len = (b_size ? 1 << (b_size - 1) : 0) + 1;
+		*is_long = false;
+	}
+
+	return *len <= blen;
+}
+
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -355,6 +388,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
 	int i;
+	int next_item = 0;
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
@@ -369,11 +403,27 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Report MAP:");
 	for (i = 0; i < vlen; i++) {
-		switch (value[i]) {
-		case 0x85:
-		case 0x86:
-		case 0x87:
-			hogdev->has_report_id = TRUE;
+		ssize_t item_len = 0;
+		bool is_long_item = false;
+
+		if (i == next_item) {
+			if (parse_descriptor_item(&value[i], vlen - i,
+							&item_len,
+							&is_long_item)) {
+				/* Report ID is short item with prefix
+				 * 100001xx (binary)
+				 */
+				if (!is_long_item && (value[i] & 0xfc) == 0x84)
+					hogdev->has_report_id = TRUE;
+
+				next_item += item_len;
+			} else {
+				error("Report Map parsing failed at %d", i);
+
+				/* We do not increase next_item here so we won't
+				 * parse subsequent data - this is what we want.
+				 */
+			}
 		}
 
 		if (i % 2 == 0) {
-- 
1.9.2

