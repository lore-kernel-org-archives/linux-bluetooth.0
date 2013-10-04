Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/14] obexd/bluetooth: Remove unused local variables
Date: Fri, 4 Oct 2013 11:05:25 +0200
Message-ID: <1380877538-22614-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This ix following build errors:

  CC     obexd/plugins/obexd-bluetooth.o
obexd/plugins/bluetooth.c: In function ‘register_profile_reply’:
obexd/plugins/bluetooth.c:202:10: error: unused variable ‘err’
    [-Werror=unused-variable]

obexd/plugins/bluetooth.c: In function ‘name_acquired’:
obexd/plugins/bluetooth.c:367:15: error: unused variable ‘uuid’
    [-Werror=unused-variable]

obexd/plugins/bluetooth.c: In function ‘name_released’:
obexd/plugins/bluetooth.c:389:15: error: unused variable ‘uuid’
    [-Werror=unused-variable]

obexd/plugins/bluetooth.c: In function ‘bluetooth_start’:
obexd/plugins/bluetooth.c:400:10: error: unused variable ‘ios’
    [-Werror=unused-variable]
---
 obexd/plugins/bluetooth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 017ff60..7f8a26d 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -199,7 +199,6 @@ static void register_profile_reply(DBusPendingCall *call, void *user_data)
 	struct bluetooth_profile *profile = user_data;
 	DBusMessage *reply = dbus_pending_call_steal_reply(call);
 	DBusError derr;
-	GError *err = NULL;
 
 	dbus_error_init(&derr);
 	if (!dbus_set_error_from_message(&derr, reply)) {
@@ -364,7 +363,6 @@ static void name_acquired(DBusConnection *conn, void *user_data)
 
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
-		const char *uuid;
 
 		if (profile->path != NULL)
 			continue;
@@ -386,7 +384,6 @@ static void name_released(DBusConnection *conn, void *user_data)
 
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
-		const char *uuid;
 
 		if (profile->path == NULL)
 			continue;
@@ -397,7 +394,6 @@ static void name_released(DBusConnection *conn, void *user_data)
 
 static void *bluetooth_start(struct obex_server *server, int *err)
 {
-	GSList *ios = NULL;
 	const GSList *l;
 
 	for (l = server->drivers; l; l = l->next) {
-- 
1.8.4

