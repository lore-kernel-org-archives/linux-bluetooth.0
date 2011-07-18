Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] Fix typo in mgmt-api
Date: Mon, 18 Jul 2011 15:00:09 -0300
Message-Id: <1311012009-15209-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |   48 ++++++++++++++++++++++++------------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index d89467c..e5cf5de 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -58,7 +58,7 @@ Read Controller Index List Command
 	Command Code:		0x0003
 	Controller Index:	<non-controller>
 	Command Parameters:
-	Return Paramters:	Num_Controllers (2 Octets)
+	Return Parameters:	Num_Controllers (2 Octets)
 				Controller_Index[i] (2 Octets)
 
 
@@ -93,7 +93,7 @@ Set Powered Command
 	Command Code:		0x0005
 	Controller Index:	<controller id>
 	Command Parameters:	Powered (1 Octet)
-	Return Paramters:	Powered (1 Octet)
+	Return Parameters:	Powered (1 Octet)
 
 
 Set Discoverable Command
@@ -102,7 +102,7 @@ Set Discoverable Command
 	Command Code:		0x0006
 	Controller Index:	<controller id>
 	Command Parameters:	Discoverable (1 Octet)
-	Return Paramters:	Discoverable (1 Octet)
+	Return Parameters:	Discoverable (1 Octet)
 
 
 Set Connectable Command
@@ -111,7 +111,7 @@ Set Connectable Command
 	Command Code:		0x0007
 	Controller Index:	<controller id>
 	Command Parameters:	Connectable (1 Octet)
-	Return Paramters:	Connectable (1 Octet)
+	Return Parameters:	Connectable (1 Octet)
 
 
 Set Pairable Command
@@ -120,7 +120,7 @@ Set Pairable Command
 	Command Code:		0x0008
 	Controller Index:	<controller id>
 	Command Parameters:	Pairable (1 Octet)
-	Return Paramters:	Pairable (1 Octet)
+	Return Parameters:	Pairable (1 Octet)
 
 Add UUID Command
 ================
@@ -129,7 +129,7 @@ Add UUID Command
 	Controller Index:	<controller id>
 	Command Parameters:	UUID (16 Octets)
 				SVC_Hint (1 octet)
-	Return Paramters:
+	Return Parameters:
 
 
 Remove UUID Command
@@ -138,7 +138,7 @@ Remove UUID Command
 	Command Code:		0x000A
 	Controller Index:	<controller id>
 	Command Parameters:	UUID (16 Octets)
-	Return Paramters:
+	Return Parameters:
 
 
 Set Device Class
@@ -148,7 +148,7 @@ Set Device Class
 	Controller Index:	<controller id>
 	Command Parameters:	Major_Class (1 octet)
 				Minor_Class (1 octed)
-	Return Paramters:
+	Return Parameters:
 
 
 Set Service Cache Command
@@ -157,7 +157,7 @@ Set Service Cache Command
 	Command Code:		0x000C
 	Controller Index:	<controller id>
 	Command Parameters:	Enable (1 octet)
-	Return Paramters:
+	Return Parameters:
 
 
 Load Keys Command
@@ -175,7 +175,7 @@ Load Keys Command
 				}
 				Key2 { }
 				...
-	Return Paramters:
+	Return Parameters:
 
 
 Remove Key Command
@@ -185,7 +185,7 @@ Remove Key Command
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
 				Disconnect (1 Octet)
-	Return Paramters:
+	Return Parameters:
 
 
 Disconnect Command
@@ -194,7 +194,7 @@ Disconnect Command
 	Command Code:		0x000F
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
-	Return Paramters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
 
 Get Connections Command
 =======================
@@ -202,7 +202,7 @@ Get Connections Command
 	Command Code:		0x0010
 	Controller Index:	<controller id>
 	Command Parameters:
-	Return Paramters:	Connection_Count (2 Octets)
+	Return Parameters:	Connection_Count (2 Octets)
 				Address1 (6 Octets)
 				Address2 (6 Octets)
 				...
@@ -213,7 +213,7 @@ PIN Code Reply Command
 	Command Code:		0x0011
 	Controller Index:	<controller id>
 	Command Parameters:
-	Return Paramters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
 				PIN_Length (1 Octet)
 				PIN_Code (16 Octets)
 
@@ -224,7 +224,7 @@ PIN Code Negative Reply Command
 	Command Code:		0x0012
 	Controller Index:	<controller id>
 	Command Parameters:
-	Return Paramters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
 
 
 Set IO Capability Command
@@ -233,7 +233,7 @@ Set IO Capability Command
 	Command Code:		0x0013
 	Controller Index:	<controller id>
 	Command Parameters:	IO_Capability (1 Octet)
-	Return Paramters:
+	Return Parameters:
 
 
 Pair Device Command
@@ -243,7 +243,7 @@ Pair Device Command
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
 				IO_Capability (1 Octet)
-	Return Paramters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
 				Status (1 Octet)
 
 
@@ -253,7 +253,7 @@ User Confirmation Reply Command
 	Command Code:		0x0015
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
-	Return Paramters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
 				Status (1 Octet)
 
 
@@ -263,7 +263,7 @@ User Confirmation Negative Reply Command
 	Command Code:		0x0016
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
-	Return Paramters:	Address (6 Octets)
+	Return Parameters:	Address (6 Octets)
 				Status (1 Octet)
 
 Set Local Name Command
@@ -272,7 +272,7 @@ Set Local Name Command
 	Command Code:		0x0017
 	Controller Index:	<controller id>
 	Command Parameters:	Name (249 Octets)
-	Return Paramters:	Name (249 Octets)
+	Return Parameters:	Name (249 Octets)
 
 Read Local Out Of Band Data Command
 ========================================
@@ -280,7 +280,7 @@ Read Local Out Of Band Data Command
 	Command Code:		0x0018
 	Controller Index:	<controller id>
 	Command Parameters:
-	Return Paramters:	Hash (16 Octets)
+	Return Parameters:	Hash (16 Octets)
 				Randomizer (16 Octets)
 
 
@@ -292,7 +292,7 @@ Add Remote Out Of Band Data Command
 	Command Parameters:	Address (6 Octets)
 				Hash (16 Octets)
 				Randomizer (16 Octets)
-	Return Paramters:
+	Return Parameters:
 
 
 Remove Remote Out Of Band Data Command
@@ -301,7 +301,7 @@ Remove Remote Out Of Band Data Command
 	Command Code:		0x001A
 	Controller Index:	<controller id>
 	Command Parameters:	Address (6 Octets)
-	Return Paramters:
+	Return Parameters:
 
 Start Discovery Command
 =======================
@@ -385,7 +385,7 @@ Write Controller Tracing Filter Command
 				Num_Filters (2 Octect)
 				Protocol_UUID[i] (16 Octets)
 				Protocol_Identifier[i] (16 Octets)
-	Return Paramters:	Status (1 Octet)
+	Return Parameters:	Status (1 Octet)
 
 
 Command Complete Event
-- 
1.7.6

