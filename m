Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 05/22] Replace bt_put_be32() by put_be32()
Date: Mon, 24 Mar 2014 16:25:26 -0300
Message-Id: <1395689143-11091-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/avrcp-lib.c    | 6 +++---
 android/avrcp.c        | 2 +-
 profiles/audio/avrcp.c | 4 ++--
 src/sdpd-request.c     | 4 ++--
 src/sdpd-service.c     | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 5e9bb1a..c7b8b6a 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -713,7 +713,7 @@ int avrcp_register_notification(struct avrcp *session, uint8_t event,
 	uint8_t params[5];
 
 	params[0] = event;
-	bt_put_be32(interval, &params[1]);
+	put_be32(interval, &params[1]);
 
 	return avrcp_send_req(session, AVC_CTYPE_NOTIFY, AVC_SUBUNIT_PANEL,
 					AVRCP_REGISTER_NOTIFICATION,
@@ -915,8 +915,8 @@ int avrcp_get_play_status_rsp(struct avrcp *session, uint8_t transaction,
 {
 	uint8_t pdu[9];
 
-	bt_put_be32(position, &pdu[0]);
-	bt_put_be32(duration, &pdu[4]);
+	put_be32(position, &pdu[0]);
+	put_be32(duration, &pdu[4]);
 	pdu[8] = status;
 
 	return avrcp_send(session, transaction, AVC_CTYPE_STABLE,
diff --git a/android/avrcp.c b/android/avrcp.c
index 4f7163d..ec98139 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -180,7 +180,7 @@ static size_t write_element_text(uint8_t id, uint8_t text_len, uint8_t *text,
 	uint16_t charset = 106;
 	size_t len = 0;
 
-	bt_put_be32(id, pdu);
+	put_be32(id, pdu);
 	pdu += 4;
 	len += 4;
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 913d2be..1d439ec 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2283,8 +2283,8 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 
 	pdu->params[0] = player->scope;
 
-	bt_put_be32(start, &pdu->params[1]);
-	bt_put_be32(end, &pdu->params[5]);
+	put_be32(start, &pdu->params[1]);
+	put_be32(end, &pdu->params[5]);
 
 	pdu->params[9] = 1;
 
diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 600237a..3e58c22 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -212,7 +212,7 @@ static int extract_des(uint8_t *buf, int len, sdp_list_t **svcReqSeq, uint8_t *p
 				memcpy(&tmp, p, sizeof(tmp));
 
 				pElem = malloc(sizeof(uint32_t));
-				bt_put_be32(tmp, pElem);
+				put_be32(tmp, pElem);
 			}
 			p += sizeof(uint32_t);
 			seqlen += sizeof(uint32_t);
@@ -442,7 +442,7 @@ static int service_search_req(sdp_req_t *req, sdp_buf_t *buf)
 			if (sdp_match_uuid(pattern, rec->pattern) > 0 &&
 					sdp_check_access(rec->handle, &req->device)) {
 				rsp_count++;
-				bt_put_be32(rec->handle, pdata);
+				put_be32(rec->handle, pdata);
 				pdata += sizeof(uint32_t);
 				handleSize += sizeof(uint32_t);
 			}
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index e001c30..a90b299 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -457,7 +457,7 @@ success:
 	update_db_timestamp();
 
 	/* Build a rsp buffer */
-	bt_put_be32(rec->handle, rsp->data);
+	put_be32(rec->handle, rsp->data);
 	rsp->data_size = sizeof(uint32_t);
 
 	return 0;
-- 
1.8.3.1

