Return-Path: <cyrus@holtmann.org>
From: vikrampal <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, vikram.pal@samsung.com
Subject: [PATCH ] Fixed memory issues to avoid potential crash
Date: Wed, 11 Jun 2014 15:02:30 +0530
Message-id: <1402479150-27774-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: vikrampal <vikram.pal@samsung.com>
---
 src/sdp-xml.c       | 16 +++++++++++++++-
 src/sdpd-database.c |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 6492781..a9c4723 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -91,6 +91,10 @@ static struct sdp_xml_data *sdp_xml_data_alloc(void)
 	/* Null terminate the text */
 	elem->size = DEFAULT_XML_DATA_SIZE;
 	elem->text = malloc(DEFAULT_XML_DATA_SIZE);
+	if (!elem->text) {
+		free(elem);
+		return NULL;
+	}
 	elem->text[0] = '\0';
 
 	return elem;
@@ -333,6 +337,8 @@ static char *sdp_xml_parse_string_decode(const char *data, char encoding,
 		int i;
 
 		decoded = malloc((len >> 1) + 1);
+		if (!decoded)
+			return NULL;
 
 		/* Ensure the string is a power of 2 */
 		len = (len >> 1) << 1;
@@ -823,7 +829,7 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 	{
 		int num_chars_to_escape = 0;
 		int length = value->unitSize - 1;
-		char *strBuf = 0;
+		char *strBuf;
 
 		hex = 0;
 
@@ -850,6 +856,10 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 			appender(data, "encoding=\"hex\" ");
 			strBuf = malloc(sizeof(char)
 						 * ((value->unitSize-1) * 2 + 1));
+			if (!strBuf) {
+				DBG("No memory to convert raw data to xml");
+				return;
+			}
 
 			/* Unit Size seems to include the size for dtd
 			   It is thus off by 1
@@ -866,6 +876,10 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 			/* escape the XML disallowed chars */
 			strBuf = malloc(sizeof(char) *
 					(value->unitSize + 1 + num_chars_to_escape * 4));
+			if (!strBuf) {
+				DBG("No memory to convert raw data to xml");
+				return;
+			}
 			for (i = 0, j = 0; i < length; i++) {
 				if (value->val.str[i] == '&') {
 					strBuf[j++] = '&';
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index f65a526..e825f69 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -157,6 +157,10 @@ static int compare_indices(const void *i1, const void *i2)
 void sdp_svcdb_set_collectable(sdp_record_t *record, int sock)
 {
 	sdp_indexed_t *item = malloc(sizeof(sdp_indexed_t));
+	if (!item) {
+		SDPDBG("No memory");
+		return;
+	}
 	item->sock = sock;
 	item->record = record;
 	socket_index = sdp_list_insert_sorted(socket_index, item, compare_indices);
-- 
1.9.1

