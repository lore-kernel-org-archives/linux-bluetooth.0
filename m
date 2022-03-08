Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88DEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Mar 2022 09:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbiCHJou (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiCHJou (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Mar 2022 04:44:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7B827FE7
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Mar 2022 01:43:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d61f6c1877so155677027b3.15
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Mar 2022 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=swLthqUUPb6xo/EMJu8ReUPFOgroqtqP+uFPnA7Nza0=;
        b=c7B5wkDC0c7tKrV2zDDYS3qgKRD24R1s/zZcG/kUge6S38lDxwblH2p5s+GexlpzGX
         7t6fV6KRi2pW29Rjw/kCVkj3FN/G1iPTCecxK8RioIQ5pt4y+ZsTKX3B4l0PfYLS6/ux
         UQPuwkvNkHdITx0dmKIJQhY7dYxrJ/QtDHMWVWPTefSOJUKCFHbwxANIgK74y54nvusk
         pUvP6gqwewbMR+gBRsEW+Oj9B/lWnIgsaN/3kFJ7ZXakqrW+vcXeshnLhQdHDnSOu7Rt
         Lxmfr7XOYcX/5lqvzRm/OPp2ntvsKiu79n7wN7vth9+j3jwN4ESgirugTgkxlND60iTx
         mMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=swLthqUUPb6xo/EMJu8ReUPFOgroqtqP+uFPnA7Nza0=;
        b=IrqbOiJ9pTgGVBNxx5xeO2JCBsbZxd1++/rNmM6nyQSlrg8PgzD1hcBqzTThjV79JT
         dRVVIsr+XUD89nZv9WF8qzcr96eWnSQnGkZ8CV6RPGvHfb69jck1s9hXwr1azaMbR7Ru
         rpuCiVlCtFnwD/PgKQF4ZsMDYoYKPVYLeRgqbtZNWxeBTnE3iAg4qLys57z3AJFsp1Xp
         iQXw6KvtoF9Bqi58joa/jSKQTkDJl9niZJNKibOGGcof3dQKHXDjzqVKEjqzvTg4GgAh
         X+0Lk2U2gyS14c4w+OlXxEKCaamTVNiZA9+oYEoAQXDePQuBwp0Ba6+gW0IQjZcRE2HR
         hq8A==
X-Gm-Message-State: AOAM5302L/FLKQktx66WhGD4LPbLKEakk89vLkyNcU5hjjWd9H6yc1Sl
        eyi5r2rEAb2wWHhKP7EMJdHeFZJjIllsrOAYKj9Q0tqL70j2ExGTQn11cxjAsNdnbjxqXmUzvh/
        5LyOmFbJ7Z7c/OrzuNTpIho1Z9qurLPgbh974PRlmDjxBAYPzzKQgSVGulQhcbZ5jiAQEXlz8R9
        XXYUd5gd6K9oc=
X-Google-Smtp-Source: ABdhPJwNWeoN5pAttjqFhzmQP07z/KU6fMg4vyXK8AsF6Q0Xy9oL85ZZ0fNeHoWgIE2S5LltMYgG+aFqPBCKja85Dw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:57d8:a2f4:6afe:d442])
 (user=howardchung job=sendgmr) by 2002:a81:2555:0:b0:2d0:dc91:5a1c with SMTP
 id l82-20020a812555000000b002d0dc915a1cmr12129022ywl.200.1646732633407; Tue,
 08 Mar 2022 01:43:53 -0800 (PST)
Date:   Tue,  8 Mar 2022 17:43:48 +0800
Message-Id: <20220308174253.Bluez.v2.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [Bluez PATCH v2] audio: fix crash in a2dp_discover
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Sample stack trace:
0x0000567c394e4c6b (bluetoothd - a2dp.c: 270) setup_cb_free
0x0000567c394e4a94 (bluetoothd - a2dp.c: 2884) a2dp_discover
0x0000567c394e3c03 (bluetoothd - sink.c: 275) sink_setup_stream
0x0000567c394e3d4f (bluetoothd - sink.c: 299) sink_connect
0x0000567c39535183 (bluetoothd - service.c: 294) btd_service_connect
0x0000567c39539f68 (bluetoothd - device.c: 2006) connect_next
0x0000567c3954086d (bluetoothd - device.c: 2060) service_state_changed
0x0000567c39534efb (bluetoothd - service.c: 111) change_state
0x0000567c3953559c (bluetoothd - service.c: 0)
btd_service_connecting_complete
0x0000567c39534a5c (bluetoothd - profile.c: 1641) record_cb
0x0000567c395197cd (bluetoothd - sdp-client.c: 298) connect_watch
0x00007b14bc8034f6 (libglib-2.0.so.0 - gmain.c: 3337)
g_main_context_dispatch
0x00007b14bc803801 (libglib-2.0.so.0 - gmain.c: 4131)
g_main_context_iterate
0x00007b14bc803a7d (libglib-2.0.so.0 - gmain.c: 4329) g_main_loop_run
0x0000567c39566af1 (bluetoothd - mainloop-glib.c: 79) mainloop_run
0x0000567c39566ddb (bluetoothd - mainloop-notify.c: 201)
mainloop_run_with_signal
0x0000567c3954bf4c (bluetoothd - main.c: 1222) main
0x00007b14bc579797 (libc.so.6 - libc-start.c: 332) __libc_start_main
0x0000567c394df449 (bluetoothd) _start
0x00007ffd70145737

