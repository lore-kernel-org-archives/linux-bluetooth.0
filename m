Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH] lib: Cleanup SDP logs to not include double new lines
Date: Fri, 21 Jun 2013 22:48:20 +0200
Message-Id: <1371847700-21192-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SDPERR and SDPDBG already add new line to prints.
---
 lib/sdp.c | 183 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 90 insertions(+), 93 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 7f8f92b..800b37a 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -320,13 +320,13 @@ int sdp_uuid2strn(const uuid_t *uuid, char *str, size_t n)
 void sdp_uuid_print(const uuid_t *uuid)
 {
 	if (uuid == NULL) {
-		SDPERR("Null passed to print UUID\n");
+		SDPERR("Null passed to print UUID");
 		return;
 	}
 	if (uuid->type == SDP_UUID16) {
-		SDPDBG("  uint16_t : 0x%.4x\n", uuid->value.uuid16);
+		SDPDBG("  uint16_t : 0x%.4x", uuid->value.uuid16);
 	} else if (uuid->type == SDP_UUID32) {
-		SDPDBG("  uint32_t : 0x%.8x\n", uuid->value.uuid32);
+		SDPDBG("  uint32_t : 0x%.8x", uuid->value.uuid32);
 	} else if (uuid->type == SDP_UUID128) {
 		unsigned int data0;
 		unsigned short data1;
@@ -342,14 +342,11 @@ void sdp_uuid_print(const uuid_t *uuid)
 		memcpy(&data4, &uuid->value.uuid128.data[10], 4);
 		memcpy(&data5, &uuid->value.uuid128.data[14], 2);
 
-		SDPDBG("  uint128_t : 0x%.8x-", ntohl(data0));
-		SDPDBG("%.4x-", ntohs(data1));
-		SDPDBG("%.4x-", ntohs(data2));
-		SDPDBG("%.4x-", ntohs(data3));
-		SDPDBG("%.8x", ntohl(data4));
-		SDPDBG("%.4x\n", ntohs(data5));
+		SDPDBG("  uint128_t : 0x%.8x-%.4x-%.4x-%.4x-%.8x%.4x",
+				ntohl(data0), ntohs(data1), ntohs(data2),
+				ntohs(data3), ntohl(data4), ntohs(data5));
 	} else
-		SDPERR("Enum type of UUID not set\n");
+		SDPERR("Enum type of UUID not set");
 }
 #endif
 
@@ -441,14 +438,14 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 
 			memcpy(d->val.str, value, length);
 		} else {
-			SDPERR("Strings of size > USHRT_MAX not supported\n");
+			SDPERR("Strings of size > USHRT_MAX not supported");
 			free(d);
 			d = NULL;
 		}
 		break;
 	case SDP_URL_STR32:
 	case SDP_TEXT_STR32:
-		SDPERR("Strings of size > USHRT_MAX not supported\n");
+		SDPERR("Strings of size > USHRT_MAX not supported");
 		break;
 	case SDP_ALT8:
 	case SDP_ALT16:
@@ -894,7 +891,7 @@ recalculate:
 			memcpy(buf->data + buf->data_size, src, data_size);
 			buf->data_size += data_size;
 		} else if (d->dtd != SDP_DATA_NIL) {
-			SDPDBG("Gen PDU : Can't copy from invalid source or dest\n");
+			SDPDBG("Gen PDU : Can't copy from invalid source or dest");
 		}
 	}
 
@@ -998,7 +995,7 @@ int sdp_uuid_extract(const uint8_t *p, int bufsize, uuid_t *uuid, int *scanned)
 	type = *(const uint8_t *) p;
 
 	if (!SDP_IS_UUID(type)) {
-		SDPERR("Unknown data type : %d expecting a svc UUID\n", type);
+		SDPERR("Unknown data type : %d expecting a svc UUID", type);
 		return -1;
 	}
 	p += sizeof(uint8_t);
