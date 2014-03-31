Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/3] android/hal-ipc-api: Add extra command to Health HAL api document
Date: Mon, 31 Mar 2014 12:46:59 +0300
Message-Id: <1396259221-2761-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1396259221-2761-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1396259221-2761-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Defined extra command for MDEP data which is required for Register
Application command. Also updated Opcode for rest of the commands.
---
 android/hal-ipc-api.txt | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 5613e85..4270408 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1125,28 +1125,37 @@ Commands and responses:
 
 	Opcode 0x01 - Register Application command/response
 
-		Command parameters: Application name (string)
-		                    Provider name (string)
-		                    Service name (string)
-		                    Service description (string)
-		                    Number of MDEP (1 octet)
-		                    MDEP Role # (1 octet)
-		                    Data type # (1 octet)
-		                    Channel type # (1 octet)
-		                    MDEP description # (string)
-		                    ...
+		Command parameters: Number of MDEP (1 octet)
+		                    Application name offset (2 octets)
+		                    Provider name offset (2 octets)
+		                    Service name offset (2 octets)
+		                    Service description offset (2 octets)
+		                    Data length (2 octets)
+		                    Data (data length)
+		Response parameters: <none>
+
+		Strings are null terminated.
+		In case of an error, the error response will be returned.
+
+	Opcode 0x02 - Register Application MDEP data command/response
+
+		Command parameters: MDEP Role (1 octet)
+		                    Data type (1 octet)
+		                    Channel type (1 octet)
+		                    MDEP description length (2 octets)
+		                    MDEP description (MDEP desciption length)
 		Response parameters: Application ID (2 octets)
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x02 - Unregister Application command/response
+	Opcode 0x03 - Unregister Application command/response
 
 		Command parameters: Application ID (2 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x03 - Connect Channel command/response
+	Opcode 0x04 - Connect Channel command/response
 
 		Command parameters: Application ID (2 octets)
 		                    Remote address (6 octets)
@@ -1155,7 +1164,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x04 - Destroy Channel command/response
+	Opcode 0x05 - Destroy Channel command/response
 
 		Command parameters: Channel ID (2 octets)
 		Response parameters: <none>
-- 
1.8.3.2

