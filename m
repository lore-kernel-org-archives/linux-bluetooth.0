Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/2] hog: Improve report map debugging
Date: Tue, 29 Apr 2014 11:29:40 +0200
Message-ID: <1398763780-16592-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1398763780-16592-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we can split report map into items it's convenient to have it
printed with items structure preserved which makes it more useful for
debugging.
---
 profiles/input/hog.c | 64 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index ab88414..c43ce6a 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -378,6 +378,28 @@ static bool parse_descriptor_item(uint8_t *buf, ssize_t blen, ssize_t *len,
 	return *len <= blen;
 }
 
+static void report_map_item(uint8_t *buf, uint8_t len)
+{
+	char str[51]; /* 16x3 (data) + 2 (continuation marker) + 1 (null) */
+	char *p = str;
+	int i;
+
+	i = 0;
+	while (i < len) {
+		p += sprintf(p, " %02x", buf[i]);
+
+		i++;
+
+		if (i % 16 == 0 && i < len) {
+			sprintf(p, " \\");
+			DBG("%s", str);
+			p = str;
+		}
+	}
+
+	DBG("%s", str);
+}
+
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -388,7 +410,6 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
 	int i;
-	int next_item = 0;
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
@@ -402,35 +423,26 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	DBG("Report MAP:");
-	for (i = 0; i < vlen; i++) {
+	for (i = 0; i < vlen;) {
 		ssize_t item_len = 0;
 		bool is_long_item = false;
 
-		if (i == next_item) {
-			if (parse_descriptor_item(&value[i], vlen - i,
-							&item_len,
-							&is_long_item)) {
-				/* Report ID is short item with prefix
-				 * 100001xx (binary)
-				 */
-				if (!is_long_item && (value[i] & 0xfc) == 0x84)
-					hogdev->has_report_id = TRUE;
-
-				next_item += item_len;
-			} else {
-				error("Report Map parsing failed at %d", i);
-
-				/* We do not increase next_item here so we won't
-				 * parse subsequent data - this is what we want.
-				 */
-			}
-		}
+		if (parse_descriptor_item(&value[i], vlen - i,
+						&item_len,
+						&is_long_item)) {
+			/* Report ID is short item with prefix 100001xx */
+			if (!is_long_item && (value[i] & 0xfc) == 0x84)
+				hogdev->has_report_id = TRUE;
 
-		if (i % 2 == 0) {
-			if (i + 1 == vlen)
-				DBG("\t %02x", value[i]);
-			else
-				DBG("\t %02x %02x", value[i], value[i + 1]);
+			report_map_item(&value[i], item_len);
+
+			i += item_len;
+		} else {
+			error("Report Map parsing failed at %d", i);
+
+			/* Just print remaining items at once and break */
+			report_map_item(&value[i], vlen - i);
+			break;
 		}
 	}
 
-- 
1.9.2

