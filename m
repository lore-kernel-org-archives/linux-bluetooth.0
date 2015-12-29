Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Mike Ryan <mikeryan@lacklustre.net>
To: linux-bluetooth@vger.kernel.org
Cc: Mike Ryan <mikeryan@lacklustre.net>
Subject: [PATCH] doc: fix typos in mgmt-api.txt
Date: Mon, 28 Dec 2015 17:36:46 -0800
Message-Id: <1451353006-15664-1-git-send-email-mikeryan@lacklustre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d5b6c90..731a088 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -250,7 +250,7 @@ Read Controller Information Command
 				Name (249 Octets)
 				Short_Name (11 Octets)
 
-	This command is used to retreive the current state and basic
+	This command is used to retrieve the current state and basic
 	information of a controller. It is typically used right after
 	getting the response to the Read Controller Index List command
 	or an Index Added event.
@@ -762,8 +762,8 @@ Load Link Keys Command
 
 	This command is used to feed the kernel with currently known
 	link keys. The command does not need to be called again upon the
-	receiption of New Link Key events since the kernel updates its
-	list automatically.
+	receipt of New Link Key events since the kernel updates its list
+	automatically.
 
 	The Debug_Keys parameter is used to tell the kernel whether to
 	accept the usage of debug keys or not. The allowed values for
@@ -826,7 +826,7 @@ Load Long Term Keys Command
 
 	This command is used to feed the kernel with currently known
 	(SMP) Long Term Keys. The command does not need to be called
-	again upon the receiption of New Long Term Key events since the
+	again upon the receipt of New Long Term Key events since the
 	kernel updates its list automatically.
 
 	Possible values for the Address_Type parameter:
@@ -1023,7 +1023,7 @@ Pair Device Command
 
 	This command is used to trigger pairing with a remote device.
 	The IO_Capability command parameter is used to temporarily (for
-	this pairing event only) override the global IO Capaility (set
+	this pairing event only) override the global IO Capability (set
 	using the Set IO Capability command).
 
 	Possible values for the Address_Type parameter:
@@ -1567,7 +1567,7 @@ Set Device ID Command
 
 		0x0000	Disable Device ID
 		0x0001	Bluetooth SIG
-		0x0002	USB Implementer’s Forum
+		0x0002	USB Implementer's Forum
 
 	The information is put into the EIR data. If the controller does
 	not support EIR or if SSP is disabled, this command will still
@@ -1600,7 +1600,7 @@ Set Advertising Command
 
 	Using value 0x01 means that when connectable setting is disabled,
 	the advertising happens with undirected non-connectable advertising
-	packets and a non-resovable random address is used. If connectable
+	packets and a non-resolvable random address is used. If connectable
 	setting is enabled, then undirected connectable advertising packets
 	and the identity address or resolvable private address are used.
 
@@ -1822,12 +1822,13 @@ Set Privacy Command
 	discoverable and also when pairing is initiated.
 
 	With value 0x02 the kernel will use privacy mode with resolvable
-	private address. In case the conroller is bondable and discoverable
-	the identity address is used. Also when pairing is initiated, the
-	connection will be established with the identity address.
+	private address. In case the controller is bondable and
+	discoverable the identity address is used. Also when pairing is
+	initiated, the connection will be established with the identity
+	address.
 
 	Exposing the identity address when bondable and discoverable or
-	during initated pairing can be a privacy issue. For dual-mode
+	during initiated pairing can be a privacy issue. For dual-mode
 	controllers this can be neglected since its public address will
 	be exposed over BR/EDR anyway. The benefit of exposing the
 	identity address for pairing purposes is that it makes matching
@@ -1841,7 +1842,7 @@ Set Privacy Command
 	When the controller has a public address (mandatory for dual-mode
 	controllers) it is used as identity address. In case the controller
 	is single mode LE only without a public address, it is required
-	to configure a static random andress first. The privacy mode can
+	to configure a static random address first. The privacy mode can
 	only be enabled when an identity address is available.
 
 	The Identity_Resolving_Key is the local key assigned for the local
@@ -1870,7 +1871,7 @@ Load Identity Resolving Keys Command
 
 	This command is used to feed the kernel with currently known
 	identity resolving keys. The command does not need to be called
-	again upon the receiption of New Identity Resolving Key events
+	again upon the receipt of New Identity Resolving Key events
 	since the kernel updates its list automatically.
 
 	Possible values for the Address_Type parameter:
