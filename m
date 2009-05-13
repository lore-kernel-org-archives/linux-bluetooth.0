Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fixes buffer overflow when storing too large SDP pdus
From: Unai Uribarri <unaiur@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-tdn8bxem0hiyBDag2F7n"
Date: Wed, 13 May 2009 12:14:04 +0200
Message-Id: <1242209644.8227.25.camel@optenet-laptop-unai>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-tdn8bxem0hiyBDag2F7n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

sdp_gen_pdu doesn't check if the given buffer is big enough to contain
the requested data. When storing the SDP records returned by several
Nokia phones, the 512 byte array allocated in the stack by sdp_append_to_pdu 
gets overflown and causes a segmentation fault. 

With this patch, sdp_gen_pdu returns -1 if the buffer is too small and
all the invokers of sdp_gen_pdu will check for errors.

Fixes: https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/332119

PD: This fix is a bit cleaner that previous ones

--=-tdn8bxem0hiyBDag2F7n
Content-Disposition: attachment; filename="bluez-sdp-gen-pdu_overflow.diff"
Content-Type: text/x-patch; name="bluez-sdp-gen-pdu_overflow.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/lib/sdp.c b/lib/sdp.c
index 2581a1d..39d408a 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -661,34 +661,35 @@ void sdp_set_seq_len(uint8_t *ptr, uint32_t length)
 
 static int sdp_set_data_type(sdp_buf_t *buf, uint8_t dtd)
 {
-	int orig = buf->data_size;
-	uint8_t *p = buf->data + buf->data_size;
-
-	*p++ = dtd;
-	buf->data_size += sizeof(uint8_t);
+	size_t size = 1;
 
 	switch (dtd) {
 	case SDP_SEQ8:
 	case SDP_TEXT_STR8:
 	case SDP_URL_STR8:
 	case SDP_ALT8:
-		buf->data_size += sizeof(uint8_t);
+		size += sizeof(uint8_t);
 		break;
 	case SDP_SEQ16:
 	case SDP_TEXT_STR16:
 	case SDP_URL_STR16:
 	case SDP_ALT16:
-		buf->data_size += sizeof(uint16_t);
+		size += sizeof(uint16_t);
 		break;
 	case SDP_SEQ32:
 	case SDP_TEXT_STR32:
 	case SDP_URL_STR32:
 	case SDP_ALT32:
-		buf->data_size += sizeof(uint32_t);
+		size += sizeof(uint32_t);
 		break;
 	}
 
-	return buf->data_size - orig;
+	if (buf->data_size + size > buf->buf_size)
+		return -1;
+
+	buf->data[buf->data_size] = dtd;
+	buf->data_size += size;
+	return size;
 }
 
 void sdp_set_attrid(sdp_buf_t *buf, uint16_t attr)
@@ -709,7 +710,12 @@ static int get_data_size(sdp_buf_t *buf, sdp_data_t *sdpdata)
 	int n = 0;
 
 	for (d = sdpdata->val.dataseq; d; d = d->next)
-		n += sdp_gen_pdu(buf, d);
+	{
+		int res = sdp_gen_pdu(buf, d);
+		if (res < 0)
+			return -1;
+		n += res;
+	}
 
 	return n;
 }
@@ -726,6 +732,8 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	uint8_t *seqp = buf->data + buf->data_size;
 
 	pdu_size = sdp_set_data_type(buf, dtd);
+	if (pdu_size < 0)
+		return -1;
 
 	switch (dtd) {
 	case SDP_DATA_NIL:
@@ -794,6 +802,8 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	case SDP_SEQ32:
 		is_seq = 1;
 		data_size = get_data_size(buf, d);
+		if (data_size < 0)
+			return -1;
 		sdp_set_seq_len(seqp, data_size);
 		break;
 	case SDP_ALT8:
@@ -801,6 +811,8 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	case SDP_ALT32:
 		is_alt = 1;
 		data_size = get_data_size(buf, d);
+		if (data_size < 0)
+			return -1;
 		sdp_set_seq_len(seqp, data_size);
 		break;
 	case SDP_UUID16:
@@ -827,6 +839,7 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 			buf->data_size += data_size;
 		} else if (dtd != SDP_DATA_NIL) {
 			SDPDBG("Gen PDU : Can't copy from invalid source or dest\n");
+			return -1;
 		}
 	}
 
@@ -2651,8 +2664,8 @@ void sdp_append_to_pdu(sdp_buf_t *pdu, sdp_data_t *d)
 	append.data_size = 0;
 
 	sdp_set_attrid(&append, d->attrId);
-	sdp_gen_pdu(&append, d);
-	sdp_append_to_buf(pdu, append.data, append.data_size);
+	if (sdp_gen_pdu(&append, d) >= 0)
+		sdp_append_to_buf(pdu, append.data, append.data_size);
 }
 
 /*
@@ -3173,6 +3186,11 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen < 0) {
+		errno = EINVAL;
+		status = -1;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 
@@ -3599,6 +3617,10 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen < 0) {
+		t->err = EINVAL;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 
@@ -3818,6 +3840,10 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen < 0) {
+		t->err = EINVAL;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 
@@ -4169,6 +4195,11 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen < 0) {
+		errno = EINVAL;
+		status = -1;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 

--=-tdn8bxem0hiyBDag2F7n--

