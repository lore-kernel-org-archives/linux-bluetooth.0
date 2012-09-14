Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v0 1/4] device: Remove dead code from get_properties()
Date: Fri, 14 Sep 2012 21:40:08 +0530
Message-id: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 49021e4..77215f1 100644
--- a/src/device.c
+++ b/src/device.c
@@ -318,7 +318,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	bdaddr_t src;
-	char name[MAX_NAME_LENGTH + 1], srcaddr[18], dstaddr[18];
+	char name[MAX_NAME_LENGTH + 1], dstaddr[18];
 	char **str;
 	const char *ptr, *icon = NULL;
 	dbus_bool_t boolean;
@@ -348,7 +348,6 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	ptr = NULL;
 	memset(name, 0, sizeof(name));
 	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
 
 	ptr = device->name;
 	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &ptr);
-- 
1.7.4.1