@@ -1042,7 +1039,7 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 	if (!d)
 		return NULL;
 
-	SDPDBG("Extracting integer\n");
+	SDPDBG("Extracting integer");
 	memset(d, 0, sizeof(sdp_data_t));
 	d->dtd = *(uint8_t *) p;
 	p += sizeof(uint8_t);
@@ -1180,7 +1177,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 		bufsize -= sizeof(uint16_t);
 		break;
 	default:
-		SDPERR("Sizeof text string > UINT16_MAX\n");
+		SDPERR("Sizeof text string > UINT16_MAX");
 		free(d);
 		return NULL;
 	}
@@ -1202,8 +1199,8 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 
 	*len += n;
 
-	SDPDBG("Len : %d\n", n);
-	SDPDBG("Str : %s\n", s);
+	SDPDBG("Len : %d", n);
+	SDPDBG("Str : %s", s);
 
 	d->val.str = s;
 	d->unitSize = n + sizeof(uint8_t);
@@ -1257,7 +1254,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 		scanned += sizeof(uint32_t);
 		break;
 	default:
-		SDPERR("Unknown sequence type, aborting\n");
+		SDPERR("Unknown sequence type, aborting");
 		return 0;
 	}
 	return scanned;
@@ -1276,7 +1273,7 @@ static sdp_data_t *extract_seq(const void *p, int bufsize, int *len,
 	SDPDBG("Extracting SEQ");
 	memset(d, 0, sizeof(sdp_data_t));
 	*len = sdp_extract_seqtype(p, bufsize, &d->dtd, &seqlen);
-	SDPDBG("Sequence Type : 0x%x length : 0x%x\n", d->dtd, seqlen);
+	SDPDBG("Sequence Type : 0x%x length : 0x%x", d->dtd, seqlen);
 
 	if (*len == 0)
 		return d;
@@ -1364,7 +1361,7 @@ sdp_data_t *sdp_extract_attr(const uint8_t *p, int bufsize, int *size,
 		elem = extract_seq(p, bufsize, &n, rec);
 		break;
 	default:
-		SDPERR("Unknown data descriptor : 0x%x terminating\n", dtd);
+		SDPERR("Unknown data descriptor : 0x%x terminating", dtd);
 		return NULL;
 	}
 	*size += n;
@@ -1376,21 +1373,21 @@ static void attr_print_func(void *value, void *userData)
 {
 	sdp_data_t *d = (sdp_data_t *)value;
 
-	SDPDBG("=====================================\n");
-	SDPDBG("ATTRIBUTE IDENTIFIER : 0x%x\n",  d->attrId);
-	SDPDBG("ATTRIBUTE VALUE PTR : %p\n", value);
+	SDPDBG("=====================================");
+	SDPDBG("ATTRIBUTE IDENTIFIER : 0x%x",  d->attrId);
+	SDPDBG("ATTRIBUTE VALUE PTR : %p", value);
 	if (d)
 		sdp_data_print(d);
 	else
-		SDPDBG("NULL value\n");
-	SDPDBG("=====================================\n");
+		SDPDBG("NULL value");
+	SDPDBG("=====================================");
 }
 
 void sdp_print_service_attr(sdp_list_t *svcAttrList)
 {
-	SDPDBG("Printing service attr list %p\n", svcAttrList);
+	SDPDBG("Printing service attr list %p", svcAttrList);
 	sdp_list_foreach(svcAttrList, attr_print_func, NULL);
-	SDPDBG("Printed service attr list %p\n", svcAttrList);
+	SDPDBG("Printed service attr list %p", svcAttrList);
 }
 #endif
 
@@ -1423,11 +1420,11 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
 		attr = bt_get_be16(p + n);
 		n += sizeof(uint16_t);
 
-		SDPDBG("DTD of attrId : %d Attr id : 0x%x \n", dtd, attr);
+		SDPDBG("DTD of attrId : %d Attr id : 0x%x ", dtd, attr);
 
 		data = sdp_extract_attr(p + n, bufsize - n, &attrlen, rec);
 
-		SDPDBG("Attr id : 0x%x attrValueLength : %d\n", attr, attrlen);
+		SDPDBG("Attr id : 0x%x attrValueLength : %d", attr, attrlen);
 
 		n += attrlen;
 		if (data == NULL) {
@@ -1450,7 +1447,7 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
 							seqlen, extracted);
 	}
 #ifdef SDP_DEBUG
