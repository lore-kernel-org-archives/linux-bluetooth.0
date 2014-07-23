Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Add support for Identify Device and Cancel Identify Device
Date: Thu, 24 Jul 2014 00:50:34 +0200
Message-Id: <1406155834-50603-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index ca5bbc6670fa..42428b507745 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2134,6 +2134,99 @@ Set Public Address Command
 				Invalid Index
 
 
+Identify Device Command
+=======================
+
+	Command Code:		0x003A
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				IO_Capability (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to resolve the identity of a remote device
+	using resolvable private addresses. The IO_Capability command
+	parameter is used to temporarily (for this command only) override
+	the global IO Capaility (set using the Set IO Capability command).
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	Possible values for the IO_Capability parameter:
+		0	DisplayOnly
+		1	DisplayYesNo
+		2	KeyboardOnly
+		3	NoInputNoOutput
+		4	KeyboardDisplay
+
+	The Address and Address_Type of the return parameters will
+	return the identity address if known. In case of resolvable
+	random address given as command parameters and the remote
+	provides an identity resolving key, the return parameters
+	will provide the resolved address.
+
+	To allow tracking of which resolvable random address changed
+	into which identity address, the New Identity Resolving Key
+	event will be send before receiving Command Complete event
+	for this command.
+
+	Using Pair Device to bound with a remote device will identify
+	the device in case it uses resolvable random address. In that
+	case it is not needed to call this command. It is provided for
+	the case where a device needs to be identified, but a bonding
+	using a Long Term Key is not desired.
+
+	When using this command to identity a device not using a
+	resolvable public address, the identity information are
+	still acquired. However they will match exactly the public
+	or static address used.
+
+	The Connection Signature Resolving Keys are also exchanged
+	if they are available.
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Connect Failed
+				Busy
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Cancel Identify Device
+======================
+
+	Command Code:		0x003B
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	The Address and Address_Type parameters should match what was
+	given to a preceding Identity Device command.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved (not in use)
+		1	LE Public
+		2	LE Random
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.9.3

