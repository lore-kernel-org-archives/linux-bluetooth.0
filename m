Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add new command for reading local OOB extended data information
Date: Thu, 22 Jan 2015 21:17:58 -0800
Message-Id: <1421990278-19492-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 53600ec5b10e..ec930d6eaf63 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1287,8 +1287,16 @@ Add Remote Out Of Band Data Command
 	Secure Connections is disabled, then of course this is the
 	same as not providing any data at all.
 
-	When providing data for remote LE devices, then the P-192 fields
-	are not used and shall be set to zero value.
+	When providing data for remote LE devices, then the Hash_192 field
+	is used to provide the Security Manager TK Value. The Randomizer_192
+	field is not used and shall be set to zero. The Hash_192 value can
+	also be set to zero and that means that no Out Of Band data for
+	LE legacy pairing is provided.
+
+	The Hash_256 and Randomizer_256 fields can be used for LE secure
+	connections Out Of Band data. If only LE secure connections data
+	is provided the Hash_P192 and Randomizer_P192 fields can be set
+	to zero.
 
 	This command can be used when the controller is not powered and
 	all settings will be programmed once powered.
@@ -2221,6 +2229,86 @@ Start Service Discovery Command
 				Invalid Index
 
 
+Read Local Out Of Band Extended Data Command
+============================================
+
+	Command Code:		0x003b
+	Controller Index:	<controller id>
+	Command Parameters:	Address_Type (1 Octet)
+	Return Parameters:	Address_Type (1 Octet)
+				EIR_Data_Length (2 Octets)
+				EIR_Data (0-65535 Octets)
+
+	This command is used to read the local Out of Band data
+	information and provide them encoded as extended inquiry
+	response information or advertising data.
+
+	Possible values for the Address_Type parameter are a bit-wise or
+	of the following bits:
+
+		0	BR/EDR
+		1	LE Public
+		2	LE Random
+
+	By combining these e.g. the following values are possible:
+
+		1	BR/EDR
+		6	LE (public & random)
+		7	Reserved (not in use)
+
+	For BR/EDR controller (Address_Type 1) the returned information
+	will contain the following information:
+
+		Class of Device
+		Simple Pairing Hash C-192
+		Simple Pairing Randomizer R-192
+		Simple Pairing Hash C-256 (optional)
+		Simple Pairing Randomizer R-256 (optional)
+		Service Class UUID (optional)
+		Bluetooth Local Name (optional)
+
+	The Simple Pairing Hash C-256 and Simple Pairing Randomizer R-256
+	fields are only included when secure connections has been enabled.
+
+	The Device Address (BD_ADDR) is not included in the EIR_Data and
+	needs to be taken from controller information.
+
+	For LE controller (Address_Type 6) the returned information
+	will contain the following information:
+
+		LE Bluetooth Device Address
+		LE Role
+		Security Manager TK Value
+		Simple Pairing Hash C-256 (optional)
+		Simple Pairing Randomizer R-256 (optional)
+		Appearance (optional)
+		Local Name (optional)
+		Flags
+
+	The Simple Pairing Hash C-256 and Simple Pairing Randomizer R-256
+	fields are only included when secure connections has been enabled.
+
+	The returned information from BR/EDR controller and LE controller
+	types are not related to each other. Once they have been used
+	over an Out Of Band link, a new set of information shall be
+	requested.
+
+	This command can only be used when the controller is powered.
+
+	Values returned by this command become invalid when the controller
+	is powered down. After each power-cycle it is required to call
+	this command again to get updated information.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Not Supported
+				Busy
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
2.1.0

