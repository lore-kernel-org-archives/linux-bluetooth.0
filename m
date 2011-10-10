Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Update control documentation to reflect the implementation
Date: Mon, 10 Oct 2011 14:07:40 +0300
Message-Id: <1318244860-9474-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Many of the methods and signal don't make much sense since we now have
a dedicated interfaces that are Media and MediaPlayer.
---
 doc/control-api.txt |   61 ++++----------------------------------------------
 1 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/doc/control-api.txt b/doc/control-api.txt
index e3a13e9..eacfbcd 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -12,13 +12,9 @@ Service		org.bluez
 Interface	org.bluez.Control
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		void Connect()
+Methods		boolean IsConnected() {deprecated}
 
-			Connect to remote device (CT or TG).
-
-		void Disconnect()
-
-			Disconnect remote device.
+			Returns True if connected, otherwise FALSE.
 
 		dict GetProperties()
 
@@ -33,63 +29,16 @@ Methods		void Connect()
 
 			Adjust remote volume one step down
 
-		boolean SendPassthrough(avc_operation_id key, boolean state,
-								string op_data)
-
-			Called to send Passthrough commands. ONLY valid if
-			BlueZ device is in CT role.
-
-		boolean SendVendorDependent(string op_data)
-
-			Called to send VendorDependent commands, other than
-			Metadata or Events defined in the AVRCP+Metadata
-			specification.
-
-Signals		Connected()
+Signals		Connected() {deprecated}
 
 			Sent when a successful AVRCP connection has been made
 			to the remote device.
 
-		Disconnected()
+		Disconnected() {deprecated}
 
 			Sent when the AVRCP connection to the remote device
 			has been disconnected.
 
-		Passthrough(uint8 key, boolean state, int32 company_id,
-								string op_data)
-
-			Called when Passthrough command is received from
-			connected device.
-
-			NOTE: according to the AV/C Subpanel Spec, company_id
-			and op_data are passed ONLY when the key is
-			"Vendor_Unique", or 0x7E.
-
-			When the key is NOT 0x7E, the signal returns
-			company_id=-1, and zero-length op_data.
-
-		VendorDependentReceived(string op_data)
-
-			Called when VendorDependent message is received from
-			connected device (except for Metadata defined in
-			Bluetooth SIG AVRCP+Metadata spec).
-
-Properties	uint8 SubUnitID [readonly]
-
-			The three-bit Subunit ID from the connected device.
-
-		uint8 SubUnitType [readonly]
-
-			The five-bit Subunit Type from the connected device.
+Properties
 
 		boolean Connected [readonly]
-
-		array{uint32} CompanyIDs [readonly]
-
-			List of three-byte Company IDs (OUI) supported by the
-			connected device. Note that Bluetooth SIG Company
-			ID (0x001958) is always included.
-
-		array{string} Capabilities [readonly]
-
-			List of Capabilities provided by the connected device.
-- 
1.7.6.4

