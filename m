Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/5] core: Opencode get_sdp_session in sdp-client
Date: Mon, 20 Jan 2014 01:31:51 +0100
Message-Id: <1390177914-13529-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
References: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is only used once and provides no benefit compared to opencoding.
---
 src/sdp-client.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/src/sdp-client.c b/src/sdp-client.c
index 51f3048..0599626 100644
--- a/src/sdp-client.c
+++ b/src/sdp-client.c
@@ -86,17 +86,6 @@ static sdp_session_t *get_cached_sdp_session(const bdaddr_t *src, const bdaddr_t
 	return NULL;
 }
 
-static sdp_session_t *get_sdp_session(const bdaddr_t *src, const bdaddr_t *dst)
-{
-	sdp_session_t *session;
-
-	session = get_cached_sdp_session(src, dst);
-	if (session)
-		return session;
-
-	return sdp_connect(src, dst, SDP_NON_BLOCKING);
-}
-
 static void cache_sdp_session(bdaddr_t *src, bdaddr_t *dst,
 						sdp_session_t *session)
 {
@@ -285,7 +274,10 @@ static int create_search_context(struct search_context **ctxt,
 	if (!ctxt)
 		return -EINVAL;
 
-	s = get_sdp_session(src, dst);
+	s = get_cached_sdp_session(src, dst);
+	if (!s)
+		s = sdp_connect(src, dst, SDP_NON_BLOCKING);
+
 	if (!s)
 		return -errno;
 
-- 
1.8.5.3

