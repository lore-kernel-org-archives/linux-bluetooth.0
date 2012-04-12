Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 05/19] gateway: Fix D-Bus memory leak in audio
Date: Thu, 12 Apr 2012 20:32:56 +0530
Message-id: <1334243001-17016-6-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 131f93f..19f8ce3 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -182,8 +182,11 @@ static gboolean agent_sendfd(struct hf_agent *agent, int fd,
 					DBUS_TYPE_UINT16, &gw->version,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(dev->conn, msg, &call, -1) == FALSE)
+	if (dbus_connection_send_with_reply(dev->conn, msg,
+							&call, -1) == FALSE) {
+		dbus_message_unref(msg);
 		return FALSE;
+	}
 
 	dbus_pending_call_set_notify(call, notify, dev, NULL);
 	dbus_pending_call_unref(call);
-- 
1.7.4.1

