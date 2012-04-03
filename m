Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] gdbus: Use destroy callback for service watch
Date: Tue,  3 Apr 2012 12:14:58 -0400
Message-Id: <1333469700-29879-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Even though service watches accepted a "destroy" callback, they were
being ignored. This fix properly pass them along so they are called when
the watch is removed.
---
 gdbus/watch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index fba58c3..9a716b0 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -666,7 +666,7 @@ guint g_dbus_add_service_watch(DBusConnection *connection, const char *name,
 	if (data == NULL)
 		return 0;
 
-	cb = filter_data_add_callback(data, connect, disconnect, NULL, NULL,
+	cb = filter_data_add_callback(data, connect, disconnect, NULL, destroy,
 					user_data);
 	if (cb == NULL)
 		return 0;
-- 
1.7.5.4

