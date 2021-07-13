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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2416C07E95
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85BA61158
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jul 2021 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbhGMJ6Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jul 2021 05:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235149AbhGMJ6Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jul 2021 05:58:24 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2ADC0613DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 02:55:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id c22-20020a0ca9d60000b02902e60d75210eso5811942qvb.19
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jul 2021 02:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=l5F4BKwyaBy83y62AZjTc/qt2ROTKel2LO04fCzL2X8=;
        b=uCSMQr9c+ZuhjfjkTnGdWJmMYECAsI5Sdsh3UXNBtGThTUBkfDe1BvMLLUr2CnL0+A
         33rkV6h5mQwD2vJVmYwBxdTAz/odcmYhV7v4KU5454GvJXL3OAY9MNS4dkB02orlronf
         OLtwD+RiUNgWckzCjAIgW+2IdEJ0deY6nHxkjwSxWi+qIAo9xYmGK1P/M5HWkuNnpZwW
         ZzquhNC8t1MvNiwzUWNDhWElZGzyNBd1FKXbOtWFMS6ZZo/dJrnhRTEBCJujjoZxDUDa
         OWaM4yVsST+F8qdwABro4zWaVV6gDNSihG3Amvqvw3ubQCjVItL2iOG8SSd41tnP9tSs
         QQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=l5F4BKwyaBy83y62AZjTc/qt2ROTKel2LO04fCzL2X8=;
        b=leASSkZ8/hGfwgDh0VuUFTPuTlGhDhDN+0CNzQEcPziGrAmkwkeJcLreHrnwfaJHzM
         3uN1rBQrKyuFg7qQnSKqHbkpXHkefjyUCeT8UxC3s45uiP5fx4NKD5D3uv4pQqdD6ISB
         xBpvHjvJfWasYN8rN1Ve6Yxp+4lgEjBYZwA5p54Ak2YN2oP+tkzbt6N9PvV3OTTyqEiT
         pGIVRzbMHKKGhkVUAcDnO+uK8v1Nqs+qfzMfVut6my2kaW1fYixO/oY12r9piuHwUre1
         cZQm+i2D9MiKOuwA2VvngugnXHwR4iZP5NVAmgjVix6ak3FhS9dR21WqWRTYzhsHIiVI
         FVbw==
X-Gm-Message-State: AOAM530sqQF+bT66ncUs6b6q3htHaFP+RuNwvvlhz3H7seH4yrSBwWdd
        k+/mV8+VNPRFsIifTDDr0JN+y/Ogc1toLNH7RLbjfQsaBTwUy1cZ4/zy3bLXDkTKGORPiXfCT95
        TRSLE1Y0rjdXCSbk/R+vPWhuFmhrzaXqMQ8+zaRobguJf3bxwj93X1MRpxaofX7G6u9gXwuBmuW
        8gPGo5kvNYjfY=
X-Google-Smtp-Source: ABdhPJyUCJSKbgv2q11Hcuw/UQSCsVMBpYwcfOH77kuJbfT7NE5rfPrDvuEngKzQT4TidlFZVVC1VPm9kKNpCVv/wA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:5ef5:2854:f7cf:6571])
 (user=howardchung job=sendgmr) by 2002:ad4:5386:: with SMTP id
 i6mr3851969qvv.2.1626170133914; Tue, 13 Jul 2021 02:55:33 -0700 (PDT)
Date:   Tue, 13 Jul 2021 17:55:30 +0800
Message-Id: <20210713175519.Bluez.v3.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v3] a2dp: Fix crash in channel_free while waiting cmd resp
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

Changes in v3:
- Remove the duplicated finalize_all

Changes in v2:
- Implement helper function finalize_all
- add setup_ref before finalize_all, in case the setup is freed during
  finalize

 profiles/audio/a2dp.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d31ed845cbe7..39d5e3ef736c 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -404,6 +404,38 @@ static void finalize_discover(struct a2dp_setup *s)
 	}
 }
 
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
@@ -1540,9 +1572,12 @@ static void channel_free(void *data)
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

