Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v2 03/15] sdp: Use helper functions instead of bt_get_unaligned macro
Date: Fri, 31 Aug 2012 14:39:59 +0200
Message-ID: <1346416811-23484-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
References: <1346416811-23484-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix number of compilation errors on ARM similar to one below.

lib/sdp.c: In function 'sdp_uuid_extract':
lib/sdp.c:1019:27: error: cast increases required alignment
	of target type [-Werror=cast-align]
lib/sdp.c:1019:27: error: cast increases required alignment
	of target type [-Werror=cast-align]
lib/sdp.c:1026:27: error: cast increases required alignment
	of target type [-Werror=cast-align]
lib/sdp.c:1026:27: error: cast increases required alignment
	of target type [-Werror=cast-align]

---
 lib/sdp.c |   56 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 36b4d08..58396e5 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -376,27 +376,27 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 		d->unitSize += sizeof(int8_t);
 		break;
 	case SDP_UINT16:
-		d->val.uint16 = bt_get_unaligned((uint16_t *) value);
+		d->val.uint16 = bt_get_16(value);
 		d->unitSize += sizeof(uint16_t);
 		break;
 	case SDP_INT16:
-		d->val.int16 = bt_get_unaligned((int16_t *) value);
+		d->val.int16 = bt_get_16(value);
 		d->unitSize += sizeof(int16_t);
 		break;
 	case SDP_UINT32:
-		d->val.uint32 = bt_get_unaligned((uint32_t *) value);
+		d->val.uint32 = bt_get_32(value);
 		d->unitSize += sizeof(uint32_t);
 		break;
 	case SDP_INT32:
-		d->val.int32 = bt_get_unaligned((int32_t *) value);
+		d->val.int32 = bt_get_32(value);
 		d->unitSize += sizeof(int32_t);
 		break;
 	case SDP_INT64:
-		d->val.int64 = bt_get_unaligned((int64_t *) value);
+		d->val.int64 = bt_get_64(value);
 		d->unitSize += sizeof(int64_t);
 		break;
 	case SDP_UINT64:
-		d->val.uint64 = bt_get_unaligned((uint64_t *) value);
+		d->val.uint64 = bt_get_64(value);
 		d->unitSize += sizeof(uint64_t);
 		break;
 	case SDP_UINT128:
@@ -408,11 +408,11 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 		d->unitSize += sizeof(uint128_t);
 		break;
 	case SDP_UUID16:
-		sdp_uuid16_create(&d->val.uuid, bt_get_unaligned((uint16_t *) value));
+		sdp_uuid16_create(&d->val.uuid, bt_get_16(value));
 		d->unitSize += sizeof(uint16_t);
 		break;
 	case SDP_UUID32:
-		sdp_uuid32_create(&d->val.uuid, bt_get_unaligned((uint32_t *) value));
+		sdp_uuid32_create(&d->val.uuid, bt_get_32(value));
 		d->unitSize += sizeof(uint32_t);
 		break;
 	case SDP_UUID128:
@@ -1016,14 +1016,14 @@ int sdp_uuid_extract(const uint8_t *p, int bufsize, uuid_t *uuid, int *scanned)
 			SDPERR("Not enough room for 16-bit UUID");
 			return -1;
 		}
-		sdp_uuid16_create(uuid, ntohs(bt_get_unaligned((uint16_t *) p)));
+		sdp_uuid16_create(uuid, bt_get_be16(p));
 		*scanned += sizeof(uint16_t);
 	} else if (type == SDP_UUID32) {
 		if (bufsize < (int) sizeof(uint32_t)) {
 			SDPERR("Not enough room for 32-bit UUID");
 			return -1;
 		}
-		sdp_uuid32_create(uuid, ntohl(bt_get_unaligned((uint32_t *) p)));
+		sdp_uuid32_create(uuid, bt_get_be32(p));
 		*scanned += sizeof(uint32_t);
 	} else {
 		if (bufsize < (int) sizeof(uint128_t)) {
@@ -1078,7 +1078,7 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 			return NULL;
 		}
 		*len += sizeof(uint16_t);
-		d->val.uint16 = ntohs(bt_get_unaligned((uint16_t *) p));
+		d->val.uint16 = bt_get_be16(p);
 		break;
 	case SDP_INT32:
 	case SDP_UINT32:
@@ -1088,7 +1088,7 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 			return NULL;
 		}
 		*len += sizeof(uint32_t);
-		d->val.uint32 = ntohl(bt_get_unaligned((uint32_t *) p));
+		d->val.uint32 = bt_get_be32(p);
 		break;
 	case SDP_INT64:
 	case SDP_UINT64:
