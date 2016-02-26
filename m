Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] doc: Add Management Interface network API definitions
Date: Fri, 26 Feb 2016 13:08:46 +0200
Message-Id: <1456484926-978-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---

v2 sorts the commands and parameters according to comments.

To make the commands more generic, IPSP has been renamed Network. In order
to be more generic, a network role has been added to the commands rather
than have a specific command for role setting. With this more networking
than just 6LowPAN can be handled in the future; whether 1 octet is enough
to handle possible future roles OR'ed together remains to be seen and
comments on the subject are appreciated.

Handling incoming connection authorization is another topic to discuss
with an initial proposal already on the mailing list. I'd be glad to update
this RFC with the outcome of that discussion.


     Patrik

doc/doc.txt      |   0
 doc/mgmt-api.txt | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+)
 create mode 100644 doc/doc.txt

diff --git a/doc/doc.txt b/doc/doc.txt
new file mode 100644
index 0000000..e69de29
diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 731a088..060b751 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -2801,6 +2801,127 @@ Start Limited Discovery Command
 				Invalid Index
 
 
+Get Networks Command
+====================
+
+	Command Code:		0x0042
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Interface Index (4 Octets)
+				Connection_Count (2 Octets)
+				Address1 {
+					Address (6 Octets)
+					Address_Type (1 Octet)
+					Network_Role (1 Octet)
+				}
+				Address2 { }
+				...
+
+	This command is used to retrieve a list of BTLE network
+	connections. A pre-requisite is that LE is already
+	enabled, otherwise this command will return a "rejected"
+	response.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved
+		1	LE Public
+		2	LE Random
+
+	Possible values for the Network_Role parameter:
+		0	Reserved
+		1	6LoWPAN Node
+		2	6LoWPAN Router
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
+Add Network Command
+===================
+
+	Command Code:		0x0043
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Network_Role (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Network_Role (1 Octet)
+				Interface Index (4 Octets)
+
+	This command is used to connect to establish a network connection
+	to a remote BTLE node. A pre-requisite is that LE is already
+	enabled, otherwise this command will return a "rejected"
+	response.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved
+		1	LE Public
+		2	LE Random
+
+	Possible values for the Network_Role parameter:
+		0	Reserved
+		1	6LoWPAN Node
+		2	6LoWPAN Router
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
+Remove Network Command
+======================
+
+	Command Code:		0x0044
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Network_Role (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Network_Role (1 Octet)
+
+	This command is used to disconnect a network connection from a
+	remote BTLE node. A pre-requisite is that LE is already
+	enabled, otherwise this command will return a "rejected"
+	response.
+
+	Possible values for the Address_Type parameter:
+		0	Reserved
+		1	LE Public
+		2	LE Random
+
+	Possible values for the Network_Role parameter:
+		0	Reserved
+		1	6LoWPAN Node
+		2	6LoWPAN Router
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
 Command Complete Event
 ======================
 
@@ -3645,3 +3766,54 @@ Advertising Removed Event
 
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
+				Network_Role (1 Octet)
+				Interface Index (4 Octets)
+
+	This event indicates that a network connection to a remote
+	BTLE node has been established successfully.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	Possible values for the Network_Role parameter:
+		1	6LoWPAN Node
+		2	6LoWPAN Router
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
+				Network_Role (1 Octet)
+
+	This event indicates that the BTLE network connection to a remote
+	node has been lost.
+
+	Possible values for the Address_Type parameter:
+		1	LE Public
+		2	LE Random
+
+	Possible values for the Network_Role parameter:
+		1	6LoWPAN Node
+		2	6LoWPAN Router
+
+	For devices using resolvable random addresses with a known
+	identity resolving key, the Address and Address_Type will
+	contain the identity information.
-- 
2.1.4

