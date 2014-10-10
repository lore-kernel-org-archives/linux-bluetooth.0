Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] doc: Add commands for Start Service Discovery and Stop Service Discovery
Date: Fri, 10 Oct 2014 12:49:17 +0200
Message-Id: <1412938157-70760-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index daf036b4c1ec..2038f883cc95 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2135,6 +2135,89 @@ Set Public Address Command
 				Invalid Index
 
 
+Start Service Discovery Command
+===============================
+
+	Command Code:		0x003a
+	Controller Index:	<controller id>
+	Command Parameters:	Address_Type (1 Octet)
+				RSSI_Threshold (1 Octet)
+				Num_UUID (1 Octet)
+				UUID[i] (16 Octets)
+	Return Parameters:	Address_Type (1 Octet)
+
+	This command is used to start the process of discovering remote
+	devices with a specific UUID. A Device Found event will be sent
+	for each discovered device.
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
+		7	BR/EDR/LE (interleaved discovery)
+
+	The service discovery uses active scanning for Low Energy scanning
+	and will search for UUID in both advertising data and scan response
+	data.
+
+	Found devices that have a RSSI value smaller than RSSI_Threshold
+	are not reported via DeviceFound event. Setting a value of 127
+	will cause all devices to be reported.
+
+	The list of UUIDs identifies a logical OR. Only one of the UUIDs
+	have to match to cause a DeviceFound event. Providing an empty
+	list of UUIDs with Num_UUID set to 0 which means that DeviceFound
+	events are send out for all devices above the RSSI_Threshold.
+
+	In case the RSSI_Threshold is set to 127 and the Num_UUID is 0,
+	then this command behaves exactly the same as Start Discovery.
+
+	When the discovery procedure starts the Discovery event will
+	notify this similar to Start Discovery.
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Busy
+				Not Supported
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Stop Service Discovery Command
+==============================
+
+	Command Code:		0x003b
+	Controller Index:	<controller id>
+	Command Parameters:	Address_Type (1 Octet)
+	Return Parameters:	Address_Type (1 Octet)
+
+	This command is used to stop the service discovery process started
+	using the Start Service Discovery command.
+
+	When the discovery procedure stops the Discovery event will
+	notify this similar to Stop Discovery.
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Rejected
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -2555,7 +2638,10 @@ Discovering Event
 
 	This event indicates that the controller has started discovering
 	devices. This discovering state can come and go multiple times
-	between a StartDiscover and a StopDiscovery command.
+	between a Start Discover and a Stop Discovery commands.
+
+	The Start Service Discovery and Stop Service Discovery commands
+	will also trigger this event.
 
 	The valid values for the Discovering parameter are 0x01
 	(enabled) and 0x00 (disabled).
-- 
1.9.3

