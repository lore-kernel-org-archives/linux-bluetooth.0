Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] tools/btpclient: Fix ad property manufacturer data name
Date: Mon, 12 Feb 2018 17:00:59 +0100
Message-Id: <20180212160102.31451-1-grzegorz.kolodziejczyk@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes wrong naming of advertising instance data property.
---
 tools/btpclient.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 097732eb8..61bde820e 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -971,7 +971,7 @@ static void setup_ad_interface(struct l_dbus_interface *interface)
 						ad_serviceuuids_getter, NULL);
 	l_dbus_interface_property(interface, "ServiceData", 0, "a{sv}",
 						ad_servicedata_getter, NULL);
-	l_dbus_interface_property(interface, "ManufacturerServiceData", 0,
+	l_dbus_interface_property(interface, "ManufacturerData", 0,
 					"a{qv}", ad_manufacturerdata_getter,
 					NULL);
 	l_dbus_interface_property(interface, "Includes", 0, "as",
-- 
2.13.6