-	SDPDBG("Successful extracting of Svc Rec attributes\n");
+	SDPDBG("Successful extracting of Svc Rec attributes");
 	sdp_print_service_attr(rec->attrlist);
 #endif
 	*scanned += seqlen;
@@ -1604,13 +1601,13 @@ void sdp_record_print(const sdp_record_t *rec)
 {
 	sdp_data_t *d = sdp_data_get(rec, SDP_ATTR_SVCNAME_PRIMARY);
 	if (d && SDP_IS_TEXT_STR(d->dtd))
-		printf("Service Name: %.*s\n", d->unitSize, d->val.str);
+		printf("Service Name: %.*s", d->unitSize, d->val.str);
 	d = sdp_data_get(rec, SDP_ATTR_SVCDESC_PRIMARY);
 	if (d && SDP_IS_TEXT_STR(d->dtd))
-		printf("Service Description: %.*s\n", d->unitSize, d->val.str);
+		printf("Service Description: %.*s", d->unitSize, d->val.str);
 	d = sdp_data_get(rec, SDP_ATTR_PROVNAME_PRIMARY);
 	if (d && SDP_IS_TEXT_STR(d->dtd))
-		printf("Service Provider: %.*s\n", d->unitSize, d->val.str);
+		printf("Service Provider: %.*s", d->unitSize, d->val.str);
 }
 
 #ifdef SDP_DEBUG
