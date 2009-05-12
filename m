Return-Path: <cyrus@holtmann.org>
Subject: Re: Segmentation fault in bluetoothd
From: Unai Uribarri <unaiur@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1242141807.8227.3.camel@optenet-laptop-unai>
References: <1242141807.8227.3.camel@optenet-laptop-unai>
Content-Type: multipart/mixed; boundary="=-wGGzPKIAg4ske0AGtB9U"
Date: Tue, 12 May 2009 18:14:32 +0200
Message-Id: <1242144872.8227.8.camel@optenet-laptop-unai>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-wGGzPKIAg4ske0AGtB9U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The previous patch prevents bluetoothd from crashing, but my phone
doesn't work either.

Following jhl (irc nick) suggestions, instead of growing the buffer
dynamically, I modified sdp_gen_pdu to return -1 if the buffer isn't big
enough to contain the passed data, and all the invokers of this function
to check for errors.

This new patch allow to pair with my phone and retrieve all its services
(serial, DUN, obex...).


El mar, 12-05-2009 a las 17:23 +0200, Unai Uribarri escribió:
> I've being investigating this Ubuntu 9.04 bug
> https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/332119
> 
> I've verified that the bug is reproducible with bluez-4.32, bluez-4.34
> and git-tip (today at 15.00 UTC).
> 
> The root of the bug is that sdp_gen_pdu doesn't check if the given
> buffer is big enough to contain the requested data. It's being called
> from sdp_append_to_pdu, which uses a 512 byte array at the stack but,
> when pairing with my Nokia 6161, it's called with a d parameter that
> sums more that 17KB. So the stack is corrupted and the back-trace isn't
> very useful.
> 
> All the other callers of sdp_gen_pdu seems to use dynamic memory
> (malloc), so I've rewritten sdp_append_to_pdu to use dynamic memory
> and fixed sdp_gen_pdu to grow the given buffer when it gets full.

--=-wGGzPKIAg4ske0AGtB9U
Content-Disposition: attachment; filename="bluez-sdp-fix2.diff"
Content-Type: text/x-patch; name="bluez-sdp-fix2.diff"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff --git a/lib/sdp.c b/lib/sdp.c
index 2581a1d..10125cb 100644
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
+		if (res == -1)
+			return -1;
+		n += res;
+	}
 
 	return n;
 }
@@ -725,7 +731,8 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 	uint128_t u128;
 	uint8_t *seqp = buf->data + buf->data_size;
 
-	pdu_size = sdp_set_data_type(buf, dtd);
+	if ((pdu_size = sdp_set_data_type(buf, dtd)) == -1)
+		return -1;
 
 	switch (dtd) {
 	case SDP_DATA_NIL:
@@ -793,14 +800,16 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
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
@@ -827,6 +836,7 @@ int sdp_gen_pdu(sdp_buf_t *buf, sdp_data_t *d)
 			buf->data_size += data_size;
 		} else if (dtd != SDP_DATA_NIL) {
 			SDPDBG("Gen PDU : Can't copy from invalid source or dest\n");
+			return -1;
 		}
 	}
 
@@ -2651,8 +2661,8 @@ void sdp_append_to_pdu(sdp_buf_t *pdu, sdp_data_t *d)
 	append.data_size = 0;
 
 	sdp_set_attrid(&append, d->attrId);
-	sdp_gen_pdu(&append, d);
-	sdp_append_to_buf(pdu, append.data, append.data_size);
+	if (sdp_gen_pdu(&append, d) != -1)
+		sdp_append_to_buf(pdu, append.data, append.data_size);
 }
 
 /*
@@ -3173,6 +3183,11 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen == -1) {
+		errno = EINVAL;
+		status = -1;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 
@@ -3599,6 +3614,10 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen == -1) {
+		t->err = EINVAL;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 
@@ -3818,6 +3837,10 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen == -1) {
+		t->err = EINVAL;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 
@@ -4169,6 +4192,11 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 
 	// add service class IDs for search
 	seqlen = gen_searchseq_pdu(pdata, search);
+	if (seqlen == -1) {
+		errno = EINVAL;
+		status = -1;
+		goto end;
+	}
 
 	SDPDBG("Data seq added : %d\n", seqlen);
 

--=-wGGzPKIAg4ske0AGtB9U--

