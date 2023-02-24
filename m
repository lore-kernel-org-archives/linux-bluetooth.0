Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D2FC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 18:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBXSJw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 13:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBXSJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 13:09:52 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF50D1516B
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 10:09:50 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 1568C240304
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Feb 2023 19:09:49 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PNdG43NzRz9rxG;
        Fri, 24 Feb 2023 19:09:48 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] shared/bap: fix crash unregistering media endpoint while streaming
Date:   Fri, 24 Feb 2023 18:09:46 +0000
Message-Id: <fe1bf6efbd6bdfc8507e13559bb3852b23446f2f.1677261870.git.pav@iki.fi>
In-Reply-To: <CABBYNZLahb=_9BEP37wod71LVMHOPDY7RrMkj3fHJhwjPcD4tA@mail.gmail.com>
References: <CABBYNZLahb=_9BEP37wod71LVMHOPDY7RrMkj3fHJhwjPcD4tA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Always free BAP stream in bt_bap_stream_release if it is not attached to
a client session, simplifying the cleanup.

Fixes the following ASAN crash is observed when media endpoint is
unregistered (stopping sound server) while streaming from remote BAP
client:

ERROR: AddressSanitizer: heap-use-after-free on address 0x60b0000474d8
READ of size 8 at 0x60b0000474d8 thread T0
    #0 0x7a27c6 in stream_set_state src/shared/bap.c:1227
    #1 0x7aff61 in remove_streams src/shared/bap.c:2483
    #2 0x71d2d0 in queue_foreach src/shared/queue.c:207
    #3 0x7b0152 in bt_bap_remove_pac src/shared/bap.c:2501
    #4 0x463cda in media_endpoint_destroy profiles/audio/media.c:179
    ...
0x60b0000474d8 is located 8 bytes inside of 112-byte region
freed by thread T0 here:
    #0 0x7f93b12b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
    #1 0x7a0504 in bap_stream_free src/shared/bap.c:972
    #2 0x7a0800 in bap_stream_detach src/shared/bap.c:989
    #3 0x7a26d1 in bap_stream_state_changed src/shared/bap.c:1208
    #4 0x7a2ab4 in stream_set_state src/shared/bap.c:1252
    #5 0x7ab18a in stream_release src/shared/bap.c:1985
    #6 0x7c6919 in bt_bap_stream_release src/shared/bap.c:4572
    #7 0x7aff50 in remove_streams src/shared/bap.c:2482
    ...
previously allocated by thread T0 here:
    #0 0x7f93b12ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
    #1 0x71e9ae in util_malloc src/shared/util.c:43
    #2 0x79c2f5 in bap_stream_new src/shared/bap.c:766
    #3 0x7a4863 in ep_config src/shared/bap.c:1446
    #4 0x7a4f22 in ascs_config src/shared/bap.c:1481
    ...
---

Notes:
    v2: move cleanup inside bt_bap_stream_release
    
    Following the suggestion, maybe like this then?
    
    The rule then is that bt_bap_stream_free frees the stream if it does not
    belong to a client session.
    
    The dangling stream pointer should not be put into req.

 src/shared/bap.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f16ba1832..41b39f868 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2479,10 +2479,8 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream) {
+	if (stream)
 		bt_bap_stream_release(stream, NULL, NULL);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-	}
 }
 
 bool bt_bap_remove_pac(struct bt_bap_pac *pac)
@@ -4567,6 +4565,7 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 	struct iovec iov;
 	struct bt_ascs_release rel;
 	struct bt_bap_req *req;
+	struct bt_bap *bap;
 
 	if (!stream)
 		return 0;
@@ -4583,9 +4582,17 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 	iov.iov_base = &rel;
 	iov.iov_len = sizeof(rel);
 
+	bap = stream->bap;
+
+	/* If stream does not belong to a client session, clean it up now */
+	if (!bap_stream_valid(stream)) {
+		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		stream = NULL;
+	}
+
 	req = bap_req_new(stream, BT_ASCS_RELEASE, &iov, 1, func, user_data);
 
-	if (!bap_queue_req(stream->bap, req)) {
+	if (!bap_queue_req(bap, req)) {
 		bap_req_free(req);
 		return 0;
 	}
-- 
2.39.2

