Return-Path: <cyrus@holtmann.org>
From: Bart Westgeest <bart@elbrys.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bart Westgeest <bart@elbrys.com>
Subject: [PATCH 3/3] sdp: Upgrade datatype SEQ8 to SEQ16 when data size is greater than 256
Date: Mon, 19 Nov 2012 14:04:32 -0500
Message-Id: <1353351872-10628-4-git-send-email-bart@elbrys.com>
In-Reply-To: <1353351872-10628-1-git-send-email-bart@elbrys.com>
References: <1353351872-10628-1-git-send-email-bart@elbrys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes a bug where the complete sequence data is written, but the size
is truncated to one byte.
---
 lib/sdp.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 026163e..ceb1192 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -786,23 +786,29 @@ static int sdp_gen_buffer(sdp_buf_t *buf, sdp_data_t *d)
 
 int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 {
-	uint32_t pdu_size = 0, data_size = 0;
+	uint32_t pdu_size, data_size;
 	unsigned char *src = NULL, is_seq = 0, is_alt = 0;
-	uint8_t dtd = d->dtd;
 	uint16_t u16;
 	uint32_t u32;
 	uint64_t u64;
 	uint128_t u128;
 	uint8_t *seqp = buf->data + buf->data_size;
+	uint32_t orig_data_size = buf->data_size;
 
-	pdu_size = sdp_get_data_type_size(dtd);
+recalculate:
+	pdu_size = sdp_get_data_type_size(d->dtd);
 	buf->data_size += pdu_size;
 
 	data_size = sdp_get_data_size(buf, d);
+	if (data_size > UCHAR_MAX && d->dtd == SDP_SEQ8) {
+		buf->data_size = orig_data_size;
+		d->dtd = SDP_SEQ16;
+		goto recalculate;
+	}
 
-	*seqp = dtd;
+	*seqp = d->dtd;
 
-	switch (dtd) {
+	switch (d->dtd) {
 	case SDP_DATA_NIL:
 		break;
 	case SDP_UINT8:
@@ -884,7 +890,7 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 		if (src && buf->buf_size >= buf->data_size + data_size) {
 			memcpy(buf->data + buf->data_size, src, data_size);
 			buf->data_size += data_size;
-		} else if (dtd != SDP_DATA_NIL) {
+		} else if (d->dtd != SDP_DATA_NIL) {
 			SDPDBG("Gen PDU : Can't copy from invalid source or dest\n");
 		}
 	}
-- 
1.7.10.4