@@ -1618,7 +1615,7 @@ void sdp_data_print(sdp_data_t *d)
 {
 	switch (d->dtd) {
 	case SDP_DATA_NIL:
-		SDPDBG("NIL\n");
+		SDPDBG("NIL");
 		break;
 	case SDP_BOOL:
 	case SDP_UINT8:
@@ -1631,23 +1628,23 @@ void sdp_data_print(sdp_data_t *d)
 	case SDP_INT32:
 	case SDP_INT64:
 	case SDP_INT128:
-		SDPDBG("Integer : 0x%x\n", d->val.uint32);
+		SDPDBG("Integer : 0x%x", d->val.uint32);
 		break;
 	case SDP_UUID16:
 	case SDP_UUID32:
 	case SDP_UUID128:
-		SDPDBG("UUID\n");
+		SDPDBG("UUID");
 		sdp_uuid_print(&d->val.uuid);
 		break;
 	case SDP_TEXT_STR8:
 	case SDP_TEXT_STR16:
 	case SDP_TEXT_STR32:
-		SDPDBG("Text : %s\n", d->val.str);
+		SDPDBG("Text : %s", d->val.str);
 		break;
 	case SDP_URL_STR8:
 	case SDP_URL_STR16:
 	case SDP_URL_STR32:
-		SDPDBG("URL : %s\n", d->val.str);
+		SDPDBG("URL : %s", d->val.str);
 		break;
 	case SDP_SEQ8:
 	case SDP_SEQ16:
@@ -1657,7 +1654,7 @@ void sdp_data_print(sdp_data_t *d)
 	case SDP_ALT8:
 	case SDP_ALT16:
 	case SDP_ALT32:
-		SDPDBG("Data Sequence Alternates\n");
+		SDPDBG("Data Sequence Alternates");
 		print_dataseq(d->val.dataseq);
 		break;
 	}
@@ -1698,9 +1695,9 @@ static int sdp_read_rsp(sdp_session_t *session, uint8_t *buf, uint32_t size)
 
 	FD_ZERO(&readFds);
 	FD_SET(session->sock, &readFds);
-	SDPDBG("Waiting for response\n");
+	SDPDBG("Waiting for response");
 	if (select(session->sock + 1, &readFds, NULL, NULL, &timeout) == 0) {
-		SDPERR("Client timed out\n");
+		SDPERR("Client timed out");
 		errno = ETIMEDOUT;
 		return -1;
 	}
@@ -1725,7 +1722,7 @@ int sdp_send_req_w4_rsp(sdp_session_t *session, uint8_t *reqbuf,
 	n = sdp_read_rsp(session, rspbuf, SDP_RSP_BUFFER_SIZE);
 	if (0 > n)
 		return -1;
-	SDPDBG("Read : %d\n", n);
+	SDPDBG("Read : %d", n);
 	if (n == 0 || reqhdr->tid != rsphdr->tid) {
 		errno = EPROTO;
 		return -1;
@@ -1872,7 +1869,7 @@ static int sdp_get_proto_descs(uint16_t attr_id, const sdp_record_t *rec,
 		return -1;
 	}
 
-	SDPDBG("Attribute value type: 0x%02x\n", pdlist->dtd);
+	SDPDBG("Attribute value type: 0x%02x", pdlist->dtd);
 
 	if (attr_id == SDP_ATTR_ADD_PROTO_DESC_LIST) {
 		if (!SDP_IS_SEQ(pdlist->dtd)) {
@@ -2053,9 +2050,9 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
 		lang->code_ISO639 = pCode->val.uint16;
 		lang->encoding = pEncoding->val.uint16;
 		lang->base_offset = pOffset->val.uint16;
-		SDPDBG("code_ISO639 :  0x%02x\n", lang->code_ISO639);
-		SDPDBG("encoding :     0x%02x\n", lang->encoding);
-		SDPDBG("base_offfset : 0x%02x\n", lang->base_offset);
+		SDPDBG("code_ISO639 :  0x%02x", lang->code_ISO639);
+		SDPDBG("encoding :     0x%02x", lang->encoding);
+		SDPDBG("base_offfset : 0x%02x", lang->base_offset);
 		*langSeq = sdp_list_append(*langSeq, lang);
 
 		curr_data = pOffset->next;
@@ -2130,7 +2127,7 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 			profDesc->version = version;
 #ifdef SDP_DEBUG
 			sdp_uuid_print(&profDesc->uuid);
-			SDPDBG("Vnum : 0x%04x\n", profDesc->version);
+			SDPDBG("Vnum : 0x%04x", profDesc->version);
 #endif
 			*profDescSeq = sdp_list_append(*profDescSeq, profDesc);
 		}
@@ -2825,9 +2822,9 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 	uint8_t *p = dst->data;
 	uint8_t dtd = *p;
 
-	SDPDBG("Append src size: %d\n", len);
-	SDPDBG("Append dst size: %d\n", dst->data_size);
-	SDPDBG("Dst buffer size: %d\n", dst->buf_size);
+	SDPDBG("Append src size: %d", len);
+	SDPDBG("Append dst size: %d", dst->data_size);
+	SDPDBG("Dst buffer size: %d", dst->buf_size);
 	if (dst->data_size == 0 && dtd == 0) {
 		/* create initial sequence */
 		*p = SDP_SEQ8;
@@ -3160,7 +3157,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 		goto end;
 	}
 
-	SDPDBG("Send req status : %d\n", status);
+	SDPDBG("Send req status : %d", status);
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
@@ -3216,15 +3213,15 @@ void sdp_pattern_add_uuid(sdp_record_t *rec, uuid_t *uuid)
 {
 	uuid_t *uuid128 = sdp_uuid_to_uuid128(uuid);
 
-	SDPDBG("Elements in target pattern : %d\n", sdp_list_len(rec->pattern));
-	SDPDBG("Trying to add : 0x%lx\n", (unsigned long) uuid128);
+	SDPDBG("Elements in target pattern : %d", sdp_list_len(rec->pattern));
+	SDPDBG("Trying to add : 0x%lx", (unsigned long) uuid128);
 
 	if (sdp_list_find(rec->pattern, uuid128, sdp_uuid128_cmp) == NULL)
 		rec->pattern = sdp_list_insert_sorted(rec->pattern, uuid128, sdp_uuid128_cmp);
 	else
 		bt_free(uuid128);
 
-	SDPDBG("Elements in target pattern : %d\n", sdp_list_len(rec->pattern));
+	SDPDBG("Elements in target pattern : %d", sdp_list_len(rec->pattern));
 }
 
 void sdp_pattern_add_uuidseq(sdp_record_t *rec, sdp_list_t *seq)
@@ -3278,7 +3275,7 @@ static int gen_dataseq_pdu(uint8_t *dst, const sdp_list_t *seq, uint8_t dtd)
 	/* Fill up the value and the dtd arrays */
 	SDPDBG("");
 
-	SDPDBG("Seq length : %d\n", seqlen);
+	SDPDBG("Seq length : %d", seqlen);
 
 	types = malloc(seqlen * sizeof(void *));
 	if (!types)
@@ -3317,9 +3314,9 @@ static int gen_dataseq_pdu(uint8_t *dst, const sdp_list_t *seq, uint8_t dtd)
 		return -ENOMEM;
 	}
 
-	SDPDBG("Data Seq : 0x%p\n", seq);
+	SDPDBG("Data Seq : 0x%p", seq);
 	seqlen = sdp_gen_pdu(&buf, dataseq);
-	SDPDBG("Copying : %d\n", buf.data_size);
+	SDPDBG("Copying : %d", buf.data_size);
 	memcpy(dst, buf.data, buf.data_size);
 
 	sdp_data_free(dataseq);
@@ -3420,7 +3417,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	/* add service class IDs for search */
 	seqlen = gen_searchseq_pdu(pdata, search);
 
-	SDPDBG("Data seq added : %d\n", seqlen);
+	SDPDBG("Data seq added : %d", seqlen);
 
 	/* set the length and increment the pointer */
 	reqsize += seqlen;
@@ -3462,7 +3459,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 		rsplen = ntohs(rsphdr->plen);
 
 		if (rsphdr->pdu_id == SDP_ERROR_RSP) {
-			SDPDBG("Status : 0x%x\n", rsphdr->pdu_id);
+			SDPDBG("Status : 0x%x", rsphdr->pdu_id);
 			status = -1;
 			goto end;
 		}
@@ -3485,15 +3482,15 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
 
-		SDPDBG("Current svc count: %d\n", rec_count);
-		SDPDBG("ResponseLength: %d\n", rsplen);
+		SDPDBG("Current svc count: %d", rec_count);
+		SDPDBG("ResponseLength: %d", rsplen);
 
 		if (!rec_count) {
 			status = -1;
 			goto end;
 		}
 		extract_record_handle_seq(pdata, pdata_len, rsp, rec_count, &scanned);
-		SDPDBG("BytesScanned : %d\n", scanned);
+		SDPDBG("BytesScanned : %d", scanned);
 
 		if (rsplen > scanned) {
 			uint8_t cstate_len;
@@ -3508,7 +3505,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 			cstate_len = *(uint8_t *) pdata;
 			if (cstate_len > 0) {
 				cstate = (sdp_cstate_t *)pdata;
-				SDPDBG("Cont state length: %d\n", cstate_len);
+				SDPDBG("Cont state length: %d", cstate_len);
 			} else
 				cstate = NULL;
 		}
@@ -3607,7 +3604,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	}
 	pdata += seqlen;
 	reqsize += seqlen;
-	SDPDBG("Attr list length : %d\n", seqlen);
+	SDPDBG("Attr list length : %d", seqlen);
 
 	/* save before Continuation State */
 	_pdata = pdata;
@@ -3635,7 +3632,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 
 		rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 		if (rsphdr->pdu_id == SDP_ERROR_RSP) {
-			SDPDBG("PDU ID : 0x%x\n", rsphdr->pdu_id);
+			SDPDBG("PDU ID : 0x%x", rsphdr->pdu_id);
 			goto end;
 		}
 		pdata = rspbuf + sizeof(sdp_pdu_hdr_t);
@@ -3661,9 +3658,9 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 		}
 		cstate_len = *(uint8_t *) (pdata + rsp_count);
 
-		SDPDBG("Response id : %d\n", rsphdr->pdu_id);
-		SDPDBG("Attrlist byte count : %d\n", rsp_count);
-		SDPDBG("sdp_cstate_t length : %d\n", cstate_len);
+		SDPDBG("Response id : %d", rsphdr->pdu_id);
+		SDPDBG("Attrlist byte count : %d", rsp_count);
+		SDPDBG("sdp_cstate_t length : %d", cstate_len);
 
 		/*
 		 * a split response: concatenate intermediate responses
@@ -3842,7 +3839,7 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	/* add service class IDs for search */
 	seqlen = gen_searchseq_pdu(pdata, search);
 
-	SDPDBG("Data seq added : %d\n", seqlen);
+	SDPDBG("Data seq added : %d", seqlen);
 
 	/* now set the length and increment the pointer */
 	t->reqsize += seqlen;
@@ -3961,7 +3958,7 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	/* now set the length and increment the pointer */
 	t->reqsize += seqlen;
 	pdata += seqlen;
-	SDPDBG("Attr list length : %d\n", seqlen);
+	SDPDBG("Attr list length : %d", seqlen);
 
 	/* set the request header's param length */
 	cstate_len = copy_cstate(pdata, SDP_REQ_BUFFER_SIZE - t->reqsize, NULL);
@@ -4055,7 +4052,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	/* add service class IDs for search */
 	seqlen = gen_searchseq_pdu(pdata, search);
 
-	SDPDBG("Data seq added : %d\n", seqlen);
+	SDPDBG("Data seq added : %d", seqlen);
 
 	/* now set the length and increment the pointer */
 	t->reqsize += seqlen;
@@ -4065,7 +4062,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
-	SDPDBG("Max attr byte count : %d\n", SDP_MAX_ATTR_LEN);
+	SDPDBG("Max attr byte count : %d", SDP_MAX_ATTR_LEN);
 
 	/* get attr seq PDU form */
 	seqlen = gen_attridseq_pdu(pdata, attrid_list,
@@ -4076,7 +4073,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	}
 
 	pdata += seqlen;
-	SDPDBG("Attr list length : %d\n", seqlen);
+	SDPDBG("Attr list length : %d", seqlen);
 	t->reqsize += seqlen;
 
 	/* set the request header's param length */
@@ -4207,8 +4204,8 @@ int sdp_process(sdp_session_t *session)
 			goto end;
 		}
 
