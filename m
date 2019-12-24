Return-Path: <SRS0=L7UJ=2O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D86C2D0CF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 06:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D197206B7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Dec 2019 06:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wrwc3fdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbfLXGsP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:48:15 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48555 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfLXGsP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Dec 2019 01:48:15 -0500
Received: by mail-yw1-f74.google.com with SMTP id a190so14791802ywe.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Dec 2019 22:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=afSN7o3UhMcA0gVq30yn427M/iZo9SRaFRuxhiciCtg=;
        b=Wrwc3fdkTohRw/NO94Zqw5QXA+OiTKmoSy78OpS6aCqYBAIJ7XzWfL6URi2OcMZ2Lc
         /LOxRZlzqSh2b2yhvuaetVrwKnjrFBKdwGkF8urpwrqKJfR+VNhqVz58zDKaObbMPkaL
         77jnKV/JHnDY14Bcrc1lrgFfQNGrGPEz7qHcLp0mQsiVNLaEjINiueTkSnnPO6SaPD6z
         Z9DydPtGvDABZKCfew++swNMr5HmjeHKfWb2fgnUmVvoFc7WscGvnEmnpaeQiQDYF4IT
         /ycDQeDImZc4A1vVM+rDq3VZivxMzeVBJzZ3vdxhM3mF5YthZi0hbFCeNqVYdekkWWqa
         0MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=afSN7o3UhMcA0gVq30yn427M/iZo9SRaFRuxhiciCtg=;
        b=mn1FcebAdN7lOd8H2ZhGUyVPYlDPbFDsU+ulEmHHPRz7lC8K5PfDMpOcFnpPB43tL8
         Hmmr1ihpAQ7eEaVPEEvWFCYg1/6xzpcDeh/JW7d1WtYSlDyKGf4muS7XlJAFrulOYJnG
         RrD+QZ5IdrhIVbUrWRaNU2PUgEFigy22EaS1+IsSOTEF95c0dP9cTN1d35frQtwAhJcy
         15XgQbDxvH8Zx86EUGnqx2X7UqLLy4eRweYonyNnQ3dxN2ariqwV12qXP5XpBzB6kZS7
         DpS/Ml/S/4bL20kI1D4/f7ZMbJQFCEwJcatCIZ6mpv5t7Dpy5aB5deYECJms5Oet+0MM
         qtjg==
X-Gm-Message-State: APjAAAXrZQoBw/Zaiz4bY/ywDOoPXgwDEBb9gVHgHCMgV5QIuPIYlEMG
        gWJ1zlS6f52YrDY1TSWuysCSBO+xwaaO1CFirpR3MPzjBMK/7RhwI3a9hS/onp6POigYcDzfl3q
        O1NGqPv8x/nDgfc/lsu3IHDz+NUIPdoW69OxkZlN69j3+CJsyXS7jRFUaZ9aMAq69uMmDGFz+1p
        auav6am/9IGE8=
X-Google-Smtp-Source: APXvYqwUnDMuQSmVr5jpCNjePB3xvGKDiy8d73lfoO+XMLac9HhSr/TsQoXacTv/iCZD2TR6qpWFxj4LZgC3U12xdA==
X-Received: by 2002:a25:e681:: with SMTP id d123mr10362259ybh.292.1577170093751;
 Mon, 23 Dec 2019 22:48:13 -0800 (PST)
Date:   Tue, 24 Dec 2019 14:48:07 +0800
Message-Id: <20191224144804.Bluez.v1.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [Bluez PATCH v1] CHROMIUM: audio: fix crash during recovering process
From:   "howardchung@google.com" <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     howardchung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: howardchung <howardchung@google.com>

The crash with stack trace:

