Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F9AC07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 03:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916E86109E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 03:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhGMDyU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 23:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhGMDyT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 23:54:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FD5C0613DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 20:51:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s14-20020ad4438e0000b02902c3cd066c0bso15645654qvr.18
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 20:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NF8ew4zOk2PYVgNlMZv8NebJXnACj3J4jLRW8j5wcyY=;
        b=bmGK99hqML7p6QwK4Xb7/mdld2iugGnqBM4eUbGqtNZkAX5V/Re3IP0v4j8Dpu1F7X
         lX7l9ETunU/3lwO9vSFtOh7blFTehwdItrWe4gIDF+o7kq78py/ADnfVw4Feo5rXCfx6
         /4ga5MF1nsBqvDvSGhxgfHW664CgaoTWGbrm27XlqGEEjiQIcMtkxh13BOQI47SrOzdO
         oWCkcpW4Qhk9frgKPgQjr1mnsXlAr/u9KTHERXLxZB+wRw7XpM6zqixe+pNpKiY8cHjF
         cScONBzWmai3POqtUItSmDb3mGdVRYdfaezodKG5xfjNKAb5X8h0omkYdLdPLxdGXlud
         vZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NF8ew4zOk2PYVgNlMZv8NebJXnACj3J4jLRW8j5wcyY=;
        b=eDgZSFNgJ8k7ujg0/ikQs+fiU8jM9xqGrKx2VtMaTHCYEL2Vvoqp7R9RwcwafU4671
         DaMIPIwUgI5xwrmT908CVq8c9PAdcMPoysdBz//kjQkGeVy+/9pmaFfFcB9udNnlOT3h
         NCJNhqVke521LePIrxles8NmoktfFH4ltqHILUinqWyEaK843Gk9VLUsEA2J9iqLO+fr
         QBaLFHMKwCxrV3vDWkuC2YxR2WkBZzbavrQGNacttjX95BuRwi4xiisRG1wlLog54Z46
         Rw/ZODMIcEhJoTk5Y2FRGt0YDYo25xFN6Xwd0ZwLBiRjchxJozmjxZZ+OlUEwVHVKNRv
         rtRA==
X-Gm-Message-State: AOAM5327azEfJ80TbY22FdmDcz6BPq7HBk944xYrNbYHbTqSrrjAg1Xv
        /k9j9oP8guXwCr7TMliwoMtLNbxGFTaT2rGDE/jgiFH6AdijmqO4JVKOF/P+Mt8gZCrDpn/E80P
        HtPEiVxc2aYGG1JYAS91/40aBUPMqHez3CbB446hTKF9/nc/d8MG1rj6ODULxfMIuPsSjLOX2Sc
        WNqWzsgycS/6w=
X-Google-Smtp-Source: ABdhPJxXqDNyGS/4IERjzeLkMpAAj14teQhO3pFE4G43ypK9+EeErdTwNP2mxlJo2pdiWu7ue+GQPUJxwjpg5imKUQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:5ef5:2854:f7cf:6571])
 (user=howardchung job=sendgmr) by 2002:a05:6214:10c8:: with SMTP id
 r8mr2646170qvs.28.1626148288042; Mon, 12 Jul 2021 20:51:28 -0700 (PDT)
Date:   Tue, 13 Jul 2021 11:51:22 +0800
Message-Id: <20210713115042.Bluez.v2.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v2] a2dp: Fix crash in channel_free while waiting cmd resp
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

When channel_free is called and we are waiting for a command response
from the peer, bluez NULL the setup->session but would not free its
setup_cb. Since setup_cb holds a ref of setup, the setup wouldn't be
freed and if service_removed is called after channel_free, a2dp_cancel
tries to abort the ongoing avdtp commands, which accesses the
setup->session and triggers a crash.

This change finalizes all avdtp commands before assigning setup->session
to NULL in channel_free.

