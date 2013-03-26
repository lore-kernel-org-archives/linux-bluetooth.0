Return-Path: <cyrus@holtmann.org>
From: Arek Lichwa <arkadiusz.lichwa@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Arkadiusz Lichwa <arkadiusz.lichwa@tieto.com>
Subject: [PATCH] sdptool: Fix mem leak in do_search
Date: Tue, 26 Mar 2013 12:31:08 +0100
Message-ID: <1364297468-2769-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Arkadiusz Lichwa <arkadiusz.lichwa@tieto.com>

---
 tools/sdptool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 0a949f2..eb09f65 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3781,6 +3781,8 @@ static int do_search(bdaddr_t *bdaddr, struct search_context *context)
 	search = sdp_list_append(0, &context->group);
 	if (sdp_service_search_attr_req(sess, search, SDP_ATTR_REQ_RANGE, attrid, &seq)) {
 		printf("Service Search failed: %s\n", strerror(errno));
+		sdp_list_free(attrid, 0);
+		sdp_list_free(search, 0);
 		sdp_close(sess);
 		return -1;
 	}
-- 
1.7.12

