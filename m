Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] doc: Add Management Interface IPSP API definitions
Date: Thu, 18 Feb 2016 14:17:25 +0200
Message-Id: <1455797845-27533-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

	Hi,

Here is an update on the 6lowpan Network Management API posted by Johan
June last year. The proposed Network Management API has now been merged
into the existing Bluetooth Management API with only the 6lowpan
specific commands and events added and updated according to comments,
including a rename to IPSP.

The interface index has been set to 4 octets for those commands that added
one. In the kernel it seems 'int' is used, so some further figuring out
is perhaps needed - or then I just missed something.


Cheers,

	Patrik

 doc/doc.txt      |   0
 doc/mgmt-api.txt | 145 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 doc/doc.txt

diff --git a/doc/doc.txt b/doc/doc.txt
new file mode 100644
index 0000000..e69de29
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 731a088..34d1736 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2801,6 +2801,114 @@ Start Limited Discovery Command
 				Invalid Index
 
 
+Connect IPSP Command
+====================
+
+	Command Code:		0x0042
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Interface Index (4 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to connect to a remote IPSP Node.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Busy
+				Refused
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+				Already Connected
+
+
+Disconnect IPSP Command
+=======================
+
+	Command Code:		0x0043
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to disconnect from a remote IPSP device.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Busy
+				Not Connected
+				Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Get IPSP Connections Command
+============================
+
+	Command Code:		0x0044
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Interface Index (4 Octets)
+				Connection_Count (2 Octets)
+				Address1 {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+				}
+				Address2 { }
+				...
+
+	This command is used to retrieve a list of currently connected
+	IPSP devices.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
+
+	This command can only be used when the controller is powered.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Invalid Parameters
+				Not Powered
+				Invalid Index
+
+
+Enable IPSP Server Command
+==========================
+
+	Command Code:		0x0045
+	Controller Index:	<controller id>
+	Command Parameters:	Enable (1 Octet)
+	Return Parameters:
+
+	This command is used start a IPSP Server (Node rols) on a
+	specified controller.
+
+	This command generates a Command Complete event on success or
+	a Command Status event on failure.
+
+	Possible errors:	Busy
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -3645,3 +3753,40 @@ Advertising Removed Event
 
 	The event will only be sent to management sockets other than the
 	one through which the command was sent.
+
+
+IPSP Connected Event
+====================
+
+	Event Code:		0x0025
+	Controller Index:	<controller id>
+	Event Parameters:	Interface Index (4 Octets)
+				Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that a successful IPSP connection has
+	been created to the remote device.
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
+
+
+IPSP Disconnected Event
+=======================
+
+	Event Code:		0x0026
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that the IPSP connection was lost to a
+	remote device.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
-- 
2.1.4

