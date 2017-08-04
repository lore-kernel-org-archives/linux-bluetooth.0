Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/7] advertising: Rename AdvertisementInstaces to AdvertisingInstaces
Date: Fri,  4 Aug 2017 15:21:02 +0300
Message-Id: <20170804122108.26472-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is consitent with tha name of the interface, also make it
experimental since AdvertisingManager.
---
 doc/advertising-api.txt | 2 +-
 src/advertising.c       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 7a29b7095..cee6878f6 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -113,6 +113,6 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
 
-Properties	byte AdvertisementInstaces
+Properties	byte AdvertisingInstances
 
 			Number of available advertisement instances.
diff --git a/src/advertising.c b/src/advertising.c
index c2af3acb4..c628f0fd5 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -739,7 +739,8 @@ static gboolean get_instances(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable properties[] = {
-	{ "AdvertisementInstances", "y", get_instances },
+	{ "AdvertisingInstances", "y", get_instances, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 };
 
 static const GDBusMethodTable methods[] = {
-- 
2.13.3