Crash stack trace:
0x000059f01943e688	(bluetoothd -avdtp.c:3690)
avdtp_abort
0x000059f01943928a	(bluetoothd -a2dp.c:3069)
a2dp_cancel
0x000059f0194377fa	(bluetoothd -sink.c:324)
sink_unregister
0x000059f01948715a	(bluetoothd -service.c:177)
service_remove
0x000059f01948d77c	(bluetoothd -device.c:5346)
device_remove
0x000059f019476d14	(bluetoothd -adapter.c:7202)
adapter_remove
0x000059f019476c3e	(bluetoothd -adapter.c:10827)
adapter_cleanup
0x000059f01949d8d7	(bluetoothd -main.c:1114)		main
0x0000787b36185d74	(libc.so.6 -libc-start.c:308)
__libc_start_main
0x000059f019433e39	(bluetoothd + 0x00026e39)		_start
0x00007fff2d2c0127

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
There are two other options to fix this crash.
1. add a NULL check in a2dp_cancel before calling avdtp_abort.
2. call setup_cb_free to every setup_cb in setup->cb in channel_free.

Since each setup_cb needs setup->session, I think there is no need to
keep the setup_cb after assigning setup->session to NULL. So the first
option is not ideal. If the second option is adopted, there would be
some time that sink/source->connect_id/disconnect_id is not zero, but
there is no corresponding setup_cb.

Test steps:
Reproduce the crash with the following steps. Verify the crash is
no longer observed after this change.
1. ignore AVDTP_SET_CONFIGURATION resp by modifying avdtp.c
2. turn on a paired headset
3. check the bluetooth.log, while bluez is waiting for
   AVDTP_SET_CONFIGURATION resp, stop bluetoothd immediately.
   This will trigger:
   session_cb (I/O error) -> connection_lost
   -> avdtp_set_state (AVDTP_SESSION_STATE_DISCONNECTED)
   -> avdtp_state_cb -> channel_remove -> channel_free
   then:
   adapter_cleanup -> adapter_remove -> device_remove -> service_remove
   -> a2dp_sink_remove -> sink_unregister -> sink_free -> a2dp_cancel
4. check if bluetoothd crash
The above steps can trigger the crash 100%.

Changes in v2:
- Implement helper function finalize_all
- Add setup_ref before finalize_all, in case the setup is freed during
  finalize

 profiles/audio/a2dp.c | 68 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d31ed845cbe7..5d7c416a5deb 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -404,6 +404,69 @@ static void finalize_discover(struct a2dp_setup *s)
 	}
 }
 
+static void finalize_all(struct a2dp_setup *s)
+{
+	GSList *l;
+
+	for (l = s->cb; l != NULL; ) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (cb->discover_cb) {
+			cb->discover_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->select_cb) {
+			cb->select_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->suspend_cb) {
+			cb->suspend_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->resume_cb) {
+			cb->resume_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->config_cb) {
+			cb->config_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else
+			warn("setup_cb doesn't have any callback function");
+
+		setup_cb_free(cb);
+	}
+}
+
+static void finalize_all(struct a2dp_setup *s)
+{
+	GSList *l;
+	struct avdtp_stream *stream = s->err ? NULL : s->stream;
+
+	for (l = s->cb; l != NULL; ) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (cb->discover_cb) {
+			cb->discover_cb(s->session, s->seps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->select_cb) {
+			cb->select_cb(s->session, s->seps, s->caps,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->suspend_cb) {
+			cb->suspend_cb(s->session,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->resume_cb) {
+			cb->resume_cb(s->session,
+					error_to_errno(s->err), cb->user_data);
+		} else if (cb->config_cb) {
+			cb->config_cb(s->session, s->seps, stream,
+					error_to_errno(s->err), cb->user_data);
+		} else
+			warn("setup_cb doesn't have any callback function");
+
+		setup_cb_free(cb);
+	}
+}
+
 static struct a2dp_setup *find_setup_by_session(struct avdtp *session)
 {
 	GSList *l;
@@ -1540,9 +1603,12 @@ static void channel_free(void *data)
 	setup = find_setup_by_session(chan->session);
 	if (setup) {
 		setup->chan = NULL;
+		setup_ref(setup);
+		/* Finalize pending commands before we NULL setup->session */
+		finalize_setup_errno(setup, -ENOTCONN, finalize_all, NULL);
 		avdtp_unref(setup->session);
 		setup->session = NULL;
-		finalize_setup_errno(setup, -ENOTCONN, NULL);
+		setup_unref(setup);
 	}
 
 	g_free(chan);
-- 
2.32.0.93.g670b81a890-goog

