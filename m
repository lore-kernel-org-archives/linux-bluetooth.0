Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix using g_source_remove intead of g_dbus_remove_watch
Date: Fri, 28 Jan 2011 15:17:39 +0200
Message-Id: <1296220659-24165-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1296220659-24165-1-git-send-email-luiz.dentz@gmail.com>
References: <1296220659-24165-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Watches created with g_dbus_add_signal_watch cannot be removed with
g_source_remove.
---
 plugins/usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/usb.c b/plugins/usb.c
index 580e7b8..466dc99 100644
--- a/plugins/usb.c
+++ b/plugins/usb.c
@@ -201,7 +201,7 @@ static gboolean handle_signal(DBusConnection *connection,
 static void usb_stop(void *data)
 {
 	guint id = GPOINTER_TO_UINT(data);
-	g_source_remove(id);
+	g_dbus_remove_watch(connection, id);
 }
 
 static void mode_request_reply(DBusPendingCall *call, void *user_data)
-- 
1.7.1

