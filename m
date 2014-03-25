Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC 1/3] android/hal-ipc-api: Add extra command to Health HAL api document
Date: Tue, 25 Mar 2014 16:34:39 +0200
Message-Id: <1395758081-22005-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1395758081-22005-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1395758081-22005-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Defined extra command for MDEP data which is required for Register
Application command. Also updated Opcode for rest of the commands.
---
 android/hal-ipc-api.txt | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 5613e85..08b035d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1125,28 +1125,36 @@ Commands and responses:
 
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
@@ -1155,7 +1163,7 @@ Commands and responses:
 
 		In case of an error, the error response will be returned.
 
-	Opcode 0x04 - Destroy Channel command/response
+	Opcode 0x05 - Destroy Channel command/response
 
 		Command parameters: Channel ID (2 octets)
 		Response parameters: <none>
-- 
1.8.3.2

