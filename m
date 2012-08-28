Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Fix error reporting in sdp_service_search_attr_req
Date: Tue, 28 Aug 2012 15:33:16 +0200
Message-ID: <1346160796-23277-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346160796-23277-1-git-send-email-szymon.janc@tieto.com>
References: <1346160796-23277-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function reports error code via errno not return value.

---
 lib/sdp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 9807c8d..36b4d08 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4346,7 +4346,8 @@ int sdp_service_search_attr_req(sdp_session_t *session, const sdp_list_t *search
 	seqlen = gen_attridseq_pdu(pdata, attrids,
 		reqtype == SDP_ATTR_REQ_INDIVIDUAL ? SDP_UINT16 : SDP_UINT32);
 	if (seqlen == -1) {
-		status = EINVAL;
+		errno = EINVAL;
+		status = -1;
 		goto end;
 	}
 	pdata += seqlen;
-- 
1.7.9.5

