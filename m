Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ 1/3] mesh: Fix for handling unprovisioned device
Date: Thu, 31 Aug 2017 12:12:55 +0200
Message-Id: <20170831101257.1644-1-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is no ServiceData there is no valid provisioning data for
PB-GATT
---
 mesh/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/main.c b/mesh/main.c
index b06f4352a..2289d7d10 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -503,7 +503,7 @@ static bool parse_service_data(GDBusProxy *proxy, const char *target_uuid,
 	}
 
 	if (!g_dbus_proxy_get_property(proxy, "ServiceData", &iter))
-		return true;
+		return false;
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
 		return false;
-- 
2.11.0

