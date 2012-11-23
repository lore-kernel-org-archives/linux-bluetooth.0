Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] sdp: Fix build errors due to unaligned memory access
Date: Fri, 23 Nov 2012 11:09:12 +0100
Message-ID: <1353665354-32178-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
References: <1353665354-32178-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following compilation errors on ARM.

  CC     lib/sdp.lo
lib/sdp.c: In function 'sdp_device_record_unregister_binary':
lib/sdp.c:2984:11: error: cast increases required alignment of
	target type [-Werror=cast-align]
lib/sdp.c:2984:11: error: cast increases required alignment of
	target type [-Werror=cast-align]
lib/sdp.c: In function 'sdp_device_record_update':
lib/sdp.c:3089:11: error: cast increases required alignment of
	target type [-Werror=cast-align]
lib/sdp.c:3089:11: error: cast increases required alignment of
	target type [-Werror=cast-align]
lib/sdp.c: In function 'sdp_process':
lib/sdp.c:4139:22: error: cast increases required alignment of
	target type [-Werror=cast-align]
lib/sdp.c:4146:14: error: cast increases required alignment of
	target type [-Werror=cast-align]
lib/sdp.c:4146:14: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [lib/sdp.lo] Error 1
---
 lib/sdp.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index ceb1192..4e070b5 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -2981,7 +2981,6 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* For this case the status always is invalid record handle */
@@ -2990,6 +2989,12 @@ int sdp_device_record_unregister_binary(sdp_session_t *session, bdaddr_t *device
 	} else if (rsphdr->pdu_id != SDP_SVC_REMOVE_RSP) {
 		errno = EPROTO;
 		status = -1;
+	} else {
+		uint16_t tmp;
+
+		memcpy(&tmp, p, sizeof(tmp));
+
+		status = tmp;
 	}
 end:
 	free(reqbuf);
@@ -3086,7 +3091,6 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 
 	rsphdr = (sdp_pdu_hdr_t *) rspbuf;
 	p = rspbuf + sizeof(sdp_pdu_hdr_t);
-	status = bt_get_unaligned((uint16_t *) p);
 
 	if (rsphdr->pdu_id == SDP_ERROR_RSP) {
 		/* The status can be invalid sintax or invalid record handle */
@@ -3095,6 +3099,12 @@ int sdp_device_record_update(sdp_session_t *session, bdaddr_t *device, const sdp
 	} else if (rsphdr->pdu_id != SDP_SVC_UPDATE_RSP) {
 		errno = EPROTO;
 		status = -1;
+	} else {
+		uint16_t tmp;
+
+		memcpy(&tmp, p, sizeof(tmp));
+
+		status = tmp;
 	}
 end:
 	free(reqbuf);
@@ -4136,14 +4146,18 @@ int sdp_process(sdp_session_t *session)
 			rsp_count = sizeof(tsrc) + sizeof(csrc) + csrc * 4;
 		} else {
 			/* point to the first csrc */
-			uint16_t *pcsrc = (uint16_t *) (t->rsp_concat_buf.data + 2);
+			uint8_t *pcsrc = t->rsp_concat_buf.data + 2;
+			uint16_t tcsrc, tcsrc2;
 
 			/* FIXME: update the interface later. csrc doesn't need be passed to clients */
 
 			pdata += sizeof(uint16_t); /* point to csrc */
 
 			/* the first csrc contains the sum of partial csrc responses */
-			*pcsrc += bt_get_unaligned((uint16_t *) pdata);
+			memcpy(&tcsrc, pcsrc, sizeof(tcsrc));
+			memcpy(&tcsrc2, pdata, sizeof(tcsrc2));
+			tcsrc += tcsrc2;
+			memcpy(pcsrc, &tcsrc, sizeof(tcsrc));
 
 			pdata += sizeof(uint16_t); /* point to the first handle */
 			rsp_count = csrc * 4;
-- 
1.7.9.5

