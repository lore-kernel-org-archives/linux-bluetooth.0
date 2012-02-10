Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 07/22] sdp: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:39:52 -0300
Message-Id: <1328910007-25604-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In these places, the memory accesses were breaking strict-aliasing,
and clang is more sensitive for these.
---
 lib/sdp.c |   66 ++++++++++++++++++++++++++++++------------------------------
 1 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index a48ee14..11668bf 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -624,13 +624,13 @@ void sdp_set_seq_len(uint8_t *ptr, uint32_t length)
 	case SDP_ALT16:
 	case SDP_TEXT_STR16:
 	case SDP_URL_STR16:
-		bt_put_unaligned(htons(length), (uint16_t *) ptr);
+		bt_put_be16(length, ptr);
 		break;
 	case SDP_SEQ32:
 	case SDP_ALT32:
 	case SDP_TEXT_STR32:
 	case SDP_URL_STR32:
-		bt_put_unaligned(htonl(length), (uint32_t *) ptr);
+		bt_put_be32(length, ptr);
 		break;
 	}
 }
@@ -687,7 +687,7 @@ void sdp_set_attrid(sdp_buf_t *buf, uint16_t attr)
 	/* data type for attr */
 	*p++ = SDP_UINT16;
 	buf->data_size = sizeof(uint8_t);
-	bt_put_unaligned(htons(attr), (uint16_t *) p);
+	bt_put_be16(attr, p);
 	buf->data_size += sizeof(uint16_t);
 }
 
@@ -1018,14 +1018,14 @@ int sdp_uuid_extract(const uint8_t *p, int bufsize, uuid_t *uuid, int *scanned)
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
@@ -1253,7 +1253,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size = ntohs(bt_get_unaligned((uint16_t *) buf));
+		*size = bt_get_be16(buf);
 		scanned += sizeof(uint16_t);
 		break;
 	case SDP_SEQ32:
@@ -1262,7 +1262,7 @@ int sdp_extract_seqtype(const uint8_t *buf, int bufsize, uint8_t *dtdp, int *siz
 			SDPERR("Unexpected end of packet");
 			return 0;
 		}
-		*size = ntohl(bt_get_unaligned((uint32_t *) buf));
+		*size = bt_get_be32(buf);
 		scanned += sizeof(uint32_t);
 		break;
 	default:
@@ -1429,7 +1429,7 @@ sdp_record_t *sdp_extract_pdu(const uint8_t *buf, int bufsize, int *scanned)
 		}
 
 		dtd = *(uint8_t *) p;
-		attr = ntohs(bt_get_unaligned((uint16_t *) (p + n)));
+		attr = bt_get_be16(p + n);
 		n += sizeof(uint16_t);
 
 		SDPDBG("DTD of attrId : %d Attr id : 0x%x \n", dtd, attr);
@@ -2785,10 +2785,10 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
 		*(uint8_t *) p = dst->data_size - sizeof(uint8_t) - sizeof(uint8_t);
 		break;
 	case SDP_SEQ16:
-		bt_put_unaligned(htons(dst->data_size - sizeof(uint8_t) - sizeof(uint16_t)), (uint16_t *) p);
+		bt_put_be16(dst->data_size - sizeof(uint8_t) - sizeof(uint16_t), p);
 		break;
 	case SDP_SEQ32:
-		bt_put_unaligned(htonl(dst->data_size - sizeof(uint8_t) - sizeof(uint32_t)), (uint32_t *) p);
+		bt_put_be32(dst->data_size - sizeof(uint8_t) - sizeof(uint32_t), p);
 		break;
 	}
 }
@@ -2885,7 +2885,7 @@ int sdp_device_record_register_binary(sdp_session_t *session, bdaddr_t *device,
 			goto end;
 		}
 		if (handle)
-			*handle  = ntohl(bt_get_unaligned((uint32_t *) p));
+			*handle = bt_get_be32(p);
 	}
 
 end:
@@ -2968,7 +2968,7 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	p = reqbuf + sizeof(sdp_pdu_hdr_t);
 	reqsize = sizeof(sdp_pdu_hdr_t);
-	bt_put_unaligned(htonl(handle), (uint32_t *) p);
+	bt_put_be32(handle, p);
 	reqsize += sizeof(uint32_t);
 
 	reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
@@ -2985,7 +2985,7 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
+	status = bt_get_h16(p);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* For this case the status always is invalid record handle */
@@ -3061,7 +3061,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 	p = reqbuf + sizeof(sdp_pdu_hdr_t);
 	reqsize = sizeof(sdp_pdu_hdr_t);
 
-	bt_put_unaligned(htonl(handle), (uint32_t *) p);
+	bt_put_be32(handle, p);
 	reqsize += sizeof(uint32_t);
 	p += sizeof(uint32_t);
 
