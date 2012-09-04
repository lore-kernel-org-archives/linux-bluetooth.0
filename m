Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 15/18] Refactor bt_get_unaligned macro
Date: Tue, 4 Sep 2012 16:41:34 +0200
Message-ID: <1346769697-9930-16-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use extra parameter type for bt_get_unaligned to avoid pointer casting
which might trigger compile time errors due to unaligned memory access.

---
 attrib/att.h       |    6 +++---
 lib/bluetooth.h    |   28 ++++++++++++++--------------
 lib/sdp.c          |   22 +++++++++++-----------
 src/sdpd-request.c |    4 ++--
 4 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index a563255..6101dac 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -115,19 +115,19 @@ struct att_range {
 static inline uint8_t att_get_u8(const void *ptr)
 {
 	const uint8_t *u8_ptr = ptr;
-	return bt_get_unaligned(u8_ptr);
+	return bt_get_unaligned(u8_ptr, uint8_t);
 }
 
 static inline uint16_t att_get_u16(const void *ptr)
 {
 	const uint16_t *u16_ptr = ptr;
-	return btohs(bt_get_unaligned(u16_ptr));
+	return btohs(bt_get_unaligned(u16_ptr, uint16_t));
 }
 
 static inline uint32_t att_get_u32(const void *ptr)
 {
 	const uint32_t *u32_ptr = ptr;
-	return btohl(bt_get_unaligned(u32_ptr));
+	return btohl(bt_get_unaligned(u32_ptr, uint32_t));
 }
 
 static inline uint128_t att_get_u128(const void *ptr)
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 161b7bd..898a122 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -137,10 +137,10 @@ enum {
 #endif
 
 /* Bluetooth unaligned access */
-#define bt_get_unaligned(ptr)			\
+#define bt_get_unaligned(ptr, type)		\
 ({						\
 	struct __attribute__((packed)) {	\
-		typeof(*(ptr)) __v;		\
+		type __v;			\
 	} *__p = (typeof(__p)) (ptr);		\
 	__p->__v;				\
 })
@@ -156,32 +156,32 @@ do {						\
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 static inline uint64_t bt_get_le64(const void *ptr)
 {
-	return bt_get_unaligned((const uint64_t *) ptr);
+	return bt_get_unaligned(ptr, uint64_t);
 }
 
 static inline uint64_t bt_get_be64(const void *ptr)
 {
-	return bswap_64(bt_get_unaligned((const uint64_t *) ptr));
+	return bswap_64(bt_get_unaligned(ptr, uint64_t));
 }
 
 static inline uint32_t bt_get_le32(const void *ptr)
 {
-	return bt_get_unaligned((const uint32_t *) ptr);
+	return bt_get_unaligned(ptr, uint32_t);
 }
 
 static inline uint32_t bt_get_be32(const void *ptr)
 {
-	return bswap_32(bt_get_unaligned((const uint32_t *) ptr));
+	return bswap_32(bt_get_unaligned(ptr, uint32_t));
 }
 
 static inline uint16_t bt_get_le16(const void *ptr)
 {
-	return bt_get_unaligned((const uint16_t *) ptr);
+	return bt_get_unaligned(ptr, uint16_t);
 }
 
 static inline uint16_t bt_get_be16(const void *ptr)
 {
-	return bswap_16(bt_get_unaligned((const uint16_t *) ptr));
+	return bswap_16(bt_get_unaligned(ptr, uint16_t));
 }
 
 static inline void bt_put_le64(uint64_t val, const void *ptr)
@@ -217,32 +217,32 @@ static inline void bt_put_be16(uint16_t val, const void *ptr)
 #elif __BYTE_ORDER == __BIG_ENDIAN
 static inline uint64_t bt_get_le64(const void *ptr)
 {
-	return bswap_64(bt_get_unaligned((const uint64_t *) ptr));
+	return bswap_64(bt_get_unaligned(ptr, uint64_t));
 }
 
 static inline uint64_t bt_get_be64(const void *ptr)
 {
-	return bt_get_unaligned((const uint64_t *) ptr);
+	return bt_get_unaligned(ptr, uint64_t);
 }
 
 static inline uint32_t bt_get_le32(const void *ptr)
 {
-	return bswap_32(bt_get_unaligned((const uint32_t *) ptr));
+	return bswap_32(bt_get_unaligned(ptr, uint32_t));
 }
 
 static inline uint32_t bt_get_be32(const void *ptr)
 {
-	return bt_get_unaligned((const uint32_t *) ptr);
+	return bt_get_unaligned(ptr, uint32_t);
 }
 
 static inline uint16_t bt_get_le16(const void *ptr)
 {
-	return bswap_16(bt_get_unaligned((const uint16_t *) ptr));
+	return bswap_16(bt_get_unaligned(ptr, uint16_t));
 }
 
 static inline uint16_t bt_get_be16(const void *ptr)
 {
-	return bt_get_unaligned((const uint16_t *) ptr);
+	return bt_get_unaligned(ptr, uint16_t);
 }
 
 static inline void bt_put_le64(uint64_t val, const void *ptr)
diff --git a/lib/sdp.c b/lib/sdp.c
index 1a5bf01..a533b12 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -376,27 +376,27 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 		d->unitSize += sizeof(int8_t);
 		break;
 	case SDP_UINT16:
-		d->val.uint16 = bt_get_unaligned((uint16_t *) value);
+		d->val.uint16 = bt_get_unaligned(value, uint16_t);
 		d->unitSize += sizeof(uint16_t);
 		break;
 	case SDP_INT16:
-		d->val.int16 = bt_get_unaligned((int16_t *) value);
+		d->val.int16 = bt_get_unaligned(value, int16_t);
 		d->unitSize += sizeof(int16_t);
 		break;
 	case SDP_UINT32:
-		d->val.uint32 = bt_get_unaligned((uint32_t *) value);
+		d->val.uint32 = bt_get_unaligned(value, uint32_t);
 		d->unitSize += sizeof(uint32_t);
 		break;
 	case SDP_INT32:
-		d->val.int32 = bt_get_unaligned((int32_t *) value);
+		d->val.int32 = bt_get_unaligned(value, int32_t);
 		d->unitSize += sizeof(int32_t);
 		break;
 	case SDP_INT64:
-		d->val.int64 = bt_get_unaligned((int64_t *) value);
+		d->val.int64 = bt_get_unaligned(value, int64_t);
 		d->unitSize += sizeof(int64_t);
 		break;
 	case SDP_UINT64:
-		d->val.uint64 = bt_get_unaligned((uint64_t *) value);
+		d->val.uint64 = bt_get_unaligned(value, uint64_t);
 		d->unitSize += sizeof(uint64_t);
 		break;
 	case SDP_UINT128:
@@ -408,11 +408,11 @@ sdp_data_t *sdp_data_alloc_with_length(uint8_t dtd, const void *value,
 		d->unitSize += sizeof(uint128_t);
 		break;
 	case SDP_UUID16:
-		sdp_uuid16_create(&d->val.uuid, bt_get_unaligned((uint16_t *) value));
+		sdp_uuid16_create(&d->val.uuid, bt_get_unaligned(value, uint16_t));
 		d->unitSize += sizeof(uint16_t);
 		break;
 	case SDP_UUID32:
-		sdp_uuid32_create(&d->val.uuid, bt_get_unaligned((uint32_t *) value));
+		sdp_uuid32_create(&d->val.uuid, bt_get_unaligned(value, uint32_t));
 		d->unitSize += sizeof(uint32_t);
 		break;
 	case SDP_UUID128:
@@ -2991,7 +2991,7 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
+	status = bt_get_unaligned(p, uint16_t);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* For this case the status always is invalid record handle */
@@ -3096,7 +3096,7 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
+	status = bt_get_unaligned(p, uint16_t);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* The status can be invalid sintax or invalid record handle */
@@ -4153,7 +4153,7 @@ int sdp_process(sdp_session_t *session)
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned((uint16_t *) pdata);
+			*pcsrc += bt_get_unaligned(pdata, uint16_t);
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 2af743e..6bf7f89 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -183,7 +183,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				pElem = (char *) aid;
 			} else {
 				pElem = malloc(sizeof(uint16_t));
-				bt_put_be16(bt_get_unaligned((uint16_t *)p), pElem);
+				bt_put_be16(bt_get_unaligned(p, uint16_t), pElem);
 			}
 			p += sizeof(uint16_t);
 			seqlen += sizeof(uint16_t);
@@ -207,7 +207,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				pElem = (char *) aid;
 			} else {
 				pElem = malloc(sizeof(uint32_t));
-				bt_put_be32(bt_get_unaligned((uint32_t *)p), pElem);
+				bt_put_be32(bt_get_unaligned(p, uint32_t), pElem);
 			}
 			p += sizeof(uint32_t);
 			seqlen += sizeof(uint32_t);
-- 
1.7.9.5