-		SDPDBG("Total svc count: %d\n", tsrc);
-		SDPDBG("Current svc count: %d\n", csrc);
+		SDPDBG("Total svc count: %d", tsrc);
+		SDPDBG("Current svc count: %d", csrc);
 
 		/* parameter length without continuation state */
 		plen = sizeof(tsrc) + sizeof(csrc) + csrc * 4;
@@ -4244,7 +4241,7 @@ int sdp_process(sdp_session_t *session)
 	case SDP_SVC_ATTR_RSP:
 	case SDP_SVC_SEARCH_ATTR_RSP:
 		rsp_count = bt_get_be16(pdata);
-		SDPDBG("Attrlist byte count : %d\n", rsp_count);
+		SDPDBG("Attrlist byte count : %d", rsp_count);
 
 		/* Valid range for rsp_count is 0x0002-0xFFFF */
 		if (rsp_count < 0x0002) {
@@ -4287,7 +4284,7 @@ int sdp_process(sdp_session_t *session)
 
 	pcstate = (sdp_cstate_t *) (pdata + rsp_count);
 
-	SDPDBG("Cstate length : %d\n", pcstate->length);
+	SDPDBG("Cstate length : %d", pcstate->length);
 
 	/*
 	 * Check out of bound. Continuation state must have at least
@@ -4435,7 +4432,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 		goto end;
 	}
 
-	SDPDBG("Data seq added : %d\n", seqlen);
+	SDPDBG("Data seq added : %d", seqlen);
 
 	/* now set the length and increment the pointer */
 	reqsize += seqlen;
@@ -4445,7 +4442,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
-	SDPDBG("Max attr byte count : %d\n", SDP_MAX_ATTR_LEN);
+	SDPDBG("Max attr byte count : %d", SDP_MAX_ATTR_LEN);
 
 	/* get attr seq PDU form */
 	seqlen = gen_attridseq_pdu(pdata, attrids,
@@ -4456,7 +4453,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 		goto end;
 	}
 	pdata += seqlen;
-	SDPDBG("Attr list length : %d\n", seqlen);
+	SDPDBG("Attr list length : %d", seqlen);
 	reqsize += seqlen;
 	*rsp = 0;
 
@@ -4482,7 +4479,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 		}
 
 		if (status < 0) {
-			SDPDBG("Status : 0x%x\n", rsphdr->pdu_id);
+			SDPDBG("Status : 0x%x", rsphdr->pdu_id);
 			goto end;
 		}
 
