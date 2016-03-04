Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3] doc: Add Management Interface Network API definitions
Date: Fri,  4 Mar 2016 13:38:32 +0200
Message-Id: <1457091512-21270-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v3: added interface index to 'Network' block, removed Nework_Role parameter
    and dropped text about LE being enabled.

 doc/doc.txt      |   0
 doc/mgmt-api.txt | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 doc/doc.txt

diff --git a/doc/doc.txt b/doc/doc.txt
new file mode 100644
index 0000000..e69de29
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 731a088..6317255 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2801,6 +2801,107 @@ Start Limited Discovery Command
 				Invalid Index
 
 
+Get Networks Command
+====================
+
+	Command Code:		0x0042
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Connection_Count (2 Octets)
+				Network1 {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+					Interface Index (4 Octets)
+				}
+				Network2 { }
+				...
+
+	This command is used to retrieve a list of BTLE network
+	connections. A pre-requisite is that LE is supported
+	by the controller, otherwise this command will return a
+	"not supported" response.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved
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
+				Not Supported
+				Invalid Index
+
+
+Add Network Command
+===================
+
+	Command Code:		0x0043
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Interface Index (4 Octets)
+
+	This command is used to connect to establish a network connection
+	to a remote BTLE node. A pre-requisite is that LE is supported
+	by the controller, otherwise this command will return a
+	"not supported" response.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved
+		1	LE Public
+		2	LE Random
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Busy
+				Refused
+				Invalid Parameters
+				Not Supported
+				Invalid Index
+				Already Connected
+
+
+Remove Network Command
+======================
+
+	Command Code:		0x0044
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This command is used to disconnect a network connection from a
+	remote BTLE node. A pre-requisite is that LE is supported
+	by the controller, otherwise this command will return a
+	"not supported" response.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved
+		1	LE Public
+		2	LE Random
+
+	This command generates a Command Complete event on success
+	or failure.
+
+	Possible errors:	Busy
+				Not Connected
+				Invalid Parameters
+				Not Supported
+				Invalid Index
+
+
 Command Complete Event
 ======================
 
@@ -3645,3 +3746,44 @@ Advertising Removed Event
 
 	The event will only be sent to management sockets other than the
 	one through which the command was sent.
+
+
+Network Added Event
+===================
+
+	Event Code:		0x0025
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Interface Index (4 Octets)
+
+	This event indicates that a network connection to a remote
+	BTLE node has been established successfully.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
+
+
+Network Removed Event
+=====================
+
+	Event Code:		0x0026
+	Controller Index:	<controller id>
+	Event Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+
+	This event indicates that the BTLE network connection to a remote
+	node has been lost.
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