@@ -3090,7 +3090,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
+	status = bt_get_h16(p);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* The status can be invalid sintax or invalid record handle */
@@ -3177,7 +3177,7 @@ static void extract_record_handle_seq(uint8_t *pdu, int bufsize, sdp_list_t **se
 		pSvcRec = malloc(sizeof(uint32_t));
 		if (!pSvcRec)
 			break;
-		*pSvcRec = ntohl(bt_get_unaligned((uint32_t *) pdata));
+		*pSvcRec = bt_get_be32(pdata);
 		pSeq = sdp_list_append(pSeq, pSvcRec);
 		pdata += sizeof(uint32_t);
 		*scanned += sizeof(uint32_t);
@@ -3348,7 +3348,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	pdata += seqlen;
 
 	/* specify the maximum svc rec count that client expects */
-	bt_put_unaligned(htons(max_rec_num), (uint16_t *) pdata);
+	bt_put_be16(max_rec_num, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3401,7 +3401,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 		pdata += sizeof(uint16_t);
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
-		rec_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rec_count = bt_get_be16(pdata);
 		pdata += sizeof(uint16_t);
 		scanned += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
@@ -3511,12 +3511,12 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	reqsize = sizeof(sdp_pdu_hdr_t);
 
 	/* add the service record handle */
-	bt_put_unaligned(htonl(handle), (uint32_t *) pdata);
+	bt_put_be32(handle, pdata);
 	reqsize += sizeof(uint32_t);
 	pdata += sizeof(uint32_t);
 
 	/* specify the response limit */
-	bt_put_unaligned(htons(65535), (uint16_t *) pdata);
+	bt_put_be16(65535, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3568,7 +3568,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 			goto end;
 		}
 
-		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rsp_count = bt_get_be16(pdata);
 		attr_list_len += rsp_count;
 		pdata += sizeof(uint16_t);
 		pdata_len -= sizeof(uint16_t);
@@ -3770,7 +3770,7 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	t->reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_unaligned(htons(max_rec_num), (uint16_t *) pdata);
+	bt_put_be16(max_rec_num, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3863,12 +3863,12 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
 	t->reqsize = sizeof(sdp_pdu_hdr_t);
 
 	/* add the service record handle */
-	bt_put_unaligned(htonl(handle), (uint32_t *) pdata);
+	bt_put_be32(handle, pdata);
 	t->reqsize += sizeof(uint32_t);
 	pdata += sizeof(uint32_t);
 
 	/* specify the response limit */
-	bt_put_unaligned(htons(65535), (uint16_t *) pdata);
+	bt_put_be16(65535, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3983,7 +3983,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	t->reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_unaligned(htons(SDP_MAX_ATTR_LEN), (uint16_t *) pdata);
+	bt_put_be16(SDP_MAX_ATTR_LEN, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -4119,9 +4119,9 @@ int sdp_process(sdp_session_t *session)
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
@@ -4141,14 +4141,14 @@ int sdp_process(sdp_session_t *session)
 			rsp_count = sizeof(tsrc) + sizeof(csrc) + csrc * 4;
 		} else {
 			/* point to the first csrc */
-			uint16_t *pcsrc = (uint16_t *) (t->rsp_concat_buf.data + 2);
+			uint16_t pcsrc = bt_get_h16(t->rsp_concat_buf.data + 2);
 
 			/* FIXME: update the interface later. csrc doesn't need be passed to clients */
 
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned((uint16_t *) pdata);
+			pcsrc += bt_get_h16(pdata);
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
@@ -4157,7 +4157,7 @@ int sdp_process(sdp_session_t *session)
 		break;
 	case SDP_SVC_ATTR_RSP:
 	case SDP_SVC_SEARCH_ATTR_RSP:
-		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rsp_count = bt_get_be16(pdata);
 		SDPDBG("Attrlist byte count : %d\n", rsp_count);
 
 		/*
@@ -4170,7 +4170,7 @@ int sdp_process(sdp_session_t *session)
 		status = 0x0000;
 		break;
 	case SDP_ERROR_RSP:
-		status = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		status = bt_get_be16(pdata);
 		size = ntohs(rsphdr->plen);
 
 		goto end;
@@ -4331,7 +4331,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_unaligned(htons(SDP_MAX_ATTR_LEN), (uint16_t *) pdata);
+	bt_put_be16(SDP_MAX_ATTR_LEN, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -4389,7 +4389,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 			goto end;
 		}
 
-		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
+		rsp_count = bt_get_be16(pdata);
 		attr_list_len += rsp_count;
 		pdata += sizeof(uint16_t); /* pdata points to attribute list */
 		pdata_len -= sizeof(uint16_t);
-- 
1.7.8.1