@@ -4513,9 +4510,9 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 
 		cstate_len = *(uint8_t *) (pdata + rsp_count);
 
-		SDPDBG("Attrlist byte count : %d\n", attr_list_len);
-		SDPDBG("Response byte count : %d\n", rsp_count);
-		SDPDBG("Cstate length : %d\n", cstate_len);
+		SDPDBG("Attrlist byte count : %d", attr_list_len);
+		SDPDBG("Response byte count : %d", rsp_count);
+		SDPDBG("Cstate length : %d", cstate_len);
 		/*
 		 * This is a split response, need to concatenate intermediate
 		 * responses and the last one which will have cstate_len == 0
@@ -4549,8 +4546,8 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 		 */
 		scanned = sdp_extract_seqtype(pdata, pdata_len, &dataType, &seqlen);
 
-		SDPDBG("Bytes scanned : %d\n", scanned);
-		SDPDBG("Seq length : %d\n", seqlen);
+		SDPDBG("Bytes scanned : %d", scanned);
+		SDPDBG("Seq length : %d", seqlen);
 
 		if (scanned && seqlen) {
 			pdata += scanned;
@@ -4559,7 +4556,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 				int recsize = 0;
 				sdp_record_t *rec = sdp_extract_pdu(pdata, pdata_len, &recsize);
 				if (rec == NULL) {
-					SDPERR("SVC REC is null\n");
+					SDPERR("SVC REC is null");
 					status = -1;
 					goto end;
 				}
@@ -4571,14 +4568,14 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 				pdata += recsize;
 				pdata_len -= recsize;
 
-				SDPDBG("Loc seq length : %d\n", recsize);
-				SDPDBG("Svc Rec Handle : 0x%x\n", rec->handle);
-				SDPDBG("Bytes scanned : %d\n", scanned);
-				SDPDBG("Attrlist byte count : %d\n", attr_list_len);
+				SDPDBG("Loc seq length : %d", recsize);
+				SDPDBG("Svc Rec Handle : 0x%x", rec->handle);
+				SDPDBG("Bytes scanned : %d", scanned);
+				SDPDBG("Attrlist byte count : %d", attr_list_len);
 				rec_list = sdp_list_append(rec_list, rec);
 			} while (scanned < attr_list_len && pdata_len > 0);
 
-			SDPDBG("Successful scan of service attr lists\n");
+			SDPDBG("Successful scan of service attr lists");
 			*rsp = rec_list;
 		}
 	}
-- 
1.8.3.1

