Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] gatt: Fix proxies list iteration
Date: Thu, 27 Mar 2014 16:45:02 -0300
Message-Id: <1395949502-30266-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/gatt-dbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 95d1243..4456ec0 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -297,7 +297,7 @@ static int register_external_characteristics(GSList *proxies)
 {
 	GSList *list;
 
-	for (list = proxies; list; list = g_slist_next(proxies)) {
+	for (list = proxies; list; list = g_slist_next(list)) {
 		DBusMessageIter iter;
 		const char *str, *path;
 		bt_uuid_t uuid;
-- 
1.8.3.1

