Return-Path: <cyrus@holtmann.org>
From: Hsin-Yu Chao <hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: armansito@chromium.org, luiz.dentz@gmail.com,
	Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH v1] audio/media: Fix crash at endpoint handling no reply err
Date: Sun,  8 Mar 2015 14:14:15 +0800
Message-Id: <1425795255-832-1-git-send-email-hychao@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When handling DBUS_ERROR_NO_REPLY error in media endpoint, the
a2dp_setup gets unref'ed in the associated request callback when
it's called for the first time.  A crash happens in the later
clear_endpoint call with below backtrace that, the request callback
will be triggered again with NULL session.
To fix this, remove the additional request callback so that every
callback only gets triggered for once in clear_endpoint.

0xb6f30d44 [bluetoothd -avdtp.c:1421 ] setconf_cb
0xb6f2c3bb [bluetoothd -a2dp.c:407 ]   auto_config
0xb6f32c39 [bluetoothd -media.c:137 ]  media_endpoint_cancel
0xb6f32e8d [bluetoothd -media.c:145 ]  clear_endpoint
0xb6f32faf [bluetoothd -media.c:276 ]  endpoint_reply

---
 profiles/audio/media.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 965b32a..762758b 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -270,9 +270,6 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 
 		/* Clear endpoint configuration in case of NO_REPLY error */
 		if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY)) {
-			if (request->cb)
-				request->cb(endpoint, NULL, size,
-							request->user_data);
 			clear_endpoint(endpoint);
 			dbus_message_unref(reply);
 			dbus_error_free(&err);
-- 
2.1.2

