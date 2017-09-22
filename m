Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/6] client: Fix core dump when using set-advertise-name
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Message-ID: <471ebaa0-8f5e-7dd9-ef95-652ddf5cf170@jp.fujitsu.com>
Date: Fri, 22 Sep 2017 21:19:30 +0900
MIME-Version: 1.0
In-Reply-To: <d5f5eeb2-9207-ae2e-231e-0826307926a9@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After setting local name, if repeating to set on/off of set-advertise-name
then bluetoothctl may dump core due to double free. This patch uses
secure g_free() instead of free().
---
 client/advertising.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index b105da9..bfdebd5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -547,8 +547,10 @@ void ad_advertise_name(DBusConnection *conn, bool value)
 
 	ad.name = value;
 
-	if (!value)
-		free(ad.local_name);
+	if (!value) {
+		g_free(ad.local_name);
+		ad.local_name = NULL;
+	}
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
 }
@@ -558,7 +560,7 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name)
 	if (ad.local_name && !strcmp(name, ad.local_name))
 		return;
 
-	free(ad.local_name);
+	g_free(ad.local_name);
 	ad.local_name = strdup(name);
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "LocalName");
-- 
2.7.4

