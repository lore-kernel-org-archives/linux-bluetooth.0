Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] audio/AVCTP: Fix connecting browsing channel multiple times
Date: Mon, 29 Jul 2013 17:04:38 +0300
Message-Id: <1375106679-14645-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
References: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

While accepting the connection via DEFER_SETUP a second connection can
be created by using avctp_connect_browsing which will not detect one is
in course as the state has not yet changed, this can cause memory leaks
or crashes as the following:

profiles/audio/avctp.c:avctp_confirm_cb() AVCTP: incoming connect from XX:XX:XX:XX:XX:XX
profiles/audio/avctp.c:avctp_set_state() AVCTP Browsing Connecting
profiles/audio/avctp.c:avctp_connect_browsing_cb() AVCTP Browsing: connected to XX:XX:XX:XX:XX:XX
profiles/audio/avctp.c:avctp_set_state() AVCTP Browsing Connected
profiles/audio/avctp.c:avctp_connect_browsing_cb() AVCTP Browsing: connected to XX:XX:XX:XX:XX:XX
profiles/audio/avctp.c:avctp_set_state() AVCTP Browsing Connected
profiles/audio/avctp.c:session_browsing_cb() AVCTP Browsing: disconnected
profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
Invalid read of size 8
   at 0x41EB28: session_browsing_cb (avctp.c:842)
   by 0x32F5447E05: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5448157: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x32F5448559: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3600.3)
   by 0x40A28F: main (main.c:583)
 Address 0x20 is not stack'd, malloc'd or (recently) free'd
---
 profiles/audio/avctp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 11e9365..2c1aa94 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1328,8 +1328,10 @@ static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
 	}
 
 	if (bt_io_accept(chan, avctp_connect_browsing_cb, session, NULL,
-								&err))
+								&err)) {
+		avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
 		return;
+	}
 
 	error("Browsing: %s", err->message);
 	g_error_free(err);
-- 
1.8.3.1

