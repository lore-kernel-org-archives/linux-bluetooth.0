Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Fix crash due to misplaced parameter in emit_device_found() call
Date: Tue, 28 Dec 2010 12:52:30 -0400
Message-Id: <1293555150-9979-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To avoid related mistakes, dev->uuid_count was shortened to uuid_count
and kept on the same line.
---
Note that there is a 82-column line on this patch. I chose to put it
on the same line to avoid a similar mistake in future.
---
 src/adapter.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index bfc2b8b..816d842 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2841,9 +2841,9 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 				"RSSI", DBUS_TYPE_INT16, &rssi,
 				"Name", DBUS_TYPE_STRING, &dev->name,
 				"Paired", DBUS_TYPE_BOOLEAN, &paired,
-				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids,
 				"Broadcaster", DBUS_TYPE_BOOLEAN, &broadcaster,
-				dev->uuid_count, NULL);
+				"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
+				NULL);
 		return;
 	}
 
@@ -2867,7 +2867,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 			"Alias", DBUS_TYPE_STRING, &alias,
 			"LegacyPairing", DBUS_TYPE_BOOLEAN, &dev->legacy,
 			"Paired", DBUS_TYPE_BOOLEAN, &paired,
-			"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, dev->uuid_count,
+			"UUIDs", DBUS_TYPE_ARRAY, &dev->uuids, uuid_count,
 			NULL);
 
 	g_free(alias);
-- 
1.7.0.4

