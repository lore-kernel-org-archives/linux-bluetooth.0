Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [RFC BlueZ 1/1] doc: Add Advertising API documentation
Date: Wed, 28 Jan 2015 10:52:16 -0800
Message-Id: <1422471136-18575-2-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1422471136-18575-1-git-send-email-jamuraa@chromium.org>
References: <1422471136-18575-1-git-send-email-jamuraa@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/advertising-api.txt | 124 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 doc/advertising-api.txt

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
new file mode 100644
index 0000000..6a325c7
--- /dev/null
+++ b/doc/advertising-api.txt
@@ -0,0 +1,124 @@
+LE Advertising Manager
+======================
+
+LE Advertising Manager allows external applications to control the activity and
+the content of LE Advertising Events.  Applications may use the properties of
+this object to modify the advertising data elements included in Advertising
+Events, and enable and disable advertising.
+
+Service		org.bluez
+Interface	org.bluez.LEAdvertisingManager1
+Object path	/org/bluez/hciX
+
+Methods		bool Advertise(int duration)
+
+			Begins advertising this device according to the
+			settings.  Advertisement is enabled for duration seconds
+			from method invocation.  A duration of -1 will
+			continuously advertise.  To disable advertisement early,
+			set duration to 0.
+
+			Possible errors: org.bluez.Error.NoData
+
+		void AdvertiseServiceUUID(string)
+
+			This method adds a UUID to the set of services which
+			should be included in the advertisement.  Use
+			UnadvertiseServiceUUID to remove items from the list.
+			GAP and GATT services cannot be added to the list.
+
+			Possible errors: org.bluez.Error.AlreadyExists
+					 org.bluez.Error.InvalidArgument
+
+		void UnadvertiseServiceUUID(string)
+			This method removes a UUID from the set of services
+			which are included in the advertisement.
+
+			Possible errors: org.bluez.Error.DoesNotExist
+
+Properties	array{string} IncludedTypes
+
+			Indicates the data types which are included in the
+			advertising data, and their order in the packet.  If the
+			advertising data is too long, types that do not fit will
+			be ignored, and the next type will be included if it
+			does fit.  An exception to this is the "service-uuids"
+			and the "local-name" type which will be shortened to fit
+			as allowed by the specification.
+
+			The strings used for each type defined in the Core
+			Specification Supplement and are indicated by these
+			strings:
+			* "service-uuids" - A list of Service UUIDs
+			* "local-name" - Device name as defined by GAP
+			* "flags" - the Advertising data flags
+			* "manufacturer-data" - Manufacturer specific data
+			* "tx-power" - TX Power Level
+			* "slave-connection-interval" - Slave connection
+				interval range for logical connections
+			* "solicit-uuids" - Service Solicitation UUIDs
+			* "service-data" - Service Data
+			* "appearance" - Appearance as defined by GAP
+			* "public-target-address" - Public Target Address
+			* "random-target-address" - Random Target Address
+			* "advertising-interval" - Advertising Interval
+			* "le-address" - LE Device Address
+			* "le-role" - LE Role
+
+			Defaults to: ["flags", "local-name"]
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+
+		array(string) AdvertisedUUIDs (read-only)
+
+			Sorted List of UUIDs which are currently included in the
+			"service-uuids" advertisement data type.
+
+		int Flags
+
+			bitfield of Boolean flags as defined in the Core
+			Specification Supplement, Part A.1.3.2
+
+		array(array{byte}) ManufacturerSpecificData
+
+			Manufacturer specific data.  Each entry is transmitted
+			as a a separate advertisement data type.
+
+		array(string) SolicitUUIDs
+
+			List of UUIDs to include in the
+			"service-solicitation" advertisement data.
+
+		dict(string,array{byte}) ServiceData
+
+			Dictionary of Service UUIDs attached to data associated
+			with that service to include in the "service-data"
+			advertisement data.
+
+		array{byte} TargetAddress
+
+			Target Address to use in the "random-target-address" or
+			"public-target-address"
+
+		int AdvertisingInterval
+
+			The interval to advertise at, in 0.625ms units.  Minimum
+			is 32 (20ms), maximum is 16384 (10.24s)
+
+			Possible Errors: org.bluez.Error.InvalidArgument
+
+		array{byte} LEAddress
+
+			Address to advertise as the LE Address for this device.
+
+		string LEPreferred
+
+			The preferred role of this device if it supports both
+			Central and Peripheral roles.  One of "central" or
+			"peripheral".  This influences the advertised value of
+			the "le-role" advertising data type when both modes are
+			supported.
+
+		int AdvertisingLength (read-only)
+
+			Calculated length of the Advertising Data packet.
-- 
2.2.0.rc0.207.ga3a616c

