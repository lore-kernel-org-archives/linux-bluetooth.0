Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Allow to handle SDP records bigger than 512 bytes
From: Unai Uribarri <unaiur@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-IEHzwv+L9b6IvbK90GL0"
Date: Wed, 13 May 2009 12:20:30 +0200
Message-Id: <1242210030.8227.29.camel@optenet-laptop-unai>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-IEHzwv+L9b6IvbK90GL0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

sdp_append_to_pdu statically allocates a buffer of 512 bytes. This patch calculates
the amount of memory needed and allocates dynamically using malloc.


--=-IEHzwv+L9b6IvbK90GL0
Content-Disposition: attachment; filename="bluez-sdp-big-pdus.diff"
Content-Type: text/x-patch; name="bluez-sdp-big-pdus.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/lib/sdp.c b/lib/sdp.c
index 39d408a..2ac0edc 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2653,19 +2653,91 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 	}
 }
 
+/* This function returns the amount of bytes needed to serialize a sdp_data_t
+ * structure.
+ *
+ * This function is needed since d->unitSize doesn't contain the valid size for URL
+ * and TEXT data types.
+ */
+static unsigned get_pdu_size(sdp_data_t *d)
+{
+	unsigned res = 1;
+
+	switch (d->dtd) {
+	case SDP_DATA_NIL:
+		break;
+	case SDP_UINT8:
+	case SDP_INT8:
+	case SDP_BOOL:
+		res += sizeof(uint8_t);
+		break;
+	case SDP_UINT16:
+	case SDP_INT16:
+	case SDP_UUID16:
+		res += sizeof(uint16_t);
+		break;
+	case SDP_UINT32:
+	case SDP_INT32:
+	case SDP_UUID32:
+		res += sizeof(uint32_t);
+		break;
+	case SDP_UINT64:
+	case SDP_INT64:
+		res += sizeof(uint64_t);
+		break;
+	case SDP_UINT128:
+	case SDP_INT128:
+	case SDP_UUID128:
+		res += sizeof(uint128_t);
+		break;
+	case SDP_TEXT_STR8:
+	case SDP_URL_STR8:
+		res += sizeof(uint8_t) + d->unitSize;
+		break;
+	case SDP_TEXT_STR16:
+	case SDP_URL_STR16:
+		res += sizeof(uint16_t) + d->unitSize;
+		break;
+	case SDP_TEXT_STR32:
+	case SDP_URL_STR32:
+		res += sizeof(uint32_t) + d->unitSize;
+		break;
+	case SDP_SEQ8:
+	case SDP_ALT8:
+		res += sizeof(uint8_t);
+		for (d = d->val.dataseq; d; d = d->next)
+			res += get_pdu_size(d);
+		break;
+	case SDP_SEQ16:
+	case SDP_ALT16:
+		res += sizeof(uint16_t);
+		for (d = d->val.dataseq; d; d = d->next)
+			res += get_pdu_size(d);
+		break;
+	case SDP_SEQ32:
+	case SDP_ALT32:
+		res += sizeof(uint32_t);
+		for (d = d->val.dataseq; d; d = d->next)
+			res += get_pdu_size(d);
+		break;
+	}
+	return res;
+}
+	
 void sdp_append_to_pdu(sdp_buf_t *pdu, sdp_data_t *d)
 {
-	uint8_t buf[512];
 	sdp_buf_t append;
 
 	memset(&append, 0, sizeof(sdp_buf_t));
-	append.data = buf;
-	append.buf_size = sizeof(buf);
+	append.buf_size = 3 + get_pdu_size(d);
 	append.data_size = 0;
-
-	sdp_set_attrid(&append, d->attrId);
-	if (sdp_gen_pdu(&append, d) != -1)
-		sdp_append_to_buf(pdu, append.data, append.data_size);
+	append.data = malloc(append.buf_size);
+	if (append.data) {
+		sdp_set_attrid(&append, d->attrId);
+		if (sdp_gen_pdu(&append, d) != -1)
+			sdp_append_to_buf(pdu, append.data, append.data_size);
+		free(append.data);
+	}
 }
 
 /*

--=-IEHzwv+L9b6IvbK90GL0--

