Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Carlos Azevedo <carlosarazevedo@netcabo.pt>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cF6sBYTFANZ0o9l"
Message-Id: <200412060001.32565.carlosarazevedo@netcabo.pt>
Subject: [Bluez-devel] Patch for hcidump-1.15
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 6 Dec 2004 00:01:32 +0000

--Boundary-00=_cF6sBYTFANZ0o9l
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds support for partial responses in the SDP code. The present
code tries to parse each of the partial responses to a REQ, which may not be
possible since the responses may be broken up in any way. This patch
introduces caching and late parsing were all the response is stored and
parsed only when complete. It does not support multiple concurrent pending
responses (from diferent connections or REQs).
This patch resolves the problem in
http://sourceforge.net/mailarchive/forum.php?thread_id=6078979&forum_id=1883

Carlos A. R. Azevedo

--Boundary-00=_cF6sBYTFANZ0o9l
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch.diff"

diff -urN bluez-hcidump-1.15/parser/l2cap.c bluez-hcidump-patched/parser/l2cap.c
--- bluez-hcidump-1.15/parser/l2cap.c	2004-11-25 12:05:16.000000000 +0000
+++ bluez-hcidump-patched/parser/l2cap.c	2004-12-03 02:43:31.000000000 +0000
@@ -369,6 +369,8 @@
 
 static void l2cap_parse(int level, struct frame *frm)
 {
+	void *temp_ptr;
+	int temp_len;
 	l2cap_hdr *hdr = (void *)frm->ptr;
 	uint16_t dlen = btohs(hdr->len);
 	uint16_t cid  = btohs(hdr->cid);
@@ -476,10 +478,14 @@
 
 		switch (psm) {
 		case 0x01:
-			if (!p_filter(FILT_SDP))
+			if (!p_filter(FILT_SDP)) {
+				temp_ptr = frm->ptr;
+				temp_len = frm->len;
 				sdp_dump(level + 1, frm);
-			else
-				raw_dump(level + 1, frm);
+				frm->ptr = temp_ptr;
+				frm->len = temp_len;
+			}
+			raw_dump(level + 1, frm);
 			break;
 
 		case 0x03:
diff -urN bluez-hcidump-1.15/parser/sdp.c bluez-hcidump-patched/parser/sdp.c
--- bluez-hcidump-1.15/parser/sdp.c	2004-11-11 18:42:28.000000000 +0000
+++ bluez-hcidump-patched/parser/sdp.c	2004-12-05 19:51:12.000000000 +0000
@@ -135,6 +135,11 @@
 	{ SDP_ATTR_ID_IPV6_SUBNET,                       "IPv6Subnet"         }  /* PAN */
 };
 
+static sdp_rsp_cache_page_t * sdp_service_search_rsp_cache = NULL;
+static sdp_rsp_cache_page_t * sdp_service_attr_rsp_cache = NULL;
+static sdp_rsp_cache_page_t * sdp_service_search_attr_rsp_cache = NULL;
+
+
 char* get_uuid_name(int uuid)
 {
 	int i;
@@ -176,7 +181,10 @@
 			*n = get_u64(frm); break;
 		}
 	} else {
-		*n = sdp_siz_idx_lookup_table[siz_idx].num_bytes;
+		if (de_type == SDP_DE_NULL)
+			*n = 0;
+		else
+			*n = sdp_siz_idx_lookup_table[siz_idx].num_bytes;
 	}
 
 	return de_type;
@@ -575,17 +583,212 @@
 	print_attr_lists(level, frm, cnt);
 }
 
