Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 2/2] Fix dbus memory leak
Date: Wed, 09 Nov 2011 11:29:40 +0530
Message-id: <1320818380-17217-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1320818380-17217-1-git-send-email-s.syam@samsung.com>
References: <1320818380-17217-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/usb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/plugins/usb.c b/plugins/usb.c
index a0ec21b..12fb30c 100644
--- a/plugins/usb.c
+++ b/plugins/usb.c
@@ -242,11 +242,13 @@ static void *usb_start(struct obex_server *server, int *err)
 	if (dbus_connection_send_with_reply(connection,
 					msg, &call, -1) == FALSE) {
 		error("usb: unable to send mode_request");
+		dbus_message_unref(msg);
 		goto fail;
 	}
 
 	dbus_pending_call_set_notify(call, mode_request_reply, server, NULL);
 	dbus_pending_call_unref(call);
+	dbus_message_unref(msg);
 
 	id = g_dbus_add_signal_watch(connection, NULL, NULL,
 					"com.meego.usb_moded",
-- 
1.7.4.1

