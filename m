Return-Path: <cyrus@holtmann.org>
From: Hsin-Yu Chao <hychao@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: armansito@chromium.org, Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH] audio/media: Fix crash at endpoint handling no reply err
Date: Fri,  6 Mar 2015 11:58:05 +0800
Message-Id: <1425614285-8938-1-git-send-email-hychao@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When handling DBUS_ERROR_NO_REPLY error in media endpoint,
the a2dp_setup gets unref'ed in the associated request callback.
We need to remove the request from list once it has been
handled, or in the following clear_endpoint call this
request callback will be triggered again with NULL session
and cause crash.

---
 profiles/audio/media.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 965b32a..0bb82eb 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -273,6 +273,9 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 			if (request->cb)
 				request->cb(endpoint, NULL, size,
 							request->user_data);
+			endpoint->requests = g_slist_remove(endpoint->requests,
+							    request);
+			endpoint_request_free(request);
 			clear_endpoint(endpoint);
 			dbus_message_unref(reply);
 			dbus_error_free(&err);
-- 
2.1.2

