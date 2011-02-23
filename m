Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Update mgmt-api.txt with controller index moved to mgmt packet header
Date: Wed, 23 Feb 2011 18:39:21 +0100
Message-ID: <1298482761-19986-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |  214 ++++++++++++++++++++++++++++--------------------------
 1 files changed, 110 insertions(+), 104 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 2add44f..63fa9a7 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -9,25 +9,31 @@ Packet Structures
 
 	Commands:
 
-	0       4       8      12      16      202     24      28    31
-	+-------------------------------+-----------------------------+
-	|  Command Code                 |  Parameter Total Length     |
-        +-------------------------------+-----------------------------+
-	|                                                             |
+	0    4    8   12   16   22   24   28   31   35   39   43   47
+	+-------------------+-------------------+-------------------+
+	|  Command Code     |  Controller Index |  Parameter Length |
+	+-------------------+-------------------+-------------------+
+	|                                                           |
 
 	Events:
 
-	0       4       8      12      16      202     24      28    31
-	+-------------------------------+-----------------------------+
-	|  Event Code                   |  Parameter Total Length     |
-        +-------------------------------+-----------------------------+
-	|                                                             |
+	0    4    8   12   16   22   24   28   31   35   39   43   47
+	+-------------------+-------------------+-------------------+
+	|  Event Code       |  Controller Index |  Parameter Length |
+	+-------------------+-------------------+-------------------+
+	|                                                           |
+
+Controller Index can have a special value <non-controller> to indicate that
+command or event is not related to any controller. Possible values:
+	<controller id>		0x0000 to 0xFFFE
+	<non-controller>	0xFFFF
 
 
 Read Management Version Information Command
 ===========================================
 
 	Command Code:		0x0001
+	Controller Index:	<non-controller>
 	Command Parameters:
 	Return Parameters:	Version (1 Octets)
 				Revision (2 Octets)
@@ -37,6 +43,7 @@ Read Management Supported Features Command
 ==========================================
 
 	Command Code:		0x0002
+	Controller Index:	<non-controller>
 	Command Parameters:
 	Return Parameters:	Features (8 Octets)
 
@@ -48,6 +55,7 @@ Read Controller Index List Command
 ==================================
 
 	Command Code:		0x0003
+	Controller Index:	<non-controller>
 	Command Parameters:
 	Return Paramters:	Num_Controllers (2 Octets)
 				Controller_Index[i] (2 Octets)
@@ -57,9 +65,9 @@ Read Controller Information Command
 ===================================
 
 	Command Code:		0x0004
-	Command Parameters:	Controller_Index (2 Octets)
-	Return Parameters:	Controller_Index (2 Octets)
-				Controller_Type (1 Octet)
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Parameters:	Controller_Type (1 Octet)
 				Powered (1 octet)
 				Connectable (1 octet)
 				Discoverable (1 octet)
@@ -81,85 +89,81 @@ Set Powered Command
 ===================
 
 	Command Code:		0x0005
