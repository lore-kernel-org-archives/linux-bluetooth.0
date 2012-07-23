Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 4/7] attrib-api: Update Characteristic interface
Date: Mon, 23 Jul 2012 11:55:17 -0400
Message-Id: <1343058920-18608-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1343058920-18608-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/attribute-api.txt |   97 +++++++++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
index 4c29f66..4f7dd40 100644
--- a/doc/attribute-api.txt
+++ b/doc/attribute-api.txt
@@ -11,67 +11,92 @@ object has a "ServiceUUID" property which contains the 128-bit UUID of the
 service that contains it, so clients can identify the correct characteristic if
 multiple services contain the same characteristic.
 
+This API is used for both local (added to the BlueZ GATT server) and remote
+(found by GATT discovery) services.
 
 Device Characteristic hierarchy
 ===============================
 
 Service		org.bluez
 Interface	org.bluez.Characteristic
-Object path	[prefix]/{hci0}/{device0}/{service0}/{characteristic0,...}
-		[prefix]/{hci0}/{device0}/{service1}/{characteristic0,...}
+Object path	freely definable
+
+For local characteristics, it is recommended (for readability and debugging
+purposes) to have the object path prefix as "[freely definable]/[busid]" where
+"[busid]" is the application's D-Bus address. For remote characteristics, the
+device address is added to the prefix. E.g.:
+
+[freely definable]/[busid]/characteristic_1803_2A06 (local)
+[freely definable]/dev_XX_XX_XX_XX_XX_XX/characteristic_1803_2A06 (remote)
+
+Methods		void SetValue(array{byte} value)
+
+			Update characteristic value.
+
+			For a remote characteristic, this method triggers a
+			GATT characteristic value write procedure setting a new
+			value for this characteristic. The GATT sub-procedure
+			is automatically selected based on the characteristic
+			properties and value length.
+
+		dict GetValue()
+
+			Read characteristic value and descriptors. The returned
+			dictionary has the following format:
 
-Methods		dict GetProperties()
+			{
+				"value": array{byte},
+				"formatted value": string,
+				// Optional descriptors
+				"client configuration": uint16,
+				"server configuration": uint16,
+				"extended properties": uint16,
+				"user description": string,
+				// For unknown descriptors, use 128-bit UUID
+				// as key
+				"uuid": array{byte},
+			}
 
-			Returns all properties for the characteristic. See the
-			properties section for available properties.
+Properties	string UUID [readonly]
 
-		void SetProperty(string name, variant value)
+			128-bit UUID of this characteristic.
 
-			Changes the value of the specified property. Only
-			read-write properties can be changed. On success
-			this will emit a PropertyChanged signal.
+		string ServiceUUID [readonly]
 
-			Possible Errors: org.bluez.Error.InvalidArguments
+			128-bit UUID of the service which includes this
+			characteristic.
 
-Properties 	string UUID [readonly]
+		boolean Read [readonly]
 
-			UUID128 of this characteristic.
+			Characteristic value can be read.
 
-		string Name [readonly]
+		boolean WriteWithoutResponse [readonly]
 
-			Optional field containing a friendly name for the
-			Characteristic UUID.
+			Characteristic value can be written using GATT Write
+			Without Response sub-procedure.
 
-		string Description [readonly]
+		boolean Write [readonly]
 
-			Textual optional characteristic descriptor describing
-			the Characteristic Value.
+			Characteristic value can be written using GATT Write
+			Characteristic Value sub-procedures.
 
-		struct Format [readonly]
+		boolean Notify [readonly]
 
-			Optional Characteristic descriptor which defines the
-			format of the Characteristic Value. For numeric
-			values, the actual value can be value * 10^Exponent.
-			NameSpace and Description are defined on the Assigned
-			Number Specification.
+			Characteristic value can be notified.
 
-			  uint8  | Format: format of the value
-			  uint8  | Exponent: Field to determine how the value is
-			         | further formatted.
-			  uint16 | Unit: unit of the characteristic
-			  uint8  | NameSpace: Name space of description.
-			  uint16 | Description: Description of the characteristic defined
-			         | in a high layer profile.
+		boolean Indicate [readonly]
 
-		array{byte} Value [readwrite]
+			Characteristic value can be indicated.
 
-			Raw value of the Characteristic Value attribute.
+		boolean AuthenticatedSignedWrites [readonly]
 
-		string Representation (of the binary Value) [readonly]
+			Characteristic value can be written using GATT Signed
+			Write Without Response sub-procedure.
 
-			Friendly representation of the Characteristic Value
-			based on the format attribute.
+		boolean ExtendedProperties [readonly]
 
+			Characteristic contains additional properties defined
+			on the Extended Properties descriptor.
 
 Characteristic Watcher hierarchy
 ===============================
-- 
1.7.9.5

