Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/8] sdpd: Remove 'register' and 'remove' requests
Date: Thu, 19 Sep 2013 16:00:46 +0200
Message-ID: <1379599248-7923-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

sdpd is now controlled by adapters and should not be modified with
other means.
---
 src/sdpd-request.c |  14 --------
 src/sdpd-service.c | 100 -----------------------------------------------------
 src/sdpd.h         |   2 --
 3 files changed, 116 deletions(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index fbeb488..5b88a10 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -997,13 +997,6 @@ static void process_request(sdp_req_t *req)
 		rsphdr->pdu_id = SDP_SVC_SEARCH_ATTR_RSP;
 		break;
 	/* Following requests are allowed only for local connections */
-	case SDP_SVC_REGISTER_REQ:
-		SDPDBG("Service register request");
-		if (req->local) {
-			status = service_register_req(req, &rsp);
-			rsphdr->pdu_id = SDP_SVC_REGISTER_RSP;
-		}
-		break;
 	case SDP_SVC_UPDATE_REQ:
 		SDPDBG("Service update request");
 		if (req->local) {
@@ -1011,13 +1004,6 @@ static void process_request(sdp_req_t *req)
 			rsphdr->pdu_id = SDP_SVC_UPDATE_RSP;
 		}
 		break;
-	case SDP_SVC_REMOVE_REQ:
-		SDPDBG("Service removal request");
-		if (req->local) {
-			status = service_remove_req(req, &rsp);
-			rsphdr->pdu_id = SDP_SVC_REMOVE_RSP;
-		}
-		break;
 	default:
 		error("Unknown PDU ID : 0x%x received", reqhdr->pdu_id);
 		status = SDP_INVALID_SYNTAX;
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 38bf808..09f6c0a 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -400,75 +400,6 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 }
 
 /*
- * Add the newly created service record to the service repository
- */
-int service_register_req(sdp_req_t *req, sdp_buf_t *rsp)
-{
-	int scanned = 0;
-	sdp_data_t *handle;
-	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
-	int bufsize = req->len - sizeof(sdp_pdu_hdr_t);
-	sdp_record_t *rec;
-
-	req->flags = *p++;
-	if (req->flags & SDP_DEVICE_RECORD) {
-		bacpy(&req->device, (bdaddr_t *) p);
-		p += sizeof(bdaddr_t);
-		bufsize -= sizeof(bdaddr_t);
-	}
-
-	/* save image of PDU: we need it when clients request this attribute */
-	rec = extract_pdu_server(&req->device, p, bufsize, 0xffffffff, &scanned);
-	if (!rec)
-		goto invalid;
-
-	if (rec->handle == 0xffffffff) {
-		rec->handle = sdp_next_handle();
-		if (rec->handle < 0x10000) {
-			sdp_record_free(rec);
-			goto invalid;
-		}
-	} else {
-		if (sdp_record_find(rec->handle)) {
-			/* extract_pdu_server will add the record handle
-			 * if it is missing. So instead of failing, skip
-			 * the record adding to avoid duplication. */
-			goto success;
-		}
-	}
-
-	sdp_record_add(&req->device, rec);
-	if (!(req->flags & SDP_RECORD_PERSIST))
-		sdp_svcdb_set_collectable(rec, req->sock);
-
-	handle = sdp_data_alloc(SDP_UINT32, &rec->handle);
-	sdp_attr_replace(rec, SDP_ATTR_RECORD_HANDLE, handle);
-
-success:
-	/* if the browse group descriptor is NULL,
-	 * ensure that the record belongs to the ROOT group */
-	if (sdp_data_get(rec, SDP_ATTR_BROWSE_GRP_LIST) == NULL) {
-		uuid_t uuid;
-		sdp_uuid16_create(&uuid, PUBLIC_BROWSE_GROUP);
-		sdp_pattern_add_uuid(rec, &uuid);
-	}
-
-	update_db_timestamp();
-
-	/* Build a rsp buffer */
-	bt_put_be32(rec->handle, rsp->data);
-	rsp->data_size = sizeof(uint32_t);
-
-	return 0;
-
-invalid:
-	bt_put_be16(SDP_INVALID_SYNTAX, rsp->data);
-	rsp->data_size = sizeof(uint16_t);
-
-	return -1;
-}
-
-/*
  * Update a service record
  */
 int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
@@ -509,34 +440,3 @@ done:
 	rsp->data_size = sizeof(uint16_t);
 	return status;
 }
-
-/*
- * Remove a registered service record
- */
-int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
-{
-	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = bt_get_be32(p);
-	sdp_record_t *rec;
-	int status = 0;
-
-	/* extract service record handle */
-
-	rec = sdp_record_find(handle);
-	if (rec) {
-		sdp_svcdb_collect(rec);
-		status = sdp_record_remove(handle);
-		sdp_record_free(rec);
-		if (status == 0)
-			update_db_timestamp();
-	} else {
-		status = SDP_INVALID_RECORD_HANDLE;
-		SDPDBG("Could not find record : 0x%x", handle);
-	}
-
-	p = rsp->data;
-	bt_put_be16(status, p);
-	rsp->data_size = sizeof(uint16_t);
-
-	return status;
-}
diff --git a/src/sdpd.h b/src/sdpd.h
index 6de0af7..3c6ee01 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -50,9 +50,7 @@ void handle_request(int sk, uint8_t *data, int len);
 
 void set_fixed_db_timestamp(uint32_t dbts);
 
-int service_register_req(sdp_req_t *req, sdp_buf_t *rsp);
 int service_update_req(sdp_req_t *req, sdp_buf_t *rsp);
-int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp);
 
 void register_public_browse_group(void);
 void register_server_service(void);
-- 
1.8.4