This could be triggered from a2dp_discover -> avdtp_discover ->
send_request -> send_req -> l2cap_connect (return error) ->
avdtp_set_state (to disconnect state)-> channel_remove -> channel_free
-> finalize_setup_errno (discover cb is freed) -> error handling all
the way back to a2dp_discover -> a2dp_discover (discover cb is freed
again, crashed!).

The fix is to attach cb with setup after avdtp_discover success.

Suggested-by: luiz.dentz@gmail.com

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
Hi maintainers,

The fix is tested by forcing session->io to NULL in send_req in the code
and verifing the crash doesn't happen.

Changes in v2:
- adopted luiz's solution

 profiles/audio/a2dp.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 9fbcd35f7..f761dbe54 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -244,6 +244,15 @@ static struct a2dp_setup_cb *setup_cb_new(struct a2dp_setup *setup)
 	cb->setup = setup;
 	cb->id = ++cb_id;
 
+	return cb;
+}
+
+static struct a2dp_setup_cb *setup_cb_add(struct a2dp_setup *setup)
+{
+	struct a2dp_setup_cb *cb;
+
+	cb = setup_cb_new(setup);
+
 	setup->cb = g_slist_append(setup->cb, cb);
 	return cb;
 }
@@ -1840,7 +1849,7 @@ static int a2dp_reconfig(struct a2dp_channel *chan, const char *sender,
 	if (!setup)
 		return -ENOMEM;
 
-	cb_data = setup_cb_new(setup);
+	cb_data = setup_cb_add(setup);
 	cb_data->config_cb = reconfig_cb;
 	cb_data->user_data = user_data;
 
@@ -2878,12 +2887,17 @@ unsigned int a2dp_discover(struct avdtp *session, a2dp_discover_cb_t cb,
 	if (!setup)
 		return 0;
 
+	/* Don't add cb since avdtp_discover can end up disconnecting the
+	 * session causing the cb to be freed.
+	 */
 	cb_data = setup_cb_new(setup);
 	cb_data->discover_cb = cb;
 	cb_data->user_data = user_data;
 
-	if (avdtp_discover(session, discover_cb, setup) == 0)
+	if (avdtp_discover(session, discover_cb, setup) == 0) {
+		setup->cb = g_slist_append(setup->cb, cb_data);
 		return cb_data->id;
+	}
 
 	setup_cb_free(cb_data);
 	return 0;
@@ -2911,7 +2925,7 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	if (!setup)
 		return 0;
 
-	cb_data = setup_cb_new(setup);
+	cb_data = setup_cb_add(setup);
 	cb_data->select_cb = cb;
 	cb_data->user_data = user_data;
 
@@ -2984,7 +2998,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	if (!setup)
 		return 0;
 
-	cb_data = setup_cb_new(setup);
+	cb_data = setup_cb_add(setup);
 	cb_data->config_cb = cb;
 	cb_data->user_data = user_data;
 
@@ -3075,7 +3089,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 	if (!setup)
 		return 0;
 
-	cb_data = setup_cb_new(setup);
+	cb_data = setup_cb_add(setup);
 	cb_data->resume_cb = cb;
 	cb_data->user_data = user_data;
 
@@ -3133,7 +3147,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 	if (!setup)
 		return 0;
 
-	cb_data = setup_cb_new(setup);
+	cb_data = setup_cb_add(setup);
 	cb_data->suspend_cb = cb;
 	cb_data->user_data = user_data;
 
-- 
2.35.1.616.g0bdcbb4464-goog

