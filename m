Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96847C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Mar 2022 06:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiCGGHH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Mar 2022 01:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiCGGHG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Mar 2022 01:07:06 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD675F4C1
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Mar 2022 22:06:11 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dbfe49a4aaso124871117b3.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Mar 2022 22:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mZ2+/749yEomNHYS2IrCoidt/fbzFL4sKPvli6dKG0U=;
        b=OJHabYKdEAksvM95eEef4t0d88Vy2yNZ/PrbEqKySKhCXbkYmohSSzGkw02Z06NGTc
         fObq3dOb7KRxyQiEDwWn3NzeCVJs+fZq/NNMsHbixjg+h5QuhK0IhMHCLp80+uMGZ/2C
         1ISqvbaV14eOyczTwnqIdENVWEZu3tA/zI9+6vIcnqoumh3LSrPg3JP9Z/ZHkBionfxI
         wPqhYaKTwf+4YuKpbSw91hBsxhzdmtQCjE7yy8epvak6sW+dvinaQhioQgPVFKUv9hKR
         Gteyw2RS/Q3mu/Wy1M7kSePv8c5/iI+3bkKaZGqzQKHUDE87vu1lFiZ+x7pUzg8Uc6BV
         K3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mZ2+/749yEomNHYS2IrCoidt/fbzFL4sKPvli6dKG0U=;
        b=2BwrTDchiActPrNTqNmmmCY8woEN/vjtRLx5bvqowjqC0b+8e1c2DuTRz3j0fBMLOd
         CUnQW28/YzjxWfQSk6DxfrgO8ZW4N9W0LTQIHH9EJ8SucQf6shufezAqyZqkOR2jZrad
         ZuhDh+r1fT9tQ2V0BTHKhP65Hz8JYYC/ace/qrRcpxJbBl3YR3BhuPigmH1KXfSU+KRJ
         xhszvBbEVBwf1TclAbF/eDLzC0FU5JtVWFU0HrFS9PmV5xmCFm0A07XyZ6fVSyy3di/q
         bePxajQyOebsCRJ2ffGm40meOgVbeEhzhSmM2LLW3cEKWAz0qY7ksrfbFPL1iXB35iky
         7aag==
X-Gm-Message-State: AOAM533lt1FTDvaxrBJ0MSGHm21EePsH4zaIA2Difh8jHFM4pi1stM/d
        hXmMVjqk/yV8zmH/515F89/+MbIeyDzzj/Dovx1p5W9ygfGVqc3Yq/npxouiwXe5YJHX9tWwxM3
        iQ8+WM9YbjyHl2biUsSqf1owojj42z0QWfmO21eGXSXufuFxyASbWBG8wGCMpF2w3yuvWLhQS+m
        K+uxfB0WtIEfI=
X-Google-Smtp-Source: ABdhPJw8DoUX33I8301iwT9NkVq9qN/T9XgoStb8b03XJfH2IvJSUm8lPcJjGGwQtObmLF1jQSrj83grzGe6R/ISEA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:50e2:ac45:9667:bfb9])
 (user=howardchung job=sendgmr) by 2002:a25:a541:0:b0:628:75d5:1982 with SMTP
 id h59-20020a25a541000000b0062875d51982mr7018126ybi.520.1646633170549; Sun,
 06 Mar 2022 22:06:10 -0800 (PST)
Date:   Mon,  7 Mar 2022 14:05:59 +0800
Message-Id: <20220307140437.Bluez.v1.1.Ieb7448d3d951876e1f412452fcfd27cdc7bd015b@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [Bluez PATCH v1] audio: fix crash in a2dp_discover
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

The fix is to add setup_ref/setup_unref around a2dp_discover to ensure
setup alive, and check if setup->chan to see if channel_free has been
called or not.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
Hi maintainers,

The fix is tested by forcing session->io to NULL in send_req in the code
and verifing the crash doesn't happen.

 profiles/audio/a2dp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 9fbcd35f7..39e1e9624 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2878,14 +2878,22 @@ unsigned int a2dp_discover(struct avdtp *session, a2dp_discover_cb_t cb,
 	if (!setup)
 		return 0;
 
+	setup_ref(setup);
 	cb_data = setup_cb_new(setup);
 	cb_data->discover_cb = cb;
 	cb_data->user_data = user_data;
 
-	if (avdtp_discover(session, discover_cb, setup) == 0)
+	if (avdtp_discover(session, discover_cb, setup) == 0) {
+		setup_unref(setup);
 		return cb_data->id;
+	}
 
-	setup_cb_free(cb_data);
+	/* Check if the channel is still there before freeing setup_cb, since it
+	 * could be freed by channel_free().
+	 */
+	if (setup->chan)
+		setup_cb_free(cb_data);
+	setup_unref(setup);
 	return 0;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