@@ -2063,7 +2064,7 @@ Load Connection Parameters Command
 					Address (6 Octets)
 					Address_Type (1 Octet)
 					Min_Connection_Interval (2 Octets)
-					Max_Connection_Interval (2 Octes)
+					Max_Connection_Interval (2 Octets)
 					Connection_Latency (2 Octets)
 					Supervision_Timeout (2 Octets)
 				}
@@ -2133,7 +2134,7 @@ Read Controller Configuration Information Command
 				Supported_Options (4 Octets)
 				Missing_Options (4 Octets)
 
-	This command is used to retreive the supported configuration
+	This command is used to retrieve the supported configuration
 	options of a controller and the missing configuration options.
 
 	The missing options are required to be configured before the
@@ -2194,7 +2195,7 @@ Set External Configuration Command
 	can be expected that it will be announced via Index Added event.
 
 	Wrongly configured controllers might still cause an error when
-	trying to power them via Set Powered commmand.
+	trying to power them via Set Powered command.
 
 	This command generates a Command Complete event on success or a
 	Command Status event on failure.
@@ -2431,7 +2432,7 @@ Read Extended Controller Index List Command
 		0x01	Unconfigured Controller (BR/EDR and/or LE)
 		0x02	Alternate MAC/PHY Controller (AMP)
 
-	The 0x00 and 0x01 types indiciate a primary BR/EDR and/or LE
+	The 0x00 and 0x01 types indicate a primary BR/EDR and/or LE
 	controller. The difference is just if they need extra configuration
 	or if they are fully configured.
 
@@ -2522,7 +2523,7 @@ Read Advertising Features Command
 	not be set.
 
 	The Flags bit 5 indicates support for automatically adding the
-	Apperance value to the scan response data. Users of this flag
+	Appearance value to the scan response data. Users of this flag
 	will decrease the Max_Scan_Rsp_len by 4 octets. The Appearance
 	field will be added in front of the scan response data provided
 	by the user. If the appearance value is not supported, then this
@@ -2728,7 +2729,7 @@ Get Advertising Size Information Command
 				Max_Scan_Rsp_Len (1 Octet)
 
 	The Read Advertising Features command returns the overall maximum
-	size of advertising data and scan respone data fields. That size is
+	size of advertising data and scan response data fields. That size is
 	valid when no Flags are used. However when certain Flags are used,
 	then the size might decrease. This command can be used to request
 	detailed information about the maximum available size.
@@ -2781,9 +2782,9 @@ Start Limited Discovery Command
 		7	BR/EDR/LE (interleaved discovery)
 
 	The limited discovery uses active scanning for Low Energy scanning
-	and will search for devices with the limited discoverabilty flag
+	and will search for devices with the limited discoverability flag
 	configured. On BR/EDR it uses LIAC and filters on the limited
-	discoverabilty flag of the class of device.
+	discoverability flag of the class of device.
 
 	When the discovery procedure starts the Discovery event will
 	notify this similar to Start Discovery.
@@ -2922,7 +2923,7 @@ New Link Key Event
 					PIN_Length (1 Octet)
 				}
 
-	This event indicates that a new link key has bee generated for a
+	This event indicates that a new link key has been generated for a
 	remote device.
 
 	The Store_Hint parameter indicates whether the host is expected
@@ -2948,7 +2949,7 @@ New Link Key Event
 		0x07	Unauthenticated Combination key from P-256
 		0x08	Authenticated Combination key from P-256
 
-	Receiving this event indicates that a pairing procecure has
+	Receiving this event indicates that a pairing procedure has
 	been completed.
 
 
@@ -2996,7 +2997,7 @@ New Long Term Key Event
 		0x03	Authenticated key from P-256
 		0x04	Debug key from P-256
 
-	Receiving this event indicates that a pairing procecure has
+	Receiving this event indicates that a pairing procedure has
 	been completed.
 
 
@@ -3301,7 +3302,7 @@ Device Unpaired Event
 		2	LE Random
 
 	For devices using resolvable random addresses with a known
-	identity resolving key, the event paramters will contain
+	identity resolving key, the event parameters will contain
 	the identity. After receiving this event, the device will
 	become essentially private again.
 
@@ -3479,7 +3480,7 @@ New Connection Parameter Event
 					Address (6 Octets)
 					Address_Type (1 Octet)
 					Min_Connection_Interval (2 Octets)
-					Max_Connection_Interval (2 Octes)
+					Max_Connection_Interval (2 Octets)
 					Connection_Latency (2 Octets)
 					Supervision_Timeout (2 Octets)
 				}
-- 
2.1.4

