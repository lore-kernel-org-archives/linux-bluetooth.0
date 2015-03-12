Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [BlueZ 01/12] doc: Add LE Advertisement D-Bus API documentation
Date: Thu, 12 Mar 2015 10:11:48 -0700
Message-Id: <1426180319-16509-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
References: <1426180319-16509-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The LE Advertisement API allows external appications to define
persistent LE Advertisement Data packets.
---
 doc/advertising-api.txt | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 doc/advertising-api.txt

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
new file mode 100644
index 0000000..6bbe485
--- /dev/null
+++ b/doc/advertising-api.txt
@@ -0,0 +1,94 @@
+BlueZ D-Bus LE Advertising API Description
+******************************************
+
+Advertising packets are structured data which is broadcast on the LE Advertising
+channels and available for all devices in range.  Because of the limited space
+available in LE Advertising packets (32 bytes) , each packet's contents must be
+controllable.
+
+BlueZ acts as a store for the multiple sets of Advertisement Data which is meant
+to be sent.  It constructs the correct Advertisement Data from the structured
+data and communicates the sets of data to the kernel, where it is
+multiplexed.
+
+Advertisement Data objects are registered freely and then referenced by BlueZ
+when constructing the data sent to the kernel.
+
+LE Advertisement Data hierarchy
+===============================
+
+Specifies the Advertisement Data to be broadcast and some advertising
+parameters.  Properties which are not present will not be included in the
+data.  Required advertisement data types will always be included.
+All UUIDs are 128-bit versions in the API, and 16 or 32-bit
+versions of the same UUID will be used in the advertising data as appropriate.
+
+Service		org.bluez
+Interface	org.bluez.LEAdvertisement1
+Object path	freely definable
+
+Properties	string Type
+
+			Determines the type of advertising packet requested.
+
+			Possible values: "broadcast" or "peripheral"
+
+		array{string} ServiceUUIDs
+
+			List of UUIDs to include in the "Service UUID" field of
+			the Advertising Data.
+
+		dict ManufacturerSpecificData
+
+			Manufactuer Specific Data fields to include in
+			the Advertising Data.  Keys are the Manufacturer ID
+			to associate with the data.
+
+		bool IncludePower
+
+			If present and true, the TX Power Level will be included
+			in the Advertising Data.
+
+		array{string} SolicitUUIDs
+
+			Array of UUIDs to include in "Service Solicitation"
+			Advertisement Data.
+
+		dict ServiceData
+
+			Service Data elements to include. The keys are the
+			UUID to associate with the data.
+
+
+LE Advertising Manager hierarchy
+================================
+
+The Advertising Manager allows external applications to register Advertisement
+Data which should be broadcast to devices.  Advertisement Data elements must
+follow the API for LE Advertisement Data described above.
+
+Service		org.bluez
+Interface	org.bluez.LEAdvertisingManager1 [Experimental]
+Object path	/org/bluez/{hci0,hci1,...}
+
+Methods		RegisterAdvertisement(object advertisement, dict options)
+
+			Registers an advertisement object to be sent over the LE
+			Advertising channel.  The service must be exported
+			under interface LEAdvertisement1. InvalidArguments
+			indicates that the object has invalid or conflicting
+			properties.  InvalidLength indicates that the data
+			provided generates a data packet which is too long.
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

