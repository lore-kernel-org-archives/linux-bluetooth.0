Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 3/7] attrib-api: Remove GATT service hierarchy
Date: Mon, 23 Jul 2012 11:55:16 -0400
Message-Id: <1343058920-18608-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/attribute-api.txt |   54 -------------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 6560b53..4c29f66 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -12,60 +12,6 @@ service that contains it, so clients can identify the correct characteristic if
 multiple services contain the same characteristic.
 
 
-Device Service hierarchy
-========================
-
-Service		org.bluez
-Interface	org.bluez.Characteristic
-Object path	[prefix]/{hci0}/{device0}/{service0, service1, ...}
-		[prefix]/{hci0}/{device1}/{service0, service1, ...}
-
-Methods 	dict GetProperties()
-
-			Returns all properties for the interface. See the
-			Properties section for the available properties.
-
-		array{object} DiscoverCharacteristics()
-
-			Discover all characteristics that belongs in this service.
-			When it returns all the characteristics paths will be
-			already registered. It will return the characteristics paths
-			as soon as they are discovered. After that it will try to
-			read all values.
-
-		RegisterCharacteristicsWatcher(object agent)
-
-			Register a watcher to monitor characteristic changes.
-
-			A watcher will be registered for this service and will
-			notify about any changed characteristics in the service.
-			This also notifies about any included characteristics.
-
-		UnregisterCharacteristicsWatcher(object agent)
-
-			Unregister a watcher.
-
-Properties	string Name (mandatory) [readonly]
-
-			General name of service
-
-		string Description (optional) [readonly]
-
-			Description of service
-
-		string UUID (mandatory) [readonly]
-
-			UUID of service. Service class value for SDP and GATT
-			UUID for attribute based services.
-
-		array{object} Characteristics [readonly]
-
-			This list contains the characteristics owned by this
-			specific service and other characteristics from service
-			includes. That way no complicated service includes array
-			is needed.
-
-
 Device Characteristic hierarchy
 ===============================
 
-- 
1.7.9.5

