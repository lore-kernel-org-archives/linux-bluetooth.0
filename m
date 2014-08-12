Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/5] obexd: Fix possible NULL dereference
Date: Tue, 12 Aug 2014 15:46:36 +0300
Message-Id: <1407847596-14781-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <20140812090449.GA18519@t440s.ger.corp.intel.com>
 <1407847596-14781-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove snprintf error check. Fixes clang warnings below:
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
 obexd/client/map.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 47afc31..520e492 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -447,8 +447,7 @@ static DBusMessage *map_msg_get(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
-	if (snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle) < 0)
-		goto fail;
+	snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle);
 
 	transfer = obc_transfer_get("x-bt/message", handle, target_file, &err);
 	if (transfer == NULL)
@@ -746,8 +745,7 @@ static void set_status(const GDBusPropertyTable *property,
 
 	contents[0] = FILLER_BYTE;
 
-	if (snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle) < 0)
-		goto fail;
+	snprintf(handle, sizeof(handle), "%" PRIx64, msg->handle);
 
 	transfer = obc_transfer_put("x-bt/messageStatus", handle, NULL,
 					contents, sizeof(contents), &err);
-- 
1.9.1

