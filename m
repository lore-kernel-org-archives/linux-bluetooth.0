Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] SDP memory checks
From: Santiago Carot Nemesio <scarot@libresoft.es>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 09:25:39 +0200
Message-ID: <1272353139.2157.8.camel@mosquito>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add some memory checks after malloc is called. Also some blank spaces at the end of the lines are removed.
I observed that sometimes functions returns NULL or 0 without any convention. I set all to NULL to formalice the source code.

Regards.


diff --git a/lib/sdp.c b/lib/sdp.c
index 7cf710b..04538bd 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1078,6 +1078,8 @@ static sdp_data_t *extract_int(const void *p, int bufsize, int *len)
 	}
 
 	d = malloc(sizeof(sdp_data_t));
+	if (!d)
+		return NULL;
 
 	SDPDBG("Extracting integer\n");
 	memset(d, 0, sizeof(sdp_data_t));
@@ -1151,6 +1153,8 @@ static sdp_data_t *extract_uuid(const uint8_t *p, int bufsize, int *len,
 							sdp_record_t *rec)
 {
 	sdp_data_t *d = malloc(sizeof(sdp_data_t));
+	if (!d)
+		return NULL;
 
 	SDPDBG("Extracting UUID");
 	memset(d, 0, sizeof(sdp_data_t));
@@ -1179,6 +1183,8 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 	}
 
 	d = malloc(sizeof(sdp_data_t));
+	if (!d)
+		return NULL;
 
 	memset(d, 0, sizeof(sdp_data_t));
 	d->dtd = *(uint8_t *) p;
@@ -1214,7 +1220,7 @@ static sdp_data_t *extract_str(const void *p, int bufsize, int *len)
 	default:
 		SDPERR("Sizeof text string > UINT16_MAX\n");
 		free(d);
