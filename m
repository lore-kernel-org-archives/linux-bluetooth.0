Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 2/5] client: Fix core dump when using
 set-advertise-name
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Message-ID: <8bfdc7d6-75d1-1fc9-6a23-c5d3ef962544@jp.fujitsu.com>
Date: Mon, 25 Sep 2017 13:30:56 +0900
MIME-Version: 1.0
In-Reply-To: <f2c9e252-ce40-25e7-c814-84247157ce6d@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If repeating to set on/off with set-advertise-name after setting local
name, and then may dump core by double free. This patch uses g_free()
instead of free().
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


