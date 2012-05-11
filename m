Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] adapter: Remove dead code from set_property()
Date: Fri, 11 May 2012 09:09:29 -0400
Message-Id: <1336741769-21991-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 93b55e8..8e95ab2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1174,13 +1174,9 @@ static DBusMessage *get_properties(DBusConnection *conn,
 static DBusMessage *set_property(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
-	struct btd_adapter *adapter = data;
 	DBusMessageIter iter;
 	DBusMessageIter sub;
 	const char *property;
-	char srcaddr[18];
-
-	ba2str(&adapter->bdaddr, srcaddr);
 
 	if (!dbus_message_iter_init(msg, &iter))
 		return btd_error_invalid_args(msg);
-- 
1.7.5.4

