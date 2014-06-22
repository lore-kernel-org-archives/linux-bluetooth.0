Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] doc: Add extra mode for a reduced LE privacy mode
Date: Sun, 22 Jun 2014 18:37:22 +0200
Message-Id: <1403455042-40699-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 5a7d2ef0e5d3..76a70960e3e7 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1661,8 +1661,29 @@ Set Privacy Command
 	This command is used to enable Low Energy Privacy feature using
 	resolvable private addresses.
 
-	The value 0x00 disables privacy mode, the value 0x01 enables
-	privacy mode.
+	The value 0x00 disables privacy mode, the values 0x01 and 0x02
+	enable privacy mode.
+
+	With value 0x01 the kernel will always use the privacy mode. This
+	means resolvable private address is used when the controller is
+	discoverable and also when pairing is initiated.
+
+	With value 0x02 the kernel will use privacy mode with resolvable
+	private address. In case the conroller is pairable and discoverable
+	the identity address is used. Also when pairing is initiated, the
+	connection will be established with the identity address.
+
+	Exposing the identity address when pairable and discoverable or
+	during initated pairing can be a privacy issue. For dual-mode
+	controllers this can be neglected since its public address will
+	be exposed over BR/EDR anyway. The benefit of exposing the
+	identity address for pairing purposes is that it makes matching
+	up devices with dual-mode topology during device discovery now
+	possible.
+
+	If the privacy value 0x02 is used, then also the GATT database
+	should expose the Privacy Characteristic so that remote devices
+	can determine if the privacy feature is in use or not.
 
 	When the controller has a public address (mandatory for dual-mode
 	controllers) it is used as identity address. In case the controller
@@ -2289,6 +2310,17 @@ New Identity Resolving Key Event
 	This event also indicates that now the identity address should
 	be used for commands instead of the resolvable random address.
 
+	It is possible that some devices allow discovering via its
+	identity address, but after pairing using resolvable private
+	address only. In such a case Store_Hint will be 0x00 and the
+	Random_Address wil indicate 00:00:00:00:00:00. For these devices,
+	the Privacy Characteristic of the remote GATT database should
+	be consulted to decide if the identity resolving key must be
+	stored persistently or not.
+
+	Devices using Set Privacy command with the option 0x02 would
+	be such type of device.
+
 	Possible values for the Address_Type parameter:
 		0	Reserved (not in use)
 		1	LE Public
-- 
1.9.3