+static inline int verify_continuation(uint8_t pid, void * ptr, sdp_rsp_cache_page_t * * full_response)
+{
+	int data_size;
+	uint8_t cont_size;
+	uint16_t total_service_record_count;
+	uint16_t current_service_record_count;
+	uint16_t attribute_list_byte_count;
+	int alloc_size;
+	uint16_t * ptr16;
+	uint8_t * ptr8;
+	sdp_rsp_cache_page_t * realloc_block;
+
+	*full_response = NULL;
+	switch (pid) {
+	case SDP_SERVICE_SEARCH_RSP:
+		data_size = sizeof(uint16_t) + sizeof(uint16_t) + (ntohs(*(((uint16_t *)ptr) + 1)) * sizeof(uint32_t));
+		cont_size = *(((uint8_t *)ptr) + data_size);
+		/* Check if this response is complete */
+		if (cont_size == 0) {
+			/* Check if it's not part of a previous response */
+			if (sdp_service_search_rsp_cache == NULL)
+				/* If not parse just this response */
+				return 0;
+		}
+		/* If this response is incomplete or part of a previous one ... */
+		if (sdp_service_search_rsp_cache == NULL) {
+			/* The response is incomplete and is the first */
+			total_service_record_count = *((uint16_t *)ptr);	/* The value isn't byte-reordered on purpose */
+			current_service_record_count = ntohs(*((uint16_t *)ptr));
+			/* Compute the size of the complete response */
+			alloc_size = sizeof(*sdp_service_search_rsp_cache) + (2 * sizeof(uint16_t)) + 
+					    (ntohs(total_service_record_count) * sizeof(uint32_t)) +
+					    sizeof(uint8_t);
+			/* Allocate a cache page for it */
+			sdp_service_search_rsp_cache = malloc(alloc_size);
+			if (sdp_service_search_rsp_cache == NULL)
+				return 0;
+			/* Copy this response to the cache page */
+			sdp_service_search_rsp_cache->page_size = alloc_size;
+			ptr16 = (uint16_t *)sdp_service_search_rsp_cache->data;
+			*ptr16 = total_service_record_count;
+			*(ptr16 + 1) = total_service_record_count;
+			memmove(ptr16 + 2,((uint16_t *)ptr) + 2,current_service_record_count * sizeof(uint32_t));
+			sdp_service_search_rsp_cache->write_pos = (sizeof(uint16_t) * 2) + (current_service_record_count * sizeof(uint32_t));
+			return 1;
+		} else {
+			/* Append this response to the cache page */
+			current_service_record_count = ntohs(*((uint16_t *)ptr));
+			ptr8 = ((uint8_t *)sdp_service_search_rsp_cache->data) + sdp_service_search_rsp_cache->write_pos;
+			memmove(ptr8,((uint16_t *)ptr) + 2,current_service_record_count * sizeof(uint32_t));
+			/* If it is the last terminate it with a zero (meaning no Continuation State) */
+			if (cont_size == 0)
+			{
+				*(ptr8 + (current_service_record_count * sizeof(uint32_t))) = 0;
+				*full_response = sdp_service_search_rsp_cache;
+			}
+			return 1;
+		}
+		break;
+	case SDP_SERVICE_ATTR_RSP:
+		data_size = sizeof(uint16_t) + ntohs(*((uint16_t *)ptr));
+		cont_size = *(((uint8_t *)ptr) + data_size);
+		/* Check if this response is complete */
+		if (cont_size == 0) {
+			/* Check if it's not part of a previous response */
+			if (sdp_service_attr_rsp_cache == NULL)
+				/* If not parse just this response */
+				return 0;
+		}
+		/* If this response is incomplete or part of a previous one ... */
+		if (sdp_service_attr_rsp_cache == NULL) {
+			/* The response is incomplete and is the first */
+			attribute_list_byte_count = ntohs(*((uint16_t *)ptr));
+			/* Compute the page size for this response. Subsequent responses will force a realloc */
+			alloc_size = sizeof(*sdp_service_attr_rsp_cache) + sizeof(uint16_t) + 
+				     attribute_list_byte_count + sizeof(uint8_t);
+			/* Allocate a cache page for it */
+			sdp_service_attr_rsp_cache = malloc(alloc_size);
+			if (sdp_service_attr_rsp_cache == NULL)
+				return 0;
+			/* Copy this response to the cache page */
+			sdp_service_attr_rsp_cache->page_size = alloc_size;
+			ptr16 = (uint16_t *)sdp_service_attr_rsp_cache->data;
+			*ptr16 = attribute_list_byte_count;
+			memmove(ptr16 + 1,((uint16_t *)ptr) + 1,attribute_list_byte_count);
+			sdp_service_attr_rsp_cache->write_pos = sizeof(uint16_t) + attribute_list_byte_count;
+			return 1;
+		} else {
+			/* Append this response to the cache page */
+			attribute_list_byte_count = ntohs(*((uint16_t *)ptr));
+			realloc_block = realloc(sdp_service_attr_rsp_cache,sdp_service_attr_rsp_cache->page_size + 
+						attribute_list_byte_count);
+			if (realloc_block == NULL) {
+				free(sdp_service_attr_rsp_cache);
+				return 0;
+			}
+			sdp_service_attr_rsp_cache = realloc_block;
+			sdp_service_attr_rsp_cache->page_size += attribute_list_byte_count;
+			ptr16 = (uint16_t *)sdp_service_attr_rsp_cache->data;
+			*ptr16 += attribute_list_byte_count;
+			ptr8 = ((uint8_t *)sdp_service_attr_rsp_cache->data) + sdp_service_attr_rsp_cache->write_pos;
+			memmove(ptr8,((uint16_t *)ptr) + 1,attribute_list_byte_count);
+			sdp_service_attr_rsp_cache->write_pos += attribute_list_byte_count;
+			/* If it is the last terminate it with a zero (meaning no Continuation State) */
+			if (cont_size == 0)
+			{
+				*ptr16 = htons(*ptr16);				/* Re-order the word */
+				*(ptr8 + attribute_list_byte_count) = 0;
+				*full_response = sdp_service_attr_rsp_cache;
+			}
+			return 1;
+		}
+		break;
+	case SDP_SERVICE_SEARCH_ATTR_RSP:
+		data_size = sizeof(uint16_t) + ntohs(*((uint16_t *)ptr));
+		cont_size = *(((uint8_t *)ptr) + data_size);
+		/* Check if this response is complete */
+		if (cont_size == 0) {
+			/* Check if it's not part of a previous response */
+			if (sdp_service_search_attr_rsp_cache == NULL)
+				/* If not parse just this response */
+				return 0;
+		}
+		/* If this response is incomplete or part of a previous one ... */
+		if (sdp_service_search_attr_rsp_cache == NULL) {
+			/* The response is incomplete and is the first */
+			attribute_list_byte_count = ntohs(*((uint16_t *)ptr));
+			/* Compute the page size for this response. Subsequent responses will force a realloc */
+			alloc_size = sizeof(*sdp_service_search_attr_rsp_cache) + sizeof(uint16_t) + 
+				     attribute_list_byte_count + sizeof(uint8_t);
+			/* Allocate a cache page for it */
+			sdp_service_search_attr_rsp_cache = malloc(alloc_size);
+			if (sdp_service_search_attr_rsp_cache == NULL)
+				return 0;
+			/* Copy this response to the cache page */
+			sdp_service_search_attr_rsp_cache->page_size = alloc_size;
+			ptr16 = (uint16_t *)sdp_service_search_attr_rsp_cache->data;
+			*ptr16 = attribute_list_byte_count;
+			memmove(ptr16 + 1,((uint16_t *)ptr) + 1,attribute_list_byte_count);
+			sdp_service_search_attr_rsp_cache->write_pos = sizeof(uint16_t) + attribute_list_byte_count;
+			return 1;
+		} else {
+			/* Append this response to the cache page */
+			attribute_list_byte_count = ntohs(*((uint16_t *)ptr));
+			realloc_block = realloc(sdp_service_search_attr_rsp_cache,sdp_service_search_attr_rsp_cache->page_size + 
+						attribute_list_byte_count);
+			if (realloc_block == NULL) {
+				free(sdp_service_search_attr_rsp_cache);
+				return 0;
+			}
+			sdp_service_search_attr_rsp_cache = realloc_block;
+			sdp_service_search_attr_rsp_cache->page_size += attribute_list_byte_count;
+			ptr16 = (uint16_t *)sdp_service_search_attr_rsp_cache->data;
+			*ptr16 += attribute_list_byte_count;
+			ptr8 = ((uint8_t *)sdp_service_search_attr_rsp_cache->data) + sdp_service_search_attr_rsp_cache->write_pos;
+			memmove(ptr8,((uint16_t *)ptr) + 1,attribute_list_byte_count);
+			sdp_service_search_attr_rsp_cache->write_pos += attribute_list_byte_count;
+			/* If it is the last terminate it with a zero (meaning no Continuation State) */
+			if (cont_size == 0)
+			{
+				*ptr16 = htons(*ptr16);				/* Re-order the word */
+				*(ptr8 + attribute_list_byte_count) = 0;
+				*full_response = sdp_service_search_attr_rsp_cache;
+			}
+			return 1;
+		}
+		break;
+	}
+	return 0;
+}
+
 void sdp_dump(int level, struct frame *frm)
 {
 	sdp_pdu_hdr *hdr = frm->ptr;
  	uint16_t tid = ntohs(hdr->tid);
 	uint16_t len = ntohs(hdr->len);
-
+	sdp_rsp_cache_page_t * cmpl_resp;
+	void * to_release = NULL;
+	
 	frm->ptr += SDP_PDU_HDR_SIZE;
 	frm->len -= SDP_PDU_HDR_SIZE;
 
 	p_indent(level, frm);
 
+	if (verify_continuation(hdr->pid,frm->ptr,&cmpl_resp))
+	{
+		if (cmpl_resp == NULL) {
+			switch (hdr->pid) {
+			case SDP_SERVICE_SEARCH_RSP:
+				printf("SDP SS Rsp: tid 0x%x len 0x%x\n", tid, len);
+				break;
+			case SDP_SERVICE_ATTR_RSP:
+				printf("SDP SA Rsp: tid 0x%x len 0x%x\n", tid, len);
+				break;
+			case SDP_SERVICE_SEARCH_ATTR_RSP:
+				printf("SDP SSA Rsp: tid 0x%x len 0x%x\n", tid, len);
+				break;
+			}
+			p_indent(level, frm);
+			printf("Partial SDP response detected. Cached for late parsing\n");
+			return;
+		}
+		frm->ptr = cmpl_resp->data;
+		frm->len = cmpl_resp->page_size - sizeof(sdp_rsp_cache_page_t);
+		to_release = cmpl_resp;
+	}
 	switch (hdr->pid) {
 	case SDP_ERROR_RSP:
 		err_rsp(level, tid, len, frm);
@@ -611,6 +814,8 @@
 	default:
 		printf("ERROR: Unknown PDU ID: 0x%x\n", hdr->pid);
 		raw_dump(++level, frm);
+		if (to_release)
+			free(to_release);
 		return;
 	}
 
@@ -618,11 +823,16 @@
 		/* Parse ContinuationState */
 		int i;
 		unsigned char *buf = frm->ptr;
-		p_indent(++level, frm);
-		printf("cont ");
-		for (i=0; i < frm->len; i++) {
-			printf("%2.2X ", buf[i]);
+		if (*buf) {
+			p_indent(++level, frm);
+			printf("cont ");
+			for (i=0; i < frm->len; i++) {
+				printf("%2.2X ", buf[i]);
+			}
+			printf("\n");
 		}
-		printf("\n");
 	}
+		
+	if (to_release)
+		free(to_release);
 }
diff -urN bluez-hcidump-1.15/parser/sdp.h bluez-hcidump-patched/parser/sdp.h
--- bluez-hcidump-1.15/parser/sdp.h	2004-11-11 18:42:28.000000000 +0000
+++ bluez-hcidump-patched/parser/sdp.h	2004-12-03 04:29:06.000000000 +0000
@@ -180,4 +180,12 @@
 #define SDP_ATTR_ID_NAM_LOOKUP_TABLE_SIZE \
 	(sizeof(sdp_attr_id_nam_lookup_table)/sizeof(sdp_attr_id_nam_lookup_table_t))
 
+/* Cache structure for partial responses */	
+typedef struct {
+	int page_size;
+	int write_pos;
+	char data[0];
+} sdp_rsp_cache_page_t;
+
+
 #endif /* __SDP_H */

--Boundary-00=_cF6sBYTFANZ0o9l--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
