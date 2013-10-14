Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Draft of 3D synchronization mgmt commands
Date: Mon, 14 Oct 2013 01:45:34 -0700
Message-Id: <1381740334-18213-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d68b70a..0395ddc 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -1338,6 +1338,104 @@ Set Scan Parameters Command
 				Invalid Index
 
 
+Get 3D Synchronization Features Command
+=======================================
+
+	Command Code:		0x002D
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Features (4 Octets)
+
+	This command allows for gettig the supported 3D synchronization
+	features. These features can be used to detect what kind of 3D
+	synchronization modes are supported.
+
+	When BR/EDR is not supported, this command is supported for
+	simplicity, but it will return an empty features set. This
+	command can also be used when the controller is powered off.
+
+	NOTES: Since 3DPS is its own profiles, these supported features
+	are not to be intermixed with the GAP settings. These are special
+	hardware features like Connectionless Slave Broadcast roles that
+	are either supported or not. The advantage with a separate command
+	for 3DPS lets it easy to detect if it is running on a 3DPS enabled
+	kernel and what features of 3DPS are available.
+
+	If it happens that the controller supports all the right features,
+	but not Secure Simple Pairing, then the broadcaster modes will be
+	left out.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
+Set 3D Synchronization Broadcast Command
+========================================
+
+	Command Code:		0x002E
+	Controller Index:	<controller id>
+	Command Parameters:	Mode (1 Octets)
+				...
+	Return Parameters:
+
+	This command allows for enabling 3D synchronization broadcast
+	modes. This is normally the 3D display role.
+
+	It is required that the controller has support for connectionless
+	slave broadcast and train synchronization in master role.
+
+	When Secure Simple Pairing is disabled, this command will fail
+	with an error.
+
+	NOTES: The actual list of parameters still needs to be figured
+	out, but it should include broadcast data and 3D information data.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
+Set 3D Synchronization Receiver Command
+=======================================
+
+	Command Code:		0x002E
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				...
+	Return Parameters:
+
+	This command allows for enabling 3D synchronization receiver
+	modes. This is normally the 3D glasses role.
+
+	It is required that the controller has support for connectionless
+	slave broadcast and train synchronization in slave role.
+
+	NOTES: The actual list of parameters still needs to be figured
+	out, but it should include broadcast data and 3D information data.
+
+	NOTES: The actual data information can be either reported via
+	an event or via an L2CAP channel. That still needs to be figured
+	out.
+
+	This command generates a Command Complete event on success or a
+	Command Status event on failure.
+
+	Possible errors:	Rejected
+				Not Supported
+				Invalid Parameters
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
-- 
1.8.3.1

