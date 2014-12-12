Return-Path: <cyrus@holtmann.org>
From: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sagar Nageshmurthy <s.nageshmurt@samsung.com>
Subject: [PATCH 1/1] audio/sink: Fix crash when err is NULL
Date: Fri, 12 Dec 2014 16:41:30 +0530
Message-id: <1418382690-9741-1-git-send-email-s.nageshmurt@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a2dp connection fails because of IO error setup error can be NULL
if the err is already handled by finalize_resume(setup).

(gdb) p *(struct a2dp_setup *)0xb6f98150
$8 = {session = 0xb6c12000, sep = 0xb6c49d30, rsep = 0x0, stream = 0x0,
	  err = 0x0, setconf_cb = 0, caps = 0x0, reconfigure = 17,
	    start = -1225164896, cb = 0xb6d70288, ref = 16}

(gdb) bt
0 0xb6f92108 in ?? ()
1 0xb6efcd88 in finalize_config (data=0xb6f98150)
    at profiles/audio/a2dp.c:222
2 0xb6f004a8 in handle_unanswered_req (session=0xb6f9a650,
    sep=<value optimized out>, state=AVDTP_STATE_IDLE)
    at profiles/audio/avdtp.c:967
3 avdtp_sep_set_state (session=0xb6f9a650, sep=<value optimized out>,
    state=AVDTP_STATE_IDLE) at profiles/audio/avdtp.c:1163
4 0xb6e16fb8 in g_slist_foreach (list=<value optimized out>,
    func=0xb6f005e5 <release_stream>, user_data=0xb6f9a650) at gslist.c:840

daemon.debug : src/device.c:device_profile_connected() a2dp-sink Input/output error (5)
daemon.debug : profiles/audio/a2dp.c:abort_cfm() Source 0xb6f8fba8: Abort_Cfm
daemon.debug : profiles/audio/a2dp.c:setup_unref() 0xb6f98150: ref=1
daemon.err : No reply to Open request
daemon.debug : profiles/audio/a2dp.c:open_cfm() Source 0xb6f8fba8: Open_Cfm
---
 profiles/audio/sink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index f475709..7fa9430 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -191,7 +191,7 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 
 	avdtp_unref(sink->session);
 	sink->session = NULL;
-	if (avdtp_error_category(err) == AVDTP_ERRNO
+	if (err && avdtp_error_category(err) == AVDTP_ERRNO
 				&& avdtp_error_posix_errno(err) != EHOSTDOWN)
 		btd_service_connecting_complete(sink->service, -EAGAIN);
 	else
-- 
1.7.9.5

