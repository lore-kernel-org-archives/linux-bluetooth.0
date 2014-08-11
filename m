Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 10/10] obexd: Fix possible NULL dereference
Date: Mon, 11 Aug 2014 10:50:45 +0300
Message-Id: <1407743445-1329-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In a case snprintf fails we have NULL dereference. Fixes clang warnings
below:
...
obexd/client/map.c:471:9: warning: Access to field 'message' results in
a dereference of a null pointer (loaded from variable 'err')
                                                           err->message);
                                                           ^~~~~~~~~~~~
obexd/client/map.c:772:9: warning: Access to field 'message' results in
a dereference of a null pointer (loaded from variable 'err')
                                                           err->message);
                                                           ^~~~~~~~~~~~
...
---
 obexd/client/map.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 47afc31..ed535e2 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -468,7 +468,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 
 fail:
 	reply = g_dbus_create_error(message, ERROR_INTERFACE ".Failed", "%s",
-								err->message);
+						err ? err->message : "");
 	g_error_free(err);
 	return reply;
 }
@@ -769,7 +769,7 @@ static void set_status(const GDBusPropertyTable *property,
 
 fail:
 	g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed", "%s",
-								err->message);
+						err ? err->message : "");
 	g_error_free(err);
 }
 
-- 
1.9.1

