Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] sdp: Fix Out-of-bounds heap read in service_search_attr_req function
Date: Wed, 13 Sep 2017 10:01:40 +0300
Message-Id: <20170913070140.12576-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check if there is enough data to continue otherwise return an error.
---
 src/sdpd-request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sdpd-request.c b/src/sdpd-request.c
index 1eefdce1a..318d04467 100644
--- a/src/sdpd-request.c
+++ b/src/sdpd-request.c
@@ -917,7 +917,7 @@ static int service_search_attr_req(sdp_req_t *req, sdp_buf_t *buf)
 	} else {
 		/* continuation State exists -> get from cache */
 		sdp_buf_t *pCache = sdp_get_cached_rsp(cstate);
-		if (pCache) {
+		if (pCache && cstate->cStateValue.maxBytesSent < pCache->data_size) {
 			uint16_t sent = MIN(max, pCache->data_size - cstate->cStateValue.maxBytesSent);
 			pResponse = pCache->data;
 			memcpy(buf->data, pResponse + cstate->cStateValue.maxBytesSent, sent);
-- 
2.13.5

