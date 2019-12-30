Return-Path: <SRS0=qfK6=2U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE17C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Dec 2019 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5EE2071E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Dec 2019 10:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wb36d7yc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfL3KEG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Dec 2019 05:04:06 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46941 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfL3KEG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Dec 2019 05:04:06 -0500
Received: by mail-pg1-f201.google.com with SMTP id t12so21951589pgs.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Dec 2019 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GCjUQL10HH5KY5jXChxh/arhMxvfV3S1Jdo8mtlE0LA=;
        b=Wb36d7yc1E0myIfmm2AUKiQlHNo4uleQwMxAr0LBJMIpGFpZ8rMFmnWoRd3GcoEy7B
         INIHU74xEOlRqjA10IM3nG6wXbRe9pI1pO4X13sYXcn6aeFn6yuLqDJjWrq35VNhaupm
         nZaIX/KYsMxV2TjiQnnEpEuf2KNYhf+JwSU0wSOw/ELZGOqyYhNHBxthoreHV96kmqGJ
         L9jSdH65+F5Eq5N6o93fOj9fwHtnHS49hZ/+AefKZoTejj5l1ForSSN0qadSMIfzE7LV
         univyAwy7XQyOVQY+3+4iD3Uk1iRCTKxGBD0qZrJ3OXjp3k4voNc2x3irLkWh/kB0Faw
         NA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GCjUQL10HH5KY5jXChxh/arhMxvfV3S1Jdo8mtlE0LA=;
        b=CX8lXKShusjwzP2qs4Nq6dQizWmJtN7vboHjX0b2OTalyTcQuKTy/zCFQe1RIceSzL
         ul/qQGgu9MF1kK9uo1Ce+NExvD6TwQ7CAglaaARL4FzOfM9Jv2XfJVXTepJ1ep0eFrdN
         Pe+Fx+eLSPIvQCZRixgYPNYip2RbpoXwSDFQoBFGKuCk92x4V8exsOP60dM36FLAERKd
         MSPn2qfCbCxA+vJXhl8MwPZDn4RsfzV1pl04FqOAUB2aZI/LKGq8s5QK5CWEV7nxfapf
         /YAzqjz52nWU1TZEuAMcF5zKzoJCGj5V2sMuW4cvzENRBnhVRMGpBhCQ4/lsvUt8ihCJ
         QQZw==
X-Gm-Message-State: APjAAAXOMYvkcCe1N2AoGtAIkrNu0moaKMQPlehwJPwUCbs6ma8QXc7Q
        i+tFwKOIoUO1fcXG0YfeQcshmQg/1g6WkWxy9uoNWGbVFMPameb43av5MXJU78/CVcy+YC3ATYb
        PTXaDevuohPp7RQQRUjH1YCPQUw0++9c56nqPUoRV982FUZP9Bh+RcOLPJ2nufgHo6crjV+vJCa
        XBWR2SATEaxEM=
X-Google-Smtp-Source: APXvYqwdZPagg0VV45MM/G9DdSBQmGWactbk7hM67MUgnk2FGAa7kb7I/oxGtGh6xJsTfSTQZDl8vm7Y24TfPb0N5Q==
X-Received: by 2002:a63:4e06:: with SMTP id c6mr18104623pgb.187.1577700244579;
 Mon, 30 Dec 2019 02:04:04 -0800 (PST)
Date:   Mon, 30 Dec 2019 18:03:58 +0800
Message-Id: <20191230180355.Bluez.v2.1.Ie74d7bb468a914ba7386aae02fc63cd4f529b0ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [Bluez PATCH v2] CHROMIUM: audio: fix crash during recovering process
From:   "howardchung@google.com" <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        howardchung <howardchung@google.com>
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
request is sent but haven't received the response.
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

Changes in v2:
- Fixed typo in commit message

 profiles/audio/avdtp.c | 3 +++
 profiles/audio/sink.c  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 51ead684a..620a76c90 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3484,6 +3484,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 {
 	struct seid_req req;
 	int ret;
+	struct avdtp_local_sep *sep = stream->lsep;
 
 	if (!stream && session->discover) {
 		/* Don't call cb since it being aborted */
@@ -3498,6 +3499,8 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (stream->lsep->state == AVDTP_STATE_ABORTING)
 		return -EINVAL;
 
+	avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
+
 	if (session->req && stream == session->req->stream)
 		return cancel_request(session, ECANCELED);
 
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 7cac21034..726e2f562 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -309,8 +309,10 @@ static void sink_free(struct btd_service *service)
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

