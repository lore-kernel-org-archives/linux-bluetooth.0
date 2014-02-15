Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Add management commands and events for privacy support
Date: Sat, 15 Feb 2014 02:53:15 -0800
Message-Id: <1392461595-30515-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index c5c84291a044..004d2f2965ad 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -213,6 +213,7 @@ Read Controller Information Command
 		11	Advertising
 		12	Secure Connections
 		13	Debug Keys
+		14	Privacy
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -1468,6 +1469,68 @@ Set Debug Keys Command
 				Invalid Index
 
 
+Set Privacy Command
+===================
+
+	Command Code:		0x002F
+	Controller Index:	<controller id>
+	Command Parameters:	Privacy (1 Octet)
+				Identity_Address_Type (1 Octet)
+				Identity_Resolving_Key (16 Octets)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is used to enable Low Energy Privacy feature using
+	resolvable private addresses.
+
+	The value 0x00 disables privacy mode, the value 0x01 enables
+	privacy mode.
+
+	Possible values for the Identity_Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	With LE Public, the controller's public address will be used as
+	identity address. With LE Random, the configured static address
+	will be used as identity address.
+
+	The Identity_Resolving_Key is the local key assigned for the local
+	resolvable private address.
+
+	Possible errors:	Busy
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
+Load Identity Resolving Keys Command
+====================================
+
+	Command Code:		0x0030
+	Controller Index:	<controller id>
+	Command Parameters:	Key_Count (2 Octets)
+				Key1 {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+					Value (16 Octets)
+				}
+				Key2 {  }
+				...
+	Return Parameters:
+
+	This command is used to feed the kernel with currently known
+	Identity Resolving Keys. The command does not need to be called
+	again upon the receiption of new Identity Resolving Key events
+	since the kernel updates its list automatically.
+
+	This command can be used when the controller is not powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -1884,3 +1947,22 @@ Event Parameters	Address (6 Octets)
 	The Passkey parameter indicates the passkey to be shown to the
 	user whereas the Entered parameter indicates how many characters
 	the user has entered on the remote side.
+
+
+New Identity Resolving Key Event
+================================
+
+Event Code		0x0018
+Controller Index	<controller id>
+Event Parameters	Store_Hint (1 Octet)
+			Key {
+				Address (6 Octets)
+				Address_Type (1 Octet)
+				Value (16 Octets)
+			}
+
+	This event indicates that a new identity resolving key has been
+	generated for a remote device.
+
+	The Store_Hint parameter indicates whether the host is expected
+	to store the key persistently or not.
-- 
1.8.5.3