@@ -1098,7 +1098,7 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 			return NULL;
 		}
 		*len += sizeof(uint64_t);
-		d->val.uint64 = ntoh64(bt_get_unaligned((uint64_t *) p));
+		d->val.uint64 = bt_get_be64(p);
 		break;
 	case SDP_INT128:
 	case SDP_UINT128:
@@ -1181,7 +1181,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 			free(d);
 			return NULL;
 		}
-		n = ntohs(bt_get_unaligned((uint16_t *) p));
+		n = bt_get_be16(p);
 		p += sizeof(uint16_t);
 		*len += sizeof(uint16_t) + n;
 		bufsize -= sizeof(uint16_t);
@@ -1251,7 +1251,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size = ntohs(bt_get_unaligned((uint16_t *) buf));
+		*size = bt_get_be16(buf);
 		scanned += sizeof(uint16_t);
 		break;
 	case SDP_SEQ32:
@@ -1260,7 +1260,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size = ntohl(bt_get_unaligned((uint32_t *) buf));
+		*size = bt_get_be32(buf);
 		scanned += sizeof(uint32_t);
 		break;
 	default:
@@ -1427,7 +1427,7 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
 		}
 
 		dtd = *(uint8_t *) p;
-		attr = ntohs(bt_get_unaligned((uint16_t *) (p + n)));
+		attr = bt_get_be16(p + n);
 		n += sizeof(uint16_t);
 
 		SDPDBG("DTD of attrId : %d Attr id : 0x%x \n", dtd, attr);
@@ -2891,7 +2891,7 @@ int sdp_device_record_register_binary(sdp_session_t *session, bdaddr_t *device,
 			goto end;
 		}
 		if (handle)
-			*handle  = ntohl(bt_get_unaligned((uint32_t *) p));
+			*handle  = bt_get_be32(p);
 	}
 
 end:
@@ -2991,7 +2991,7 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
+	status = bt_get_16(p);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* For this case the status always is invalid record handle */
@@ -3096,7 +3096,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
+	status = bt_get_16(p);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* The status can be invalid sintax or invalid record handle */
@@ -3183,7 +3183,7 @@ static void extract_record_handle_seq(uint8_t *pdu, int bufsize, sdp_list_t **se
 		pSvcRec = malloc(sizeof(uint32_t));
 		if (!pSvcRec)
 			break;
-		*pSvcRec = ntohl(bt_get_unaligned((uint32_t *) pdata));
+		*pSvcRec = bt_get_be32(pdata);
 		pSeq = sdp_list_append(pSeq, pSvcRec);
 		pdata += sizeof(uint32_t);
 		*scanned += sizeof(uint32_t);
@@ -3407,7 +3407,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 		pdata += sizeof(uint16_t);
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
-		rec_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rec_count = bt_get_be16(pdata);
 		pdata += sizeof(uint16_t);
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
@@ -3573,7 +3573,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 			goto end;
 		}
 
-		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rsp_count = bt_get_be16(pdata);
 		attr_list_len += rsp_count;
 		pdata += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
@@ -4124,9 +4124,9 @@ int sdp_process(sdp_session_t *session)
 		 * CSRC: Current Service Record Count (2 bytes)
 		 */
 		ssr_pdata = pdata;
-		tsrc = ntohs(bt_get_unaligned((uint16_t *) ssr_pdata));
+		tsrc = bt_get_be16(ssr_pdata);
 		ssr_pdata += sizeof(uint16_t);
-		csrc = ntohs(bt_get_unaligned((uint16_t *) ssr_pdata));
+		csrc = bt_get_be16(ssr_pdata);
 
 		/* csrc should never be larger than tsrc */
 		if (csrc > tsrc) {
@@ -4162,7 +4162,7 @@ int sdp_process(sdp_session_t *session)
 		break;
 	case SDP_SVC_ATTR_RSP:
 	case SDP_SVC_SEARCH_ATTR_RSP:
-		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rsp_count = bt_get_be16(pdata);
 		SDPDBG("Attrlist byte count : %d\n", rsp_count);
 
 		/*
@@ -4175,7 +4175,7 @@ int sdp_process(sdp_session_t *session)
 		status = 0x0000;
 		break;
 	case SDP_ERROR_RSP:
-		status = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		status = bt_get_be16(pdata);
 		size = ntohs(rsphdr->plen);
 
 		goto end;
@@ -4395,7 +4395,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 			goto end;
 		}
 
-		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rsp_count = bt_get_be16(pdata);
 		attr_list_len += rsp_count;
 		pdata += sizeof(uint16_t); /* pdata points to attribute list */
 		pdata_len -= sizeof(uint16_t);
-- 
1.7.9.5

