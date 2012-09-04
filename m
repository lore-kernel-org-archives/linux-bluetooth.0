Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 10/18] sdpd-service: Fix build errors due to unaligned memory access
Date: Tue, 4 Sep 2012 16:41:29 +0200
Message-ID: <1346769697-9930-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
References: <1346769697-9930-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix number of build errors on ARM similar to one below.

  CC     src/bluetooth-sdpd-service.o
src/sdpd-service.c: In function service_remove_req:
src/sdpd-service.c:517:20: error: cast increases required alignment of
	target type [-Werror=cast-align]
src/sdpd-service.c:517:20: error: cast increases required alignment of
	target type [-Werror=cast-align]
src/sdpd-service.c:536:2: error: cast increases required alignment of
	target type [-Werror=cast-align]
src/sdpd-service.c:536:2: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors

---
 src/sdpd-service.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 39e05ab..b43ddc2 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -317,7 +317,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 		return NULL;
 	}
 
-	lookAheadAttrId = ntohs(bt_get_unaligned((uint16_t *) (p + sizeof(uint8_t))));
+	lookAheadAttrId = bt_get_be16(p + sizeof(uint8_t));
 
 	SDPDBG("Look ahead attr id : %d", lookAheadAttrId);
 
@@ -327,9 +327,8 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 			SDPDBG("Unexpected end of packet");
 			return NULL;
 		}
-		handle = ntohl(bt_get_unaligned((uint32_t *) (p +
-				sizeof(uint8_t) + sizeof(uint16_t) +
-				sizeof(uint8_t))));
+		handle = bt_get_be32(p + sizeof(uint8_t) + sizeof(uint16_t) +
+							sizeof(uint8_t));
 		SDPDBG("SvcRecHandle : 0x%x", handle);
 		rec = sdp_record_find(handle);
 	} else if (handleExpected != 0xffffffff)
@@ -363,7 +362,7 @@ static sdp_record_t *extract_pdu_server(bdaddr_t *device, uint8_t *p,
 							seqlen, localExtractedLength);
 		dtd = *(uint8_t *) p;
 
-		attrId = ntohs(bt_get_unaligned((uint16_t *) (p + attrSize)));
+		attrId = bt_get_be16(p + attrSize);
 		attrSize += sizeof(uint16_t);
 
 		SDPDBG("DTD of attrId : %d Attr id : 0x%x", dtd, attrId);
@@ -454,13 +453,13 @@ success:
 	update_db_timestamp();
 
 	/* Build a rsp buffer */
-	bt_put_unaligned(htonl(rec->handle), (uint32_t *) rsp->data);
+	bt_put_be32(rec->handle, rsp->data);
 	rsp->data_size = sizeof(uint32_t);
 
 	return 0;
 
 invalid:
-	bt_put_unaligned(htons(SDP_INVALID_SYNTAX), (uint16_t *) rsp->data);
+	bt_put_be16(SDP_INVALID_SYNTAX, rsp->data);
 	rsp->data_size = sizeof(uint16_t);
 
 	return -1;
@@ -475,7 +474,7 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
 	int status = 0, scanned = 0;
 	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
 	int bufsize = req->len - sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = ntohl(bt_get_unaligned((uint32_t *) p));
+	uint32_t handle = bt_get_be32(p);
 
 	SDPDBG("Svc Rec Handle: 0x%x", handle);
 
@@ -503,7 +502,7 @@ int service_update_req(sdp_req_t *req, sdp_buf_t *rsp)
 
 done:
 	p = rsp->data;
-	bt_put_unaligned(htons(status), (uint16_t *) p);
+	bt_put_be16(status, p);
 	rsp->data_size = sizeof(uint16_t);
 	return status;
 }
@@ -514,7 +513,7 @@ done:
 int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
 {
 	uint8_t *p = req->buf + sizeof(sdp_pdu_hdr_t);
-	uint32_t handle = ntohl(bt_get_unaligned((uint32_t *) p));
+	uint32_t handle = bt_get_be32(p);
 	sdp_record_t *rec;
 	int status = 0;
 
@@ -533,7 +532,7 @@ int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp)
 	}
 
 	p = rsp->data;
-	bt_put_unaligned(htons(status), (uint16_t *) p);
+	bt_put_be16(status, p);
 	rsp->data_size = sizeof(uint16_t);
 
 	return status;
-- 
1.7.9.5

