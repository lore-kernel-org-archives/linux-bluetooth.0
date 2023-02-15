Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B407C636D6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Feb 2023 22:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBOW0K (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBOW0J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 17:26:09 -0500
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DC3864F
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 14:26:06 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 2B5A82403B8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 23:26:05 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PHCMw4Wxyz9rxG;
        Wed, 15 Feb 2023 23:26:04 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/3] media: fix ASAN crash in pac_config_cb
Date:   Wed, 15 Feb 2023 22:26:02 +0000
Message-Id: <be8d0573d2fb7f326439c79e4bc07b7bb30cc9f7.1676499415.git.pav@iki.fi>
In-Reply-To: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
References: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Don't call configuration callback if stream's transport was cleared in
the meantime.  The clear callback is called just before the stream is
freed.

Fixes ASAN crash on disconnect while waiting for SetConfiguration DBus
reply:

ERROR: AddressSanitizer: heap-use-after-free on address 0x60b00002eb90
READ of size 8 at 0x60b00002eb90 thread T0
    #0 0x7a4892 in bap_stream_config_cfm_cb src/shared/bap.c:3201
    #1 0x4688fb in pac_config_cb profiles/audio/media.c:1010
    #2 0x462164 in media_endpoint_cancel profiles/audio/media.c:157
    #3 0x462243 in media_endpoint_cancel_all profiles/audio/media.c:165
    #4 0x46365b in clear_endpoint profiles/audio/media.c:297
    #5 0x463a21 in endpoint_reply profiles/audio/media.c:325
...
freed by thread T0 here:
    #0 0x7eff644b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
    #1 0x78d8cc in bap_stream_free src/shared/bap.c:974
    #2 0x78dbc8 in bap_stream_detach src/shared/bap.c:991
    #3 0x78fa43 in bap_stream_state_changed src/shared/bap.c:1210
    #4 0x78fe26 in stream_set_state src/shared/bap.c:1254
    #5 0x7ab5ce in stream_foreach_detach src/shared/bap.c:3820
    #6 0x70ce06 in queue_foreach src/shared/queue.c:207
    #7 0x7ab942 in bt_bap_detach src/shared/bap.c:3836
    #8 0x51da7a in bap_disconnect profiles/audio/bap.c:1342
    #9 0x626e57 in btd_service_disconnect src/service.c:305
---

Notes:
    Reproducer:
    
    Make sound server delay its SetConfiguration response, and disconnect
    device before DBus timeout is reached.

 profiles/audio/media.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index b722278ba..326e50a09 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1003,6 +1003,12 @@ static void pac_config_cb(struct media_endpoint *endpoint, void *ret, int size,
 {
 	struct pac_config_data *data = user_data;
 	gboolean *ret_value = ret;
+	struct media_transport *transport;
+
+	/* If transport was cleared, configuration was cancelled */
+	transport = find_transport(endpoint, data->stream);
+	if (!transport)
+		return;
 
 	data->cb(data->stream, ret_value ? 0 : -EINVAL);
 }
-- 
2.39.1

