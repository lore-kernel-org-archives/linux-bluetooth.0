Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 6/7] proximity: Remove list of adapter devices
Date: Fri, 31 Aug 2012 14:48:32 +0200
Message-ID: <1346417314-25109-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

List of adapter devices is only used to remove them when adapter is removed.
There's no need to do this since devices will be removed before adapter is
removed anyway.
---
 profiles/proximity/reporter.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 9b430f7..cf52548 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -51,7 +51,6 @@
 
 struct reporter_adapter {
 	struct btd_adapter *adapter;
-	GSList *devices;
 };
 
 static GSList *reporter_adapters;
@@ -192,7 +191,6 @@ static const GDBusSignalTable reporter_signals[] = {
 static void unregister_reporter_device(gpointer data, gpointer user_data)
 {
 	struct btd_device *device = data;
-	struct reporter_adapter *radapter = user_data;
 	const char *path = device_get_path(device);
 
 	DBG("unregister on device %s", path);
@@ -200,7 +198,6 @@ static void unregister_reporter_device(gpointer data, gpointer user_data)
 	g_dbus_unregister_interface(get_dbus_connection(), path,
 					PROXIMITY_REPORTER_INTERFACE);
 
-	radapter->devices = g_slist_remove(radapter->devices, device);
 	btd_device_unref(device);
 }
 
@@ -217,7 +214,6 @@ static void register_reporter_device(struct btd_device *device,
 					NULL, device, NULL);
 
 	btd_device_ref(device);
-	radapter->devices = g_slist_prepend(radapter->devices, device);
 }
 
 int reporter_device_probe(struct btd_device *device, GSList *uuids)
@@ -268,9 +264,6 @@ void reporter_adapter_remove(struct btd_adapter *adapter)
 	if (!radapter)
 		return;
 
-	g_slist_foreach(radapter->devices, unregister_reporter_device,
-								radapter);
-
 	link_loss_unregister(adapter);
 	imm_alert_unregister(adapter);
 
-- 
1.7.11.3