-	Command Parameters:	Controller_Index (2 Octets)
-				Powered (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
-				Powered (1 Octet)
+	Controller Index:	<controller id>
+	Command Parameters:	Powered (1 Octet)
+	Return Paramters:	Powered (1 Octet)
 
 
 Set Discoverable Command
 ========================
 
 	Command Code:		0x0006
-	Command Parameters:	Controller_Index (2 Octets)
-				Discoverable (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
-				Discoverable (1 Octet)
+	Controller Index:	<controller id>
+	Command Parameters:	Discoverable (1 Octet)
+	Return Paramters:	Discoverable (1 Octet)
 
 
 Set Connectable Command
 =======================
 
 	Command Code:		0x0007
-	Command Parameters:	Controller_Index (2 Octets)
-				Connectable (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
-				Connectable (1 Octet)
+	Controller Index:	<controller id>
+	Command Parameters:	Connectable (1 Octet)
+	Return Paramters:	Connectable (1 Octet)
 
 
 Set Pairable Command
 ====================
 
 	Command Code:		0x0008
-	Command Parameters:	Controller_Index (2 Octets)
-				Pairable (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
-				Pairable (1 Octet)
+	Controller Index:	<controller id>
+	Command Parameters:	Pairable (1 Octet)
+	Return Paramters:	Pairable (1 Octet)
 
 Add UUID Command
 ================
 
 	Command Code:		0x0009
-	Command Parameters:	Controller_Index (2 Octets)
-				UUID (16 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	UUID (16 Octets)
 				SVC_Hint (1 octet)
-	Return Paramters:	Controller_Index (2 Octets)
+	Return Paramters:
 
 
 Remove UUID Command
 ===================
 
 	Command Code:		0x000A
-	Command Parameters:	Controller_Index (2 Octets)
-				UUID (16 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	UUID (16 Octets)
+	Return Paramters:
 
 
 Set Device Class
 ================
 
 	Command Code:		0x000B
-	Command Parameters:	Controller_Index (2 Octets)
-				Major_Class (1 octet)
+	Controller Index:	<controller id>
+	Command Parameters:	Major_Class (1 octet)
 				Minor_Class (1 octed)
-	Return Paramters:	Controller_Index (2 Octets)
+	Return Paramters:
 
 
 Set Service Cache Command
 =========================
 
 	Command Code:		0x000C
-	Command Parameters:	Controller_Index (2 Octets)
-				Enable (1 octet)
-	Return Paramters:	Controller_Index (2 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	Enable (1 octet)
+	Return Paramters:
 
 
 Load Keys Command
 =================
 
 	Command Code:		0x000D
-	Command Parameters:	Controller_Index (2 Octets)
-				Debug_Keys (1 Octet)
+	Controller Index:	<controller id>
+	Command Parameters:	Debug_Keys (1 Octet)
 				Key_Count (2 Octets)
 				Key1 {
 					Address (6 Octets)
@@ -169,35 +173,34 @@ Load Keys Command
 				}
 				Key2 { }
 				...
-	Return Paramters:	Controller_Index (2 Octets)
+	Return Paramters:
 
 
 Remove Key Command
 ==================
 
 	Command Code:		0x000E
-	Command Parameters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
 				Disconnect (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
+	Return Paramters:
 
 
 Disconnect Command
 ==================
 
 	Command Code:		0x000F
-	Command Parameters:	Controller_Index (2 Octets)
-				Address (6 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Paramters:	Address (6 Octets)
 
 Get Connections Command
 =======================
 
 	Command Code:		0x0010
-	Command Parameters:	Controller_Index (2 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
-				Connection_Count (2 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Paramters:	Connection_Count (2 Octets)
 				Address1 (6 Octets)
 				Address2 (6 Octets)
 				...
@@ -206,9 +209,9 @@ PIN Code Reply Command
 =======================
 
 	Command Code:		0x0011
-	Command Parameters:	Controller_Index (2 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Paramters:	Address (6 Octets)
 				PIN_Length (1 Octet)
 				PIN_Code (16 Octets)
 
@@ -217,29 +220,28 @@ PIN Code Negative Reply Command
 ===============================
 
 	Command Code:		0x0012
-	Command Parameters:	Controller_Index (2 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:
+	Return Paramters:	Address (6 Octets)
 
 
 Set IO Capability Command
 =========================
 
 	Command Code:		0x0013
-	Command Parameters:	Controller_Index (2 Octets)
-				IO_Capability (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	IO_Capability (1 Octet)
+	Return Paramters:
 
 
 Pair Device Command
 ===================
 
 	Command Code:		0x0014
-	Command Parameters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
 				IO_Capability (1 Octet)
-	Return Paramters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Return Paramters:	Address (6 Octets)
 				Status (1 Octet)
 
 
@@ -247,10 +249,9 @@ User Confirmation Reply Command
 ===============================
 
 	Command Code:		0x0015
-	Command Parameters:	Controller_Index (2 Octets)
-				Address (6 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Paramters:	Address (6 Octets)
 				Status (1 Octet)
 
 
@@ -258,10 +259,9 @@ User Confirmation Negative Reply Command
 ========================================
 
 	Command Code:		0x0016
-	Command Parameters:	Controller_Index (2 Octets)
-				Address (6 Octets)
-	Return Paramters:	Controller_Index (2 Octets)
-				Address (6 Octets)
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+	Return Paramters:	Address (6 Octets)
 				Status (1 Octet)
 
 
@@ -269,6 +269,7 @@ Read Tracing Buffer Size Command
 ================================
 
 	Command Code:		<not yet assigned>
+	Controller Index:	<non-controller>
 	Command Parameters:
 	Return Parameters:	Status (1 Octet)
 				Buffer_Size (2 Octets)
@@ -280,6 +281,7 @@ Write Tracing Buffer Size Command
 =================================
 
 	Command Code:		<not yet assigned>
+	Controller Index:	<non-controller>
 	Command Parameters:	Buffer_Size (2 Octets)
 	Return Parameters:	Status (1 Octet)
 
@@ -290,9 +292,9 @@ Read Controller Tracing Filter Command
 =======================================
 
 	Command Code:		<not yet assigned>
-	Command Parameters:	Controller_Index (2 Octects)
+	Controller Index:	<controller id>
+	Command Parameters:
 	Return Parameters:	Status (1 Octet)
-				Controller_Index (2 Octets)
 				Tracing_Enable (1 Octect)
 				Num_Filters (2 Octect)
 				Protocol_UUID[i] (16 Octets)
@@ -308,19 +310,19 @@ Write Controller Tracing Filter Command
 =======================================
 
 	Command Code:		<not yet assigned>
-	Command Parameters:	Controller_Index (2 Octects)
-				Tracing_Enable (1 Octect)
+	Controller Index:	<controller id>
+	Command Parameters:	Tracing_Enable (1 Octect)
 				Num_Filters (2 Octect)
 				Protocol_UUID[i] (16 Octets)
 				Protocol_Identifier[i] (16 Octets)
 	Return Paramters:	Status (1 Octet)
-				Controller_Index (2 Octets)
 
 
 Command Complete Event
 ======================
 
 Event Code		0x0001
+Controller Index:	<controller id> or <non-controller>
 Event Parameters	Command_Opcode (2 Octets)
 			Return_Parameters
 
@@ -329,6 +331,7 @@ Command Status Event
 ====================
 
 Event Code		0x0002
+Controller Index:	<controller id> or <non-controller>
 Event Parameters	Status (1 Octet)
 			Command_Opcode (2 Octets)
 
@@ -337,6 +340,7 @@ Controller Error Event
 ======================
 
 Event Code		0x0003
+Controller Index:	<controller id>
 Event Parameters	Error_Code (1 Octet)
 
 
@@ -344,49 +348,51 @@ Index Added Event
 =================
 
 Event Code		0x0004
-Event Parameters	Controller_Index (2 Octets)
+Controller Index:	<controller id>
+Event Parameters
 
 
 Index Removed Event
 ===================
 
 Event Code		0x0005
-Event Parameters	Controller_Index (2 Octets)
+Controller Index:	<controller id>
+Event Parameters
 
 Controller Powered Event
 ========================
 
 Event Code		0x0006
-Event Parameters	Controller_Index (2 Octets)
-			Powered (1 Octet)
+Controller Index:	<controller id>
+Event Parameters	Powered (1 Octet)
 
 Controller Discoverable Event
 =============================
 
 Event Code		0x0007
-Event Parameters	Controller_Index (2 Octets)
-			Discoverable (1 Octet)
+Controller Index:	<controller id>
+Event Parameters	Discoverable (1 Octet)
 
 Controller Connectable Event
 ============================
 
 Event Code		0x0008
-Event Parameters	Controller_Index (2 Octets)
-			Connectable (1 Octet)
+Controller Index:	<controller id>
+Event Parameters	Connectable (1 Octet)
 
 Controller Pairable Event
 =========================
 
 Event Code		0x0009
-Event Parameters	Controller_Index (2 Octets)
-			Pairable (1 Octet)
+Controller Index:	<controller id>
+Event Parameters	Pairable (1 Octet)
 
 New Key Event
 =============
 
 Event Code		0x000A
-Event Parameters	Controller_Index (2 Octets)
-			Key {
+Controller Index:	<controller id>
+Event Parameters	Key {
 				Address (6 Octets)
 				Type (1 Octet)
 				Value (16 Octets)
@@ -398,38 +404,38 @@ Device Connected Event
 ======================
 
 Event Code		0x000B
-Event Parameters	Controller_Index (2 Octets)
-			Address (6 Octets)
+Controller Index:	<controller id>
+Event Parameters	Address (6 Octets)
 
 Device Disconnected Event
 =========================
 
 Event Code		0x000C
-Event Parameters	Controller_Index (2 Octets)
-			Address (6 Octets)
+Controller Index:	<controller id>
+Event Parameters	Address (6 Octets)
 
 Connect Failed Event
 ====================
 
 Event Code		0x000D
-Event Parameters	Controller_Index (2 Octets)
-			Address (6 Octets)
+Controller Index:	<controller id>
+Event Parameters	Address (6 Octets)
 			Status (1 Octet)
 
 PIN Code Request Event
 ======================
 
 Event Code		0x000E
-Event Parameters	Controller_Index (2 Octets)
-			Address (6 Octets)
+Controller Index:	<controller id>
+Event Parameters	Address (6 Octets)
 
 
 User Confirmation Request Event
 ===============================
 
 Event Code		0x000F
-Event Parameters	Controller_Index (2 Octets)
-			Address (6 Octets)
+Controller Index:	<controller id>
+Event Parameters	Address (6 Octets)
 			Value (4 Octets)
 
 
@@ -437,6 +443,6 @@ Authentication Failed Event
 ===========================
 
 Event Code		0x0010
-Event Parameters	Controller_Index (2 Octets)
-			Address (6 Octets)
+Controller Index:	<controller id>
+Event Parameters	Address (6 Octets)
 			Status (1 Octet)
-- 
1.7.0.4

