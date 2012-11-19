Return-Path: <cyrus@holtmann.org>
From: Bart Westgeest <bart@elbrys.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bart Westgeest <bart@elbrys.com>
Subject: [PATCH 2/3] sdp: Limit side effects of sdp_get_data_type and sdp_get_data_size
Date: Mon, 19 Nov 2012 14:04:31 -0500
Message-Id: <1353351872-10628-3-git-send-email-bart@elbrys.com>
In-Reply-To: <1353351872-10628-1-git-send-email-bart@elbrys.com>
References: <1353351872-10628-1-git-send-email-bart@elbrys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove modification of buf->buf_size in 'get' functions. Data is
still indirectly modified due to recursive nature of code.

Renamed sdp_get_data_type to sdp_get_data_type_size.
---
 lib/sdp.c |   26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index dba3f59..026163e 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -633,37 +633,32 @@ void sdp_set_seq_len(uint8_t *ptr, uint32_t length)
 	}
 }
 
-static int sdp_get_data_type(sdp_buf_t *buf, uint8_t dtd)
+static int sdp_get_data_type_size(uint8_t dtd)
 {
-	int data_type = 0;
-
-	data_type += sizeof(uint8_t);
+	int size = sizeof(uint8_t);
 
 	switch (dtd) {
 	case SDP_SEQ8:
 	case SDP_TEXT_STR8:
 	case SDP_URL_STR8:
 	case SDP_ALT8:
-		data_type += sizeof(uint8_t);
+		size += sizeof(uint8_t);
 		break;
 	case SDP_SEQ16:
 	case SDP_TEXT_STR16:
 	case SDP_URL_STR16:
 	case SDP_ALT16:
-		data_type += sizeof(uint16_t);
+		size += sizeof(uint16_t);
 		break;
 	case SDP_SEQ32:
 	case SDP_TEXT_STR32:
 	case SDP_URL_STR32:
 	case SDP_ALT32:
-		data_type += sizeof(uint32_t);
+		size += sizeof(uint32_t);
 		break;
 	}
 
-	if (!buf->data)
-		buf->buf_size += data_type;
-
-	return data_type;
+	return size;
 }
 
 void sdp_set_attrid(sdp_buf_t *buf, uint16_t attr)
@@ -762,9 +757,6 @@ static int sdp_get_data_size(sdp_buf_t *buf, sdp_data_t *d)
 		break;
 	}
 
-	if (!buf->data)
-		buf->buf_size += data_size;
-
 	return data_size;
 }
 
@@ -783,8 +775,8 @@ static int sdp_gen_buffer(sdp_buf_t *buf, sdp_data_t *d)
 	/* attribute length */
 	buf->buf_size += sizeof(uint8_t) + sizeof(uint16_t);
 
-	sdp_get_data_type(buf, d->dtd);
-	sdp_get_data_size(buf, d);
+	buf->buf_size += sdp_get_data_type_size(d->dtd);
+	buf->buf_size += sdp_get_data_size(buf, d);
 
 	if (buf->buf_size > UCHAR_MAX && d->dtd == SDP_SEQ8)
 		buf->buf_size += sizeof(uint8_t);
@@ -803,7 +795,7 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	uint128_t u128;
 	uint8_t *seqp = buf->data + buf->data_size;
 
-	pdu_size = sdp_get_data_type(buf, dtd);
+	pdu_size = sdp_get_data_type_size(dtd);
 	buf->data_size += pdu_size;
 
 	data_size = sdp_get_data_size(buf, d);
-- 
1.7.10.4

