Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 05/15] sdp: Fix compilation errors due to unaligned memory access
Date: Fri, 31 Aug 2012 10:36:15 +0200
Message-ID: <1346402185-9487-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix number of build errors on ARM similar to one below.

lib/sdp.c: In function 'sdp_set_seq_len':
lib/sdp.c:625:3: error: cast increases required alignment of target
	 type [-Werror=cast-align]
lib/sdp.c:625:3: error: cast increases required alignment of target
	type [-Werror=cast-align]
lib/sdp.c:631:3: error: cast increases required alignment of target
	type [-Werror=cast-align]
lib/sdp.c:631:3: error: cast increases required alignment of target
	type [-Werror=cast-align]

Change-Id: Ic539c930f05f905d78fdbc2a77c1f0ff59a04bae
---
 lib/sdp.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index d40500f..59a958f 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -622,13 +622,13 @@ void sdp_set_seq_len(uint8_t *ptr, uint32_t length)
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
@@ -685,7 +685,7 @@ void sdp_set_attrid(sdp_buf_t *buf, uint16_t attr)
 	/* data type for attr */
 	*p++ = SDP_UINT16;
 	buf->data_size = sizeof(uint8_t);
-	bt_put_unaligned(htons(attr), (uint16_t *) p);
+	bt_put_be16(attr, p);
 	buf->data_size += sizeof(uint16_t);
 }
 
@@ -2791,10 +2791,10 @@ void sdp_append_to_buf(sdp_buf_t *dst, uint8_t *data, uint32_t len)
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
@@ -2974,7 +2974,7 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	p = reqbuf + sizeof(sdp_pdu_hdr_t);
 	reqsize = sizeof(sdp_pdu_hdr_t);
-	bt_put_unaligned(htonl(handle), (uint32_t *) p);
+	bt_put_be32(handle, p);
 	reqsize += sizeof(uint32_t);
 
 	reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
@@ -3067,7 +3067,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 	p = reqbuf + sizeof(sdp_pdu_hdr_t);
 	reqsize = sizeof(sdp_pdu_hdr_t);
 
-	bt_put_unaligned(htonl(handle), (uint32_t *) p);
+	bt_put_be32(handle, p);
 	reqsize += sizeof(uint32_t);
 	p += sizeof(uint32_t);
 
@@ -3354,7 +3354,7 @@ int sdp_service_search_req(sdp_session_t *session, const sdp_list_t *search,
 	pdata += seqlen;
 
 	/* specify the maximum svc rec count that client expects */
-	bt_put_unaligned(htons(max_rec_num), (uint16_t *) pdata);
+	bt_put_be16(max_rec_num, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3516,12 +3516,12 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
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
 
@@ -3775,7 +3775,7 @@ int sdp_service_search_async(sdp_session_t *session, const sdp_list_t *search, u
 	t->reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_unaligned(htons(max_rec_num), (uint16_t *) pdata);
+	bt_put_be16(max_rec_num, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -3868,12 +3868,12 @@ int sdp_service_attr_async(sdp_session_t *session, uint32_t handle, sdp_attrreq_
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
 
@@ -3988,7 +3988,7 @@ int sdp_service_search_attr_async(sdp_session_t *session, const sdp_list_t *sear
 	t->reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_unaligned(htons(SDP_MAX_ATTR_LEN), (uint16_t *) pdata);
+	bt_put_be16(SDP_MAX_ATTR_LEN, pdata);
 	t->reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
@@ -4146,14 +4146,18 @@ int sdp_process(sdp_session_t *session)
 			rsp_count = sizeof(tsrc) + sizeof(csrc) + csrc * 4;
 		} else {
 			/* point to the first csrc */
-			uint16_t *pcsrc = (uint16_t *) (t->rsp_concat_buf.data + 2);
+			uint8_t *pcsrc = t->rsp_concat_buf.data + 2;
+			uint16_t tcsrc;
+
+			tcsrc = bt_get_16(pcsrc);
 
 			/* FIXME: update the interface later. csrc doesn't need be passed to clients */
 
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned((uint16_t *) pdata);
+			tcsrc += bt_get_16(pdata);
+			memcpy(pcsrc, &tcsrc, sizeof(tcsrc));
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
@@ -4336,7 +4340,7 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	reqsize += seqlen;
 	pdata += seqlen;
 
-	bt_put_unaligned(htons(SDP_MAX_ATTR_LEN), (uint16_t *) pdata);
+	bt_put_be16(SDP_MAX_ATTR_LEN, pdata);
 	reqsize += sizeof(uint16_t);
 	pdata += sizeof(uint16_t);
 
-- 
1.7.9.5

