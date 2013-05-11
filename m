Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/2] avrcp: Fix crash using the wrong AVRCP role
Date: Fri, 10 May 2013 21:29:09 -0300
Message-Id: <1368232149-9974-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1368232149-9974-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1368232149-9974-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When both A2DP Sink and Source are unavailable (dev->sink and
dev->source are NULL), the wrong AVRCP role gets selected.

Valgrind log:

bluetoothd[24510]: src/adapter.c:connected_callback() hci0 device 00:02:72:DC:29:78 connected eir_len 10
bluetoothd[24510]: profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from 00:02:72:DC:29:78
bluetoothd[24510]: profiles/audio/avctp.c:avctp_set_state() AVCTP Connecting
bluetoothd[24510]: profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to 00:02:72:DC:29:78
bluetoothd[24510]: Can't open input device: No such file or directory (2)
bluetoothd[24510]: AVRCP: failed to init uinput for 00:02:72:DC:29:78
bluetoothd[24510]: profiles/audio/avrcp.c:session_ct_init_control() 0x62df7e0 version 0x0000
==24510== Invalid read of size 4
==24510==    at 0x468370: btd_service_connecting_complete (service.c:315)
==24510==    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
==24510==    by 0x41B1E0: state_changed (avrcp.c:2933)
==24510==    by 0x418054: avctp_set_state (avctp.c:548)
==24510==    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
==24510==    by 0x44F989: accept_cb (btio.c:201)
==24510==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==24510==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==24510==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==24510==    by 0x40A8EE: main (main.c:583)
==24510==  Address 0x20 is not stack'd, malloc'd or (recently) free'd
==24510==
==24510==
==24510== Process terminating with default action of signal 11 (SIGSEGV)
==24510==  Access not within mapped region at address 0x20
==24510==    at 0x468370: btd_service_connecting_complete (service.c:315)
==24510==    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
==24510==    by 0x41B1E0: state_changed (avrcp.c:2933)
==24510==    by 0x418054: avctp_set_state (avctp.c:548)
==24510==    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
==24510==    by 0x44F989: accept_cb (btio.c:201)
==24510==    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
==24510==    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
==24510==    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
==24510==    by 0x40A8EE: main (main.c:583)
==24510==  If you believe this happened as a result of a stack
==24510==  overflow in your program's main thread (unlikely but
==24510==  possible), you can try to increase the size of the
==24510==  main thread stack using the --main-stacksize= flag.
==24510==  The main thread stack size used in this run was 8388608.
---

Perhaps there's a more correct way to solve this. (Luiz, looking at you.)


 profiles/audio/avrcp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4acf396..5116efd 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2852,6 +2852,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
 						struct audio_device *dev)
 {
 	struct avrcp *session;
+	struct control *control = dev->control;
 	const sdp_record_t *rec;
 	sdp_list_t *list;
 	sdp_profile_desc_t *desc;
@@ -2863,14 +2864,14 @@ static struct avrcp *session_create(struct avrcp_server *server,
 
 	server->sessions = g_slist_append(server->sessions, session);
 
-	if (dev->sink && !dev->source)
-		session->target = TRUE;
-	else if (dev->source && !dev->sink)
-		session->target = FALSE;
-	else if (dev->sink && sink_is_active(dev))
+	/*
+	 * 'session->target' indicates the _local_ role, 'control_get_role()'
+	 * gets the role of the _remote_ device.
+	 */
+	session->target = control_get_role(control) == CONTROL_ROLE_REMOTE;
+
+	if (dev->sink && sink_is_active(dev))
 		session->target = TRUE;
-	else
-		session->target = FALSE;
 
 	if (session->target) {
 		session->init_control = session_tg_init_control;
-- 
1.8.2.2