(libc-2.27.so -raise.c:51 )      		raise
(libc-2.27.so -abort.c:79 )      		abort
(libc-2.27.so -libc_fatal.c:181 )        	__libc_message
(libc-2.27.so -malloc.c:5350 )   		malloc_printerr
(libc-2.27.so -malloc.c:4157 )   		_int_free
(libglib-2.0.so.0.5200.3 -gslist.c:878 )        g_slist_free_full
(bluetoothd -a2dp.c:165 )       		setup_unref
(bluetoothd -a2dp.c:2184 )      		a2dp_cancel
(bluetoothd -sink.c:317 )       		sink_unregister
(bluetoothd -service.c:176 )    		service_remove
(bluetoothd -device.c:4678 )    		device_remove
(bluetoothd -adapter.c:6573 )   		adapter_remove
(bluetoothd -adapter.c:8832 )   		index_removed
(bluetoothd -queue.c:220 )      		queue_foreach
(bluetoothd -mgmt.c:304 )       		can_read_data
(bluetoothd -io-glib.c:170 )    		watch_callback
(libglib-2.0.so.0.5200.3 -gmain.c:3234 )        g_main_context_dispatch
(libglib-2.0.so.0.5200.3 -gmain.c:3972 )        g_main_context_iterate
(libglib-2.0.so.0.5200.3 -gmain.c:4168 )        g_main_loop_run
(bluetoothd -main.c:798 )       		main
(libc-2.27.so -libc-start.c:308 )        	__libc_start_main
(bluetoothd + 0x0000b089 )      		_start
(bluetoothd + 0x0000b05f )      		_init

triggered when 'usb disconnect' happened during AVDTP_SET_CONFIGURATION
request is sent but haven't recevied the responce.
In this situation, the recovering process goes into sink.c:sink_free and
then a2dp.c:a2dp_cancel, avdtp.c:cancel_request, avdtp.c:connection_lost,
avdtp.c:release_stream.

During recovering, the reference count of setup and avdtp decrease more
than it increase, which ends up causing the crash.

The reference count of setup decreases one more time since
a2dp.c:setconf_cfm(called by cfm->set_configuration in
avdtp.c:cancel_request) was called in the 'error mode', which didn't
reference the setup, but in a2dp.c:abort_cfm(called by cfm->abort in
avdtp.c:release_stream), the reference count decreased by 1.

In this case, abort_cfm shouldn't be called as we already know
setconf_cfm didn't send any request. Setting avdtp_sep_state to
AVDTP_STATE_ABORTING should avoid this issue.

The reference count of avdtp decrease one more time since
both sink.c:sink_free and sink.c:sink_set_state(called from
avdtp.c:connection_lost -> avdtp.c:avdtp_set_state) unreference avdtp
for the session. The changes in sink.c should avoid the issue.

Signed-off-by: howardchung@google.com <howardchung@google.com>
---
How to test:
        The crash can be simulated by the following procedure.
        1. injecting sleep(10) right before calling a2dp_config in
           sink.c:select_complete.
        2. connect with a bluetooth headset
        3. run 'rmmod btusb' after ~5 seconds(before the connection
           complete)
The procedure can reproduce the crash with ~50% probability.
Even if the bluetoothd didn't crash or it crashed with different
signature, the reference count can end up with some invalid number.

After the patch applies, there is no crash after running the test above 10
times in a row.

 profiles/audio/avdtp.c | 3 +++
 profiles/audio/sink.c  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 91b1e4b96..f42f21bbb 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3550,6 +3550,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct seid_req req;
 	int ret;
+	struct avdtp_local_sep *sep = stream->lsep;
 
 	if (!stream && session->discover) {
 		/* Don't call cb since it being aborted */
@@ -3564,6 +3565,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
+	avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
+
 	if (session->req && stream == session->req->stream)
 		return cancel_request(session, ECANCELED);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 966440534..7c5e77577 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -308,8 +308,10 @@ static void sink_free(struct btd_service *service)
 		avdtp_stream_remove_cb(sink->session, sink->stream,
 					sink->cb_id);
 
-	if (sink->session)
+	if (sink->session) {
 		avdtp_unref(sink->session);
+		sink->session = NULL;
+	}
 
 	if (sink->connect_id > 0) {
 		btd_service_connecting_complete(sink->service, -ECANCELED);
-- 
2.24.1.735.g03f4e72817-goog

