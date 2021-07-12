Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E061C07E99
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 12:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E652F610CB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 12:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhGLMlx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Jul 2021 08:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhGLMlx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Jul 2021 08:41:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1B4C0613DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 05:39:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s83-20020a2545560000b029055ae952c336so21838823yba.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jul 2021 05:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AZVw5nykdjqW/L02IS5LQH/2Nakz80+2d9XnIF/FXzY=;
        b=AzDcCuY59ybrIK/Orx7EQTCsdwZEmAurAO4bCJxzLwp6t5rLJfyDcLGe79l4jKarTa
         6LahMlLOFF21XGWrJ2vofrXFkfdt51xt2IObJbKBzW/QyFUlFGDk3NondY+6PIw0/el3
         An8Dpuf3h/5GXIthRDqe8Q4j65Z9sUUuYjHrpJB/SZne4hOo9NsB2NH1hXd+WubsTlV8
         x7rH9WOnY8zuWm/22w9qLobZok0O2nvhsw62w8Sd31ci4/WIAVh66sBxc2eVz0yMSvlL
         60Kp4HHacdAH9dMfMuSquZLcGDrvyn4TBp9jMVPclsvnTzyK9L+SYnxaRKbtQWLb4Us7
         p06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AZVw5nykdjqW/L02IS5LQH/2Nakz80+2d9XnIF/FXzY=;
        b=KngB9LyYg1ifMfZZwTY/AaNk4nAeCNU8M0kzpHcDiqYPTXK9OsdNp07snN7LStl0wl
         NoYGIxU8dhc4WkcmszLD+rRXW3VbcUo+okZ6pabsaDxRaVWjXaoEmuDejOuK+Eu7GodM
         mt+3Ww6mgOLOmmFq0bO5sWZB5fEEkFurJZNLQQ3gVBUva987DDWiNoAJf1T9D7iG3T3o
         VoPsjeHsaqP0QtxzyTGLm8l41vFy9CTSGmQYee3EwwlpkoD4QVV+ESSw1kGNTbpvFQi5
         kf35nDLhHTBHERCKdG670RE0izeVlkP54YyYrjhkZOTDko7dHg64Dkr1fibPrFwFHZTK
         y7iw==
X-Gm-Message-State: AOAM530cCyQG5V8gwV7gCp0ofbAmvf1tmMf475iIhL+KWVv5kLA29Dap
        YFcCqxzK9aqDpIPYNU8N6C36ol8tIC22mWGx5niL41A/klhHrt4+Lvvcz6c5iSoWR0qrv/hprHG
        iMVLDIN3ghnAkUWoF+AD7hwpqHPRL3up8g7Yep5M8FeCbJOTlEy7H7kkRdY9/w+sLsSfcFwsWs5
        1egbI6z2xJq5w=
X-Google-Smtp-Source: ABdhPJwDYK14AbPivQv+BjP7ACaOLZWQdUoCHVl4ifFEfe1LHvoqg430KTPgq/VlVZITw684kUnBIkZMDP0hkR073Q==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:6d5d:995d:3db9:eae])
 (user=howardchung job=sendgmr) by 2002:a25:25cd:: with SMTP id
 l196mr63637866ybl.226.1626093544053; Mon, 12 Jul 2021 05:39:04 -0700 (PDT)
Date:   Mon, 12 Jul 2021 20:38:57 +0800
Message-Id: <20210712203813.Bluez.v1.1.Id7aa1152377161d17b442bf258773d9b6c624ca3@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1] a2dp: Fix crash in channel_free while waiting cmd resp
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

 profiles/audio/a2dp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d31ed845cbe7..f201b98c79d0 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1540,9 +1540,14 @@ static void channel_free(void *data)
 	setup = find_setup_by_session(chan->session);
 	if (setup) {
 		setup->chan = NULL;
+		/* Finalize pending commands before we NULL setup->session */
+		finalize_setup_errno(setup, -ENOTCONN, finalize_discover,
+							finalize_select,
+							finalize_config,
+							finalize_resume,
+							finalize_suspend, NULL);
 		avdtp_unref(setup->session);
 		setup->session = NULL;
-		finalize_setup_errno(setup, -ENOTCONN, NULL);
 	}
 
 	g_free(chan);
-- 
2.32.0.93.g670b81a890-goog