-		return 0;
+		return NULL;
 	}
 
 	if (bufsize < n) {
@@ -1302,6 +1308,9 @@ static sdp_data_t *extract_seq(const void *p, int bufsize, int *len,
 	sdp_data_t *curr, *prev;
 	sdp_data_t *d = malloc(sizeof(sdp_data_t));
 
+	if (!d)
+		return NULL;
+
 	SDPDBG("Extracting SEQ");
 	memset(d, 0, sizeof(sdp_data_t));
 	*len = sdp_extract_seqtype(p, bufsize, &d->dtd, &seqlen);
@@ -1771,7 +1780,7 @@ sdp_list_t *sdp_list_append(sdp_list_t *p, void *d)
 	sdp_list_t *q, *n = malloc(sizeof(sdp_list_t));
 
 	if (!n)
-		return 0;
+		return NULL;
 
 	n->data = d;
 	n->next = 0;
@@ -1809,7 +1818,7 @@ sdp_list_t *sdp_list_insert_sorted(sdp_list_t *list, void *d,
 
 	n = malloc(sizeof(sdp_list_t));
 	if (!n)
-		return 0;
+		return NULL;
 	n->data = d;
 	for (q = 0, p = list; p; q = p, p = p->next)
 		if (f(p->data, d) >= 0)
@@ -1949,6 +1958,8 @@ int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
 				goto fail;
 
 			u = malloc(sizeof(uuid_t));
+			if (!u)
+				goto fail;
 			memset(u, 0, sizeof(uuid_t));
 			*u = d->val.uuid;
 			*seqp = sdp_list_append(*seqp, u);
@@ -1974,7 +1985,13 @@ int sdp_set_uuidseq_attr(sdp_record_t *rec, uint16_t aid, sdp_list_t *seq)
 	if (!seq || len == 0)
 		return -1;
 	dtds = (void **)malloc(len * sizeof(void *));
+	if (!dtds)
+		return -1;
 	values = (void **)malloc(len * sizeof(void *));
+	if (!values) {
+		free(dtds);
+		return -1;
+	}
 	for (p = seq, i = 0; i < len; i++, p = p->next) {
 		uuid_t *uuid = (uuid_t *)p->data;
 		if (uuid)
@@ -2028,6 +2045,8 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
 		sdp_data_t *pOffset = pEncoding->next;
 		if (pEncoding && pOffset) {
 			lang = malloc(sizeof(sdp_lang_attr_t));
+			if (!lang)
+				goto fail;
 			lang->code_ISO639 = pCode->val.uint16;
 			lang->encoding = pEncoding->val.uint16;
 			lang->base_offset = pOffset->val.uint16;
@@ -2039,6 +2058,10 @@ int sdp_get_lang_attr(const sdp_record_t *rec, sdp_list_t **langSeq)
 		curr_data = pOffset->next;
 	}
 	return 0;
+fail:
+	sdp_list_free(*langSeq, free);
+	*langSeq = NULL;
+	return -1;
 }
 
 int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
@@ -2069,6 +2092,8 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 
 		if (uuid != NULL) {
 			profDesc = malloc(sizeof(sdp_profile_desc_t));
+			if (!profDesc)
+				goto fail;
 			profDesc->uuid = *uuid;
 			profDesc->version = version;
 #ifdef SDP_DEBUG
@@ -2079,6 +2104,10 @@ int sdp_get_profile_descs(const sdp_record_t *rec, sdp_list_t **profDescSeq)
 		}
 	}
 	return 0;
+fail:
+	sdp_list_free(*profDescSeq, free);
+	*profDescSeq = NULL;
+	return -1;
 }
 
 int sdp_get_server_ver(const sdp_record_t *rec, sdp_list_t **u16)
@@ -2231,7 +2260,15 @@ static sdp_data_t *access_proto_to_dataseq(sdp_record_t *rec, sdp_list_t *proto)
 
 	seqlen = sdp_list_len(proto);
 	seqDTDs = (void **)malloc(seqlen * sizeof(void *));
+	if (!seqDTDs)
+		return NULL;
+
 	seqs = (void **)malloc(seqlen * sizeof(void *));
+	if (!seqs) {
+		free(seqDTDs);
+		return NULL;
+	}
+
 	for (i = 0, p = proto; p; p = p->next, i++) {
 		sdp_list_t *elt = (sdp_list_t *)p->data;
 		sdp_data_t *s;
@@ -2349,11 +2386,20 @@ int sdp_set_add_access_protos(sdp_record_t *rec, const sdp_list_t *ap)
 int sdp_set_lang_attr(sdp_record_t *rec, const sdp_list_t *seq)
 {
 	uint8_t uint16 = SDP_UINT16;
+	void **dtds, **values;
 	int status = 0, i = 0, seqlen = sdp_list_len(seq);
-	void **dtds = (void **)malloc(3 * seqlen * sizeof(void *));
-	void **values = (void **)malloc(3 * seqlen * sizeof(void *));
 	const sdp_list_t *p;
 
+	dtds = (void **)malloc(3 * seqlen * sizeof(void *));
+	if (!dtds)
+		return -1;
+
+	values = (void **)malloc(3 * seqlen * sizeof(void *));
+	if (!values) {
+		free(dtds);
+		return -1;
+	}
+
 	for (p = seq; p; p = p->next) {
 		sdp_lang_attr_t *lang = (sdp_lang_attr_t *)p->data;
 		if (!lang) {
@@ -2455,10 +2501,18 @@ int sdp_set_profile_descs(sdp_record_t *rec, const sdp_list_t *profiles)
 	uint8_t uuid128 = SDP_UUID128;
 	uint8_t uint16 = SDP_UINT16;
 	int i = 0, seqlen = sdp_list_len(profiles);
-	void **seqDTDs = (void **)malloc(seqlen * sizeof(void *));
-	void **seqs = (void **)malloc(seqlen * sizeof(void *));
+	void **seqDTDs;
+	void **seqs;
 	const sdp_list_t *p;
 
+	seqDTDs = (void **)malloc(seqlen * sizeof(void *));
+	if (!seqDTDs)
+		return -1;
+	seqs = (void **)malloc(seqlen * sizeof(void *));
+	if (!seqs) {
+		free(seqDTDs);
+		return -1;
+	}
 	for (p = profiles; p; p = p->next) {
 		sdp_data_t *seq;
 		void *dtds[2], *values[2];
@@ -2642,7 +2696,11 @@ void sdp_uuid32_to_uuid128(uuid_t *uuid128, uuid_t *uuid32)
 
 uuid_t *sdp_uuid_to_uuid128(uuid_t *uuid)
 {
-	uuid_t *uuid128 = bt_malloc(sizeof(uuid_t));
+	uuid_t *uuid128 = malloc(sizeof(uuid_t));
+
+	if (!uuid128)
+		return NULL;
+
 	memset(uuid128, 0, sizeof(uuid_t));
 	switch (uuid->type) {
 	case SDP_UUID128:
@@ -2796,7 +2854,17 @@ int sdp_device_record_register_binary(sdp_session_t *session, bdaddr_t *device,
 		return -1;
 	}
 	req = malloc(SDP_REQ_BUFFER_SIZE);
+	if(!req) {
+		errno = ENOMEM;
+		return -1;
+	}
+
 	rsp = malloc(SDP_RSP_BUFFER_SIZE);
+	if(!rsp) {
+		errno = ENOMEM;
+		return -1;
+	}
+
 	if (req == NULL || rsp == NULL) {
 		status = -1;
 		errno = ENOMEM;
@@ -3087,6 +3155,9 @@ int sdp_record_update(sdp_session_t *session, const sdp_record_t *rec)
 sdp_record_t *sdp_record_alloc()
 {
 	sdp_record_t *rec = malloc(sizeof(sdp_record_t));
+
+	if (!rec)
+		return NULL;
 	memset((void *)rec, 0, sizeof(sdp_record_t));
 	rec->handle = 0xffffffff;
 	return rec;
@@ -3254,7 +3325,7 @@ static int copy_cstate(uint8_t *pdata, int pdata_len, const sdp_cstate_t *cstate
 }
 
 /*
- * This is a service search request. 
+ * This is a service search request.
  *
  * INPUT :
  *
@@ -3417,7 +3488,7 @@ end:
 }
 
 /*
- * This is a service attribute request. 
+ * This is a service attribute request.
  *
  * INPUT :
  *
@@ -3438,7 +3509,7 @@ end:
  *
  *   sdp_list_t *attrid
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
  * OUTPUT :
@@ -3448,7 +3519,7 @@ end:
  *     !0:
  *	 The service record
  */
-sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle, 
+sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 			sdp_attrreq_type_t reqtype, const sdp_list_t *attrids)
 {
 	uint32_t reqsize = 0, _reqsize;
@@ -3494,7 +3565,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 	pdata += sizeof(uint16_t);
 
 	// get attr seq PDU form
-	seqlen = gen_attridseq_pdu(pdata, attrids, 
+	seqlen = gen_attridseq_pdu(pdata, attrids,
 		reqtype == SDP_ATTR_REQ_INDIVIDUAL? SDP_UINT16 : SDP_UINT32);
 	if (seqlen == -1) {
 		errno = EINVAL;
@@ -3558,7 +3629,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 		SDPDBG("sdp_cstate_t length : %d\n", cstate_len);
 
 		/*
-		 * a split response: concatenate intermediate responses 
+		 * a split response: concatenate intermediate responses
 		 * and the last one (which has cstate_len == 0)
 		 */
 		if (cstate_len > 0 || rsp_concat_buf.data_size != 0) {
@@ -3583,7 +3654,7 @@ sdp_record_t *sdp_service_attr_req(sdp_session_t *session, uint32_t handle,
 		}
 		rec = sdp_extract_pdu(pdata, pdata_len, &scanned);
 	}
-	
+
 end:
 	if (reqbuf)
 		free(reqbuf);
@@ -3676,7 +3747,7 @@ int sdp_set_notify(sdp_session_t *session, sdp_callback_t *func, void *udata)
 
 /*
  * This function starts an asynchronous service search request.
- * The incomming and outgoing data are stored in the transaction structure 
+ * The incomming and outgoing data are stored in the transaction structure
  * buffers. When there is incomming data the sdp_process function must be
  * called to get the data and handle the continuation state.
  *
@@ -3771,7 +3842,7 @@ end:
 
 /*
  * This function starts an asynchronous service attribute request.
- * The incomming and outgoing data are stored in the transaction structure 
+ * The incomming and outgoing data are stored in the transaction structure
  * buffers. When there is incomming data the sdp_process function must be
  * called to get the data and handle the continuation state.
  *
@@ -3796,7 +3867,7 @@ end:
  *
  *   sdp_list_t *attrid_list
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
  * OUTPUT :
@@ -3912,7 +3983,7 @@ end:
  *
  *   sdp_list_t *attrid_list
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
 
@@ -4130,7 +4201,7 @@ int sdp_process(sdp_session_t *session)
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned((uint16_t *) pdata); 
+			*pcsrc += bt_get_unaligned((uint16_t *) pdata);
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
@@ -4141,8 +4212,8 @@ int sdp_process(sdp_session_t *session)
 	case SDP_SVC_SEARCH_ATTR_RSP:
 		rsp_count = ntohs(bt_get_unaligned((uint16_t *) pdata));
 		SDPDBG("Attrlist byte count : %d\n", rsp_count);
-	
-		/* 
+
+		/*
 		 * Number of bytes in the AttributeLists parameter(without
 		 * continuation state) + AttributeListsByteCount field size.
 		 */
@@ -4168,7 +4239,7 @@ int sdp_process(sdp_session_t *session)
 
 	SDPDBG("Cstate length : %d\n", pcstate->length);
 
-	/* 
+	/*
 	 * Check out of bound. Continuation state must have at least
 	 * 1 byte: ZERO to indicate that it is not a partial response.
 	 */
@@ -4202,7 +4273,7 @@ int sdp_process(sdp_session_t *session)
 
 		// set the request header's param length
 		reqhdr->plen = htons(reqsize - sizeof(sdp_pdu_hdr_t));
-	
+
 		if (sdp_send_req(session, t->reqbuf, reqsize) < 0) {
 			SDPERR("Error sendind data:%s(%d)", strerror(errno), errno);
 			status = 0xffff;
@@ -4253,7 +4324,7 @@ end:
  *
  *   sdp_list_t *attrids
  *     Singly linked list containing attribute identifiers desired.
- *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)  
+ *     Every element is either a uint16_t(attrSpec = SDP_ATTR_REQ_INDIVIDUAL)
  *     or a uint32_t(attrSpec=SDP_ATTR_REQ_RANGE)
  *
  * OUTPUT :

