Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ v2 1/1] doc: Add LE Advertisements to Service Manager
Date: Fri, 30 Jan 2015 11:53:02 -0800
Message-Id: <1422647582-12829-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1422647582-12829-1-git-send-email-jamuraa@chromium.org>
References: <1422647582-12829-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updates the documentation defining a service hierarchy which can be used
for defining LE Advertisement data, and register these advertisements
to be broadcast.
---
 doc/gatt-api.txt | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 85 insertions(+), 4 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index bfeaf6d..7fa9883 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -205,18 +205,77 @@ Properties	string UUID [read-only]
 			which a PropertiesChanged signal will be emitted.
 
 
+LE Advertisement Data hierarchy
+===============================
+
+Advertisement Data to be broadcast and parameters for such.  Properties which
+are not present will not be included.  Required advertisement data types will
+always be included.
+
+Service		org.bluez
+Interface	org.bluez.LEAdvertisement1
+Object path	[variable prefix]/{hci0,hci1,...}/ad_XX_XX_XX_XX_XX_XX
+
+Properties	string AdvertisingType
+
+			Determines the type of advertising packet requested.
+			Must be one of "connectable", "scannable", or
+			"nonconnectable".
+
+		array{string} ServiceUUIDs
+
+			List of UUIDs to include in the "Service UUID" field of
+			the Advertising Data. These will be compressed to 16-bit
+			or 32-bit addresses if appropriate to save space.
+
+		bool IncludeLocalName
+
+			If present and true, the local name will be included in
+			the Advertising Data. A partial name will be included if
+			enough space is not available
+
+		array{struct(uint16,array{byte})} ManufacturerSpecificData
+
+			Array of Manufactuer Specific Data fields to include in
+			the Advertising Data.  Each struct includes the
+			Manufacturer ID and the raw bytes to include.
+
+		bool IncludePower
+
+			If present and true, the TX Power Level will be included
+			in the Advertising Data.
+
+		array{string} SolicitUUIDs
+
+			Array of UUIDs to include in "Service Solicitation"
+			Advertisement Data. These will be compressed to 16-bit
+			or 32-bit addresses if appropriate to save space.
+
+		array{struct(string,array{byte})} ServiceData
+
+			Array of Service Data to include.  The string is the
+			UUID to include with the data, and will be compressed to
+			16 or 32 bit length if applicable.
+
+		bool IncludeAppearance
+
+			If present and true, the Appearance will be included
+			in the Advertising Data.
+
+
 Service Manager hierarchy
 =============================
 
-Service Manager allows external applications to register GATT based
-services. Services must follow the API for Service and Characteristic
-described above.
+The Service Manager allows external applications to register GATT based
+services and LE Advertisements. Services must follow the API for Service
+and Characteristic described above.  LE Advertisements must follow the API
+for LE Advertisement Data described above.
 
 Local GATT services, characteristics and characteristic descriptors are
 discovered automatically using the D-Bus Object Manager interface.
 
 Service		org.bluez
-Interface	org.bluez.GattManager1 [Experimental]
+Interface	org.bluez.ServiceManager1 [Experimental]
 Object path	/org/bluez
 
 Methods		RegisterService(object service, dict options)
@@ -243,3 +302,25 @@ Methods		RegisterService(object service, dict options)
 
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
+
+		RegisterAdvertisement(object advertisement, dict options)
+
+			Registers an advertisement object to be sent over the LE
+			Advertising channel.  The service must be exported
+			under interface LEAdvertisement1. The last segment of
+			the object path determines the advertiser's address used
+			and is assumed to be a random address unless it matches
+			the public address.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.AlreadyExists
+					 org.bluez.Error.InvalidLength
+
+		UnregisterAdvertisement(object advertisement)
+
+			This unregisters the advertisement that has been
+			prevously registered.  The object path parameter must
+			match the same value that has been used on registration.
+
+			Possible errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.DoesNotExist
-- 
2.2.0.rc0.207.ga3a616c

