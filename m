Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 02/17] gdbus/client: Don't GetManagedObjects w/o handlers
Date: Wed, 25 Feb 2015 21:13:15 -0800
Message-Id: <1424927610-26226-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The client code currently issues GetManagedObjects if new handlers are
set via g_dbus_client_set_proxy_handlers. An application may set these
to NULL before unref'ing a client or to simply prevent further events.
Hence, there is no need to refresh objects or properties if all handlers
are NULL.
---
 gdbus/client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index 238b348..cd5c767 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -1374,7 +1374,8 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient *client,
 	client->property_changed = property_changed;
 	client->user_data = user_data;
 
-	get_managed_objects(client);
+	if (proxy_added || proxy_removed || property_changed)
+		get_managed_objects(client);
 
 	return TRUE;
 }
-- 
2.2.0.rc0.207.ga3a616c

