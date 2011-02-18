Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC v2 11/14] Change SDP XML parser to create UUID128 values on host order
Date: Fri, 18 Feb 2011 20:29:30 -0200
Message-Id: <1298068173-16518-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298068173-16518-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdp-xml.c |   73 +++++++++++++++++++++++++--------------------------------
 1 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 48a3808..9c029d6 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -46,6 +46,7 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		void *data, void (*appender)(void *, const char *))
 {
 	int i, hex;
+	uint128_t n128;
 	char buf[STRBUFSIZE];
 	char indent[MAXINDENT];
 	char next_indent[MAXINDENT];
@@ -116,9 +117,10 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		appender(data, indent);
 		appender(data, "<uint128 value=\"");
 
+		hton128(&value->val.uint128, &n128);
 		for (i = 0; i < 16; i++) {
 			sprintf(&buf[i * 2], "%02x",
-				(unsigned char) value->val.uint128.data[i]);
+					(unsigned char) n128.data[i]);
 		}
 
 		appender(data, buf);
@@ -161,9 +163,10 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		appender(data, indent);
 		appender(data, "<int128 value=\"");
 
+		hton128(&value->val.uint128, &n128);
 		for (i = 0; i < 16; i++) {
 			sprintf(&buf[i * 2], "%02x",
-				(unsigned char) value->val.int128.data[i]);
+				(unsigned char) n128.data[i]);
 		}
 		appender(data, buf);
 
@@ -190,40 +193,26 @@ static void convert_raw_data_to_xml(sdp_data_t *value, int indent_level,
 		appender(data, indent);
 		appender(data, "<uuid value=\"");
 
+		hton128(&value->val.uint128, &n128);
+
 		snprintf(buf, STRBUFSIZE - 1,
 			 "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[0],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[1],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[2],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[3],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[4],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[5],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[6],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[7],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[8],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[9],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[10],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[11],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[12],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[13],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[14],
-			 (unsigned char) value->val.uuid.value.
-			 uuid128.data[15]);
+			 (unsigned char) n128.data[0],
+			 (unsigned char) n128.data[1],
+			 (unsigned char) n128.data[2],
+			 (unsigned char) n128.data[3],
+			 (unsigned char) n128.data[4],
+			 (unsigned char) n128.data[5],
+			 (unsigned char) n128.data[6],
+			 (unsigned char) n128.data[7],
+			 (unsigned char) n128.data[8],
+			 (unsigned char) n128.data[9],
+			 (unsigned char) n128.data[10],
+			 (unsigned char) n128.data[11],
+			 (unsigned char) n128.data[12],
+			 (unsigned char) n128.data[13],
+			 (unsigned char) n128.data[14],
+			 (unsigned char) n128.data[15]);
 
 		appender(data, buf);
 		appender(data, "\" />\n");
@@ -417,12 +406,12 @@ void convert_sdp_record_to_xml(sdp_record_t *rec,
 
 static sdp_data_t *sdp_xml_parse_uuid128(const char *data)
 {
-	uint128_t val;
+	uint128_t n128, h128;
 	unsigned int i, j;
 
 	char buf[3];
 
-	memset(&val, 0, sizeof(val));
+	memset(&n128, 0, sizeof(n128));
 
 	buf[2] = '\0';
 
@@ -435,11 +424,12 @@ static sdp_data_t *sdp_xml_parse_uuid128(const char *data)
 		buf[0] = data[i];
 		buf[1] = data[i + 1];
 
-		val.data[j++] = strtoul(buf, 0, 16);
+		n128.data[j++] = strtoul(buf, 0, 16);
 		i += 2;
 	}
 
-	return sdp_data_alloc(SDP_UUID128, &val);
+	ntoh128(&n128, &h128);
+	return sdp_data_alloc(SDP_UUID128, &h128);
 }
 
 sdp_data_t *sdp_xml_parse_uuid(const char *data, sdp_record_t *record)
@@ -603,7 +593,7 @@ sdp_data_t *sdp_xml_parse_int(const char * data, uint8_t dtd)
 	case SDP_INT128:
 	case SDP_UINT128:
 	{
-		uint128_t val;
+		uint128_t n128, h128;
 		int i = 0;
 		char buf[3];
 
@@ -613,10 +603,11 @@ sdp_data_t *sdp_xml_parse_int(const char * data, uint8_t dtd)
 			buf[0] = data[i];
 			buf[1] = data[i + 1];
 
-			val.data[i >> 1] = strtoul(buf, 0, 16);
+			n128.data[i >> 1] = strtoul(buf, 0, 16);
 		}
 
-		ret = sdp_data_alloc(dtd, &val);
+		ntoh128(&n128, &h128);
+		ret = sdp_data_alloc(dtd, &h128);
 		break;
 	}
 
-- 
1.7.4.1

