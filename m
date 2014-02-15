Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] doc: Add management commands and events for privacy support
Date: Sat, 15 Feb 2014 10:06:01 -0800
Message-Id: <1392487561-33729-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index c5c84291a044..b21ddfbb7e78 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -213,6 +213,7 @@ Read Controller Information Command
 		11	Advertising
 		12	Secure Connections
 		13	Debug Keys
+		14	Privacy
 
 	This command generates a Command Complete event on success or
 	a Command Status event on failure.
@@ -1379,6 +1380,15 @@ Set Static Address Command
 	The special BDADDR_ANY address (00:00:00:00:00:00) can be used
 	to disable the static address.
 
+	When a controller has a public address (which is required for
+	all dual-mode controllers), this address is not used. Only when
+	the controller information reports BDADDR_ANY (00:00:00:00:00:00),
+	it is required to configure a static address first.
+
+	If privacy mode is enabled and the controller is single mode
+	LE only without a public address, the static random address is
+	used as identity address.
+
 	This command generates a Command Complete event on success or a
 	Command Status event on failure.
 
@@ -1468,6 +1478,65 @@ Set Debug Keys Command
 				Invalid Index
 
 
+Set Privacy Command
+===================
+
+	Command Code:		0x002F
+	Controller Index:	<controller id>
+	Command Parameters:	Privacy (1 Octet)
+				Identity_Resolving_Key (16 Octets)
+	Return Parameters:	Current_Settings (4 Octets)
+
+	This command is used to enable Low Energy Privacy feature using
+	resolvable private addresses.
+
+	The value 0x00 disables privacy mode, the value 0x01 enables
+	privacy mode.
+
+	When the controller has a public address (mandatory for dual-mode
+	controllers) it is used as identity address. In case the controller
+	is single mode LE only without a public address, it is required
+	to configure a static random andress first. The privacy mode can
+	only be enabled when an identity address is available.
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
 
@@ -1884,3 +1953,22 @@ Event Parameters	Address (6 Octets)
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

