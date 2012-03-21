Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 7/8] attrib: Attempt to remove attio callback on watcher exit
Date: Wed, 21 Mar 2012 13:00:54 -0400
Message-Id: <1332349255-15764-8-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1332349255-15764-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When registering a watcher, it is attempted to add an attio callback.
Therefore, when the watcher is unregistered or exits, this attio should
be removed if there are no other users.

This is already done when unregistering a watcher, it just missed when
it exits without unregistering.
---
 attrib/client.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index ac1b354..52f50b4 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -227,6 +227,7 @@ static void watcher_exit(DBusConnection *conn, void *user_data)
 	DBG("%s watcher %s exited", gatt->path, watcher->name);
 
 	gatt->watchers = g_slist_remove(gatt->watchers, watcher);
+	remove_attio(gatt);
 }
 
 static int characteristic_set_value(struct characteristic *chr,
-- 
1.7.5.4

