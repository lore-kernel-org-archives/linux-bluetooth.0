Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/4] android/hal-ipc-api: Trivial typo fix in doc
Date: Wed,  5 Mar 2014 15:43:59 +0100
Message-Id: <1394030639-28134-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394030639-28134-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index cd6bc92..1ecf75f 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -321,14 +321,14 @@ Notifications:
 
 	Opcode 0x81 - Adapter State Changed notification
 
-		Notifications parameters: State (1 octect)
+		Notifications parameters: State (1 octet)
 
 		Valid state values: 0x00 = Off
 		                    0x01 = On
 
 	Opcode 0x82 - Adapter Properties Changed notification
 
-		Notification parameters: Status (1 octect)
+		Notification parameters: Status (1 octet)
 		                         Num properties (1 octet)
 		                         Type # (1 octet)
 		                         Length # (2 octets)
@@ -337,7 +337,7 @@ Notifications:
 
 	Opcode 0x83 - Remote Device Properties notification
 
-		Notification parameters: Status (1 octect)
+		Notification parameters: Status (1 octet)
 		                         Remote address (6 octets)
 		                         Num properties (1 octet)
 		                         Type # (1 octet)
@@ -355,7 +355,7 @@ Notifications:
 
 	Opcode 0x85 - Discovery State Changed notification
 
-		Notifications parameters: State (1 octect)
+		Notifications parameters: State (1 octet)
 
 	Opcode 0x86 - PIN Request notification
 
@@ -373,7 +373,7 @@ Notifications:
 
 	Opcode 0x88 - Bond State Changed notification
 
-		Notification parameters: Status (1 octect)
+		Notification parameters: Status (1 octet)
 		                         Remote address (6 octets)
 		                         Bond state (1 octet)
 
@@ -383,19 +383,19 @@ Notifications:
 
 	Opcode 0x89 - ACL State Changed notification
 
-		Notification parameters: Status (1 octect)
+		Notification parameters: Status (1 octet)
 		                         Remote address (6 octets)
 		                         ACL state (1 octet)
 
 	Opcode 0x8a - DUT Mode Receive notification
 
-		Notification parameters: Opcode (2 octects)
+		Notification parameters: Opcode (2 octets)
 		                         Length  (1 octet)
 		                         Data (variable)
 
 	Opcode 0x8b - LE Test Mode notification
 
-		Notification parameters: Status (1 octect)
+		Notification parameters: Status (1 octet)
 		                         Num packets (2 octets)
 
 
@@ -722,7 +722,7 @@ Notifications:
 
 	Opcode 0x81 - Control State notification
 
-		Notification parameters: Control state (1 octect)
+		Notification parameters: Control state (1 octet)
 		                         Status (1 octet)
 		                         Local role (1 octet)
 		                         Interface name (17 octet)
@@ -736,7 +736,7 @@ Notifications:
 
 	Opcode 0x82 - Connection State notification
 
-		Notification parameters: Connection state (1 octect)
+		Notification parameters: Connection state (1 octet)
 		                         Status (1 octet)
 		                         Remote address (6 octets)
 		                         Local role (1 octet)
@@ -950,7 +950,7 @@ Notifications:
 
 	Opcode 0x81 - Connection State notification
 
-		Notification parameters: Connection state (1 octect)
+		Notification parameters: Connection state (1 octet)
 		                         Remote address (6 octets)
 
 		Valid connection states: 0x00 = Disconnected
@@ -961,7 +961,7 @@ Notifications:
 
 	Opcode 0x82 - Audio State notification
 
-		Notification parameters: Audio state (1 octect)
+		Notification parameters: Audio state (1 octet)
 		                         Remote address (6 octets)
 
 		Valid audio states: 0x00 = Disconnected
@@ -1081,7 +1081,7 @@ Notifications:
 
 	Opcode 0x81 - Connection State notification
 
-		Notification parameters: Connection state (1 octect)
+		Notification parameters: Connection state (1 octet)
 		                         Remote address (6 octets)
 
 		Valid connection states: 0x00 = Disconnected
@@ -1091,7 +1091,7 @@ Notifications:
 
 	Opcode 0x82 - Audio State notification
 
-		Notification parameters: Audio state (1 octect)
+		Notification parameters: Audio state (1 octet)
 		                         Remote address (6 octets)
 
 		Valid connection states: 0x00 = Remote suspend
@@ -1164,7 +1164,7 @@ Notifications:
 
 	Opcode 0x81 - Application Registration State notification
 
-		Notification parameters: Application ID (2 octects)
+		Notification parameters: Application ID (2 octets)
 		                         Application state (1 octet)
 
 		Valid application states: 0x00 = Registration success
@@ -1174,7 +1174,7 @@ Notifications:
 
 	Opcode 0x82 - Channel State notification
 
-		Notification parameters: Application ID (2 octects)
+		Notification parameters: Application ID (2 octets)
 		                         Remote address (6 octets)
 		                         MDEP index (1 octet)
 		                         Channel ID (2 octets)
-- 
1.9.0

