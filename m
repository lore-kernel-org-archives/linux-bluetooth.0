Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA6EC636CD
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Feb 2023 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBEQrd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Feb 2023 11:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBEQrd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Feb 2023 11:47:33 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8768A12F2F
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 08:47:31 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D94982400CD
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 17:47:29 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4P8wKs070hz6tmK;
        Sun,  5 Feb 2023 17:47:28 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix crash unregistering media endpoint while streaming
Date:   Sun,  5 Feb 2023 16:47:26 +0000
Message-Id: <7fb15c0b34a29d0b85568ce8dcc9969771f498c0.1675615318.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following ASAN crash is observed when media endpoint is unregistered
(stopping sound server) while streaming from remote BAP client:

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

When stream->client is false, bt_bap_stream_release already sets the
stream to idle and frees it.

Fix the crash by not setting the state to idle for the second time,
in this case.
---

Notes:
    Crash seen when testing BlueZ at commit 67395a3b357d.

 src/shared/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 22f2e6714..812fba4c8 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2479,8 +2479,11 @@ static void remove_streams(void *data, void *user_data)
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
 	if (stream) {
+		bool client = stream->client;
+
 		bt_bap_stream_release(stream, NULL, NULL);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		if (client)
+			stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
 	}
 }
 
-- 
2.39.1

