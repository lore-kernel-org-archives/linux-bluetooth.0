Return-Path: <cyrus@holtmann.org>
Subject: Segmentation fault in bluetoothd
From: Unai Uribarri <unaiur@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-8e6cIu1ZT22ddmQvAy+6"
Date: Tue, 12 May 2009 17:23:27 +0200
Message-Id: <1242141807.8227.3.camel@optenet-laptop-unai>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-8e6cIu1ZT22ddmQvAy+6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've being investigating this Ubuntu 9.04 bug
https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/332119

I've verified that the bug is reproducible with bluez-4.32, bluez-4.34
and git-tip (today at 15.00 UTC).

The root of the bug is that sdp_gen_pdu doesn't check if the given
buffer is big enough to contain the requested data. It's being called
from sdp_append_to_pdu, which uses a 512 byte array at the stack but,
when pairing with my Nokia 6161, it's called with a d parameter that
sums more that 17KB. So the stack is corrupted and the back-trace isn't
very useful.

All the other callers of sdp_gen_pdu seems to use dynamic memory
(malloc), so I've rewritten sdp_append_to_pdu to use dynamic memory
and fixed sdp_gen_pdu to grow the given buffer when it gets full.

--=-8e6cIu1ZT22ddmQvAy+6
Content-Description: 
Content-Disposition: attachment; filename="bluez-sdp-fix.diff"
Content-Type: text/x-patch; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/lib/sdp.c b/lib/sdp.c
index 2581a1d..0edf3b0 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -714,6 +714,24 @@ static int get_data_size(sdp_buf_t *buf, sdp_data_t *sdpdata)
 	return n;
 }
 
+static int sdp_buf_allocate(sdp_buf_t *buf, size_t len)
+{
+	if (buf->data_size + len > buf->buf_size)
+	{
+		int need = buf->buf_size + SDP_PDU_CHUNK_SIZE * ((len / SDP_PDU_CHUNK_SIZE) + 1);
+		void *tmp = realloc(buf->data, need);
+		SDPDBG("Realloc'ing : %d\n", need);
+
+		if (tmp == NULL) {
+			SDPERR("Realloc fails \n");
+			return -1;
+		}
+		buf->data = tmp;
+		buf->buf_size = need;
+	}
+	return 0;
+}
+
 int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 {
 	uint32_t pdu_size = 0, data_size = 0;
@@ -725,6 +743,8 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	uint128_t u128;
 	uint8_t *seqp = buf->data + buf->data_size;
 
+	if (!sdp_buf_allocate(buf, 5))
+		return -1;
 	pdu_size = sdp_set_data_type(buf, dtd);
 
 	switch (dtd) {
@@ -793,14 +813,16 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	case SDP_SEQ16:
 	case SDP_SEQ32:
 		is_seq = 1;
-		data_size = get_data_size(buf, d);
+		if ((data_size = get_data_size(buf, d)) == -1)
+			return -1;
 		sdp_set_seq_len(seqp, data_size);
 		break;
 	case SDP_ALT8:
 	case SDP_ALT16:
 	case SDP_ALT32:
 		is_alt = 1;
-		data_size = get_data_size(buf, d);
+		if ((data_size = get_data_size(buf, d)) == -1)
+			return -1;
 		sdp_set_seq_len(seqp, data_size);
 		break;
 	case SDP_UUID16:
@@ -822,7 +844,9 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	}
 
 	if (!is_seq && !is_alt) {
-		if (src && buf && buf->buf_size >= buf->data_size + data_size) {
+		if (src) {
+			if (!sdp_buf_allocate(buf, data_size))
+				return -1;
 			memcpy(buf->data + buf->data_size, src, data_size);
 			buf->data_size += data_size;
 		} else if (dtd != SDP_DATA_NIL) {
@@ -2590,17 +2614,9 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 	SDPDBG("Append src size: %d\n", len);
 	SDPDBG("Append dst size: %d\n", dst->data_size);
 	SDPDBG("Dst buffer size: %d\n", dst->buf_size);
-	if (dst->data_size + len > dst->buf_size) {
-		int need = SDP_PDU_CHUNK_SIZE * ((len / SDP_PDU_CHUNK_SIZE) + 1);
-		dst->data = realloc(dst->data, dst->buf_size + need);
-
-		SDPDBG("Realloc'ing : %d\n", need);
+	if (sdp_buf_allocate(dst, len) == -1)
+		return;
 
-		if (dst->data == NULL) {
-			SDPERR("Realloc fails \n");
-		}
-		dst->buf_size += need;
-	}
 	if (dst->data_size == 0 && dtd == 0) {
 		/* create initial sequence */
 		*(uint8_t *)p = SDP_SEQ8;
@@ -2642,17 +2658,17 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 
 void sdp_append_to_pdu(sdp_buf_t *pdu, sdp_data_t *d)
 {
-	uint8_t buf[512];
 	sdp_buf_t append;
 
 	memset(&append, 0, sizeof(sdp_buf_t));
-	append.data = buf;
-	append.buf_size = sizeof(buf);
+	append.data = NULL;
+	append.buf_size = 0;
 	append.data_size = 0;
 
 	sdp_set_attrid(&append, d->attrId);
-	sdp_gen_pdu(&append, d);
-	sdp_append_to_buf(pdu, append.data, append.data_size);
+	if (sdp_gen_pdu(&append, d) != -1)
+		sdp_append_to_buf(pdu, append.data, append.data_size);
+	free(append.data);
 }
 
 /*

--=-8e6cIu1ZT22ddmQvAy+6--

