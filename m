Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/2] hog: Improve report map debugging
Date: Tue, 29 Apr 2014 19:25:30 +0200
Message-ID: <1398792330-23636-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1398792330-23636-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1398792330-23636-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we can split report map into items it's convenient to have it
printed with items structure preserved which makes it more useful for
debugging.

Up to 5 bytes are printed for each item which is enough for short items
and for long items continuation mark ('...') is printed if necessary.
This is because as for now there are no long item tags defined except
for some vendor defined thus we can safely "ignore" them and avoid
overly complicated code.
---
v2:
- simplified debugging code to be called only when debugging is enabled

 profiles/input/hog.c | 64 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 767bcfa..ae2affd 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -385,6 +385,28 @@ static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
 	return *len <= blen;
 }
 
+static char *item2string(char *str, uint8_t *buf, uint8_t len)
+{
+	char *p = str;
+	int i;
+
+	/*
+	 * Since long item tags are not defined except for vendor ones, we
+	 * just ensure that short items are printed properly (up to 5 bytes).
+	 */
+	for (i = 0; i < 6 && i < len; i++)
+		p += sprintf(p, " %02x", buf[i]);
+
+	/*
+	 * If there are some data left, just add continuation mark to indicate
+	 * this.
+	 */
+	if (i < len)
+		sprintf(p, " ...");
+
+	return str;
+}
+
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
@@ -394,8 +416,8 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	struct uhid_event ev;
 	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
+	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i;
-	int next_item = 0;
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
@@ -409,35 +431,25 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	DBG("Report MAP:");
-	for (i = 0; i < vlen; i++) {
+	for (i = 0; i < vlen;) {
 		ssize_t ilen = 0;
 		bool long_item = false;
 
-		if (i == next_item) {
-			if (get_descriptor_item_info(&value[i], vlen - i,
-							&ilen, &long_item)) {
-				/*
-				 * Report ID is short item with prefix 100001xx
-				 */
-				if (!long_item && (value[i] & 0xfc) == 0x84)
-					hogdev->has_report_id = TRUE;
-
-				next_item += ilen;
-			} else {
-				error("Report Map parsing failed at %d", i);
-
-				/*
-				 * We do not increase next_item here so we won't
-				 * parse subsequent data - this is what we want.
-				 */
-			}
-		}
+		if (get_descriptor_item_info(&value[i], vlen - i, &ilen,
+								&long_item)) {
+			/* Report ID is short item with prefix 100001xx */
+			if (!long_item && (value[i] & 0xfc) == 0x84)
+				hogdev->has_report_id = TRUE;
+
+			DBG("\t%s", item2string(itemstr, &value[i], ilen));
 
-		if (i % 2 == 0) {
-			if (i + 1 == vlen)
-				DBG("\t %02x", value[i]);
-			else
-				DBG("\t %02x %02x", value[i], value[i + 1]);
+			i += ilen;
+		} else {
+			error("Report Map parsing failed at %d", i);
+
+			/* Just print remaining items at once and break */
+			DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
+			break;
 		}
 	}
 
-- 
1.9.2

