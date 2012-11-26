Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] service: Fix not unreferencing adapter in case of error
Date: Mon, 26 Nov 2012 10:07:36 +0100
Message-ID: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If g_dbus_register_interface failed adapter reference was not dropped.
Move getting reference after succesful g_dbus_register_interface call.
---
 plugins/service.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index ba7a693..d70c515 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -509,9 +509,6 @@ static int register_interface(const char *path, struct btd_adapter *adapter)
 	if (serv_adapter == NULL)
 		return -ENOMEM;
 
-	if (adapter != NULL)
-		serv_adapter->adapter = btd_adapter_ref(adapter);
-
 	serv_adapter->pending_list = NULL;
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
@@ -520,13 +517,16 @@ static int register_interface(const char *path, struct btd_adapter *adapter)
 						path_unregister) == FALSE) {
 		error("D-Bus failed to register %s interface",
 							SERVICE_INTERFACE);
+
 		g_free(serv_adapter);
 		return -EIO;
 	}
 
 	DBG("Registered interface %s on path %s", SERVICE_INTERFACE, path);
 
-	if (serv_adapter->adapter == NULL)
+	if (adapter != NULL)
+		serv_adapter->adapter = btd_adapter_ref(adapter);
+	else
 		serv_adapter_any = serv_adapter;
 
 	return 0;
-- 
1.7.9.5

