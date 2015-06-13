Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v8 02/15] doc/mgmt-api: fix typos
Date: Sat, 13 Jun 2015 05:42:46 +0200
Message-Id: <1434166979-21824-3-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
References: <1432603329-12846-1-git-send-email-fgrandel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a few minor typos and grammar errors in the mgmt api
spec.
---
 doc/mgmt-api.txt | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 0ac8267..f6d9e93 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -385,7 +385,7 @@ Set Connectable Command
 	and for LE controllers it changes the advertising type. For
 	dual mode controllers it affects both settings.
 
-	For LE capable controllers the connectable setting takes affect
+	For LE capable controllers the connectable setting takes effect
 	when advertising is enabled (peripheral) or when directed
 	advertising events are received (central).
 
@@ -886,7 +886,7 @@ Get Connections Command
 				Address2 { }
 				...
 
-	This command is used to retreive a list of currently connected
+	This command is used to retrieve a list of currently connected
 	devices.
 
 	Possible values for the Address_Type parameter:
@@ -1038,7 +1038,7 @@ Pair Device Command
 
 	To allow tracking of which resolvable random address changed
 	into which identity address, the New Identity Resolving Key
-	event will be send before receiving Command Complete event
+	event will be sent before receiving Command Complete event
 	for this command.
 
 	This command can only be used when the controller is powered.
@@ -1479,7 +1479,7 @@ Block Device Command
 				Address_Type (1 Octet)
 
 	This command is used to add a device to the list of devices
-	which should be blocked from being connect to the local
+	which should be blocked from being connected to the local
 	controller.
 
 	Possible values for the Address_Type parameter:
@@ -1487,7 +1487,7 @@ Block Device Command
 		1	LE Public
 		2	LE Random
 
-	For Low Energy devices, the blocking of a device take presedence
+	For Low Energy devices, the blocking of a device takes precedence
 	over auto-connection actions provided by Add Device. Blocked
 	devices will not be auto-connected or even reported when found
 	during background scanning. If the controller is connectable
@@ -1557,9 +1557,9 @@ Set Device ID Command
 		0x0001	Bluetooth SIG
 		0x0002	USB Implementer’s Forum
 
-	The information are put into the EIR data. If the controller does
+	The information is put into the EIR data. If the controller does
 	not support EIR or if SSP is disabled, this command will still
-	succeed. The information are stored for later use and will survive
+	succeed. The information is stored for later use and will survive
 	toggling SSP on and off.
 
 	This command generates a Command Complete event on success or
@@ -1978,17 +1978,17 @@ Add Device Command
 		2	Auto-connect remote device
 
 	With the Action 0, when the device is found, a new Device Found
-	event will be send indicating this device is available. This
+	event will be sent indicating this device is available. This
 	action is only valid for LE Public and LE Random address types.
 
 	With the Action 1, the device is allowed to connect. For BR/EDR
 	address type this means an incoming connection. For LE Public
 	and LE Random address types, a connection will be established
 	to devices using directed advertising. If successful a Device
-	Connected event will be send.
+	Connected event will be sent.
 
 	With the Action 2, when the device is found, it will be connected
-	and if successful a Device Connected event will be send. This
+	and if successful a Device Connected event will be sent. This
 	action is only valid for LE Public and LE Random address types.
 
 	When a device is blocked using Block Device command, then it is
@@ -2219,8 +2219,8 @@ Set Public Address Command
 
 	For a fully configured controller, the current controller index
 	will become invalid and an Unconfigured Index Removed event will
-	be send. Once the address has been successfully changed an Index
-	Added event will be send. There is no guarantee that the controller
+	be sent. Once the address has been successfully changed an Index
+	Added event will be sent. There is no guarantee that the controller
 	index stays the same.
 
 	All previous configured parameters and settings are lost when
@@ -2535,7 +2535,7 @@ Read Advertising Features Command
 	however might decrease the actual available length in these
 	data fields.
 
-	With Num_Instances and Instance array the current occupied
+	With Num_Instances and Instance array the currently occupied
 	Instance identifiers can be retrieved.
 
 	This command generates a Command Complete event on success or
@@ -2621,13 +2621,13 @@ Add Advertising Command
 
 	The Timeout parameter configures the life-time of an Instance. In
 	case the value 0 is used it indicates no expiration time. If a
-	timeout value is provided, then the advertising Instace will be
+	timeout value is provided, then the advertising Instance will be
 	automatically removed when the timeout passes. The value for the
 	timeout is in seconds. Powering down a controller will invalidate
 	all advertising Instances and it is not possible to add a new
 	Instance with a timeout when the controller is powered down.
 
-	When a Timeout is provided, then the Duration substracts from
+	When a Timeout is provided, then the Duration subtracts from
 	the actual Timeout value of that Instance. For example an Instance
 	with Timeout of 5 and Duration of 2 will be scheduled exactly 3
 	times, twice with 2 seconds and once with one second. Other
-- 
1.9.1

