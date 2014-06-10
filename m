Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [RFC_v2 1/6] android/hal-ipc-txt: Update Health MDEP command parameter
Date: Tue, 10 Jun 2014 16:21:58 +0300
Message-Id: <1402406523-2832-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1402406523-2832-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 43e2709..1484399 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1143,7 +1143,8 @@ Commands and responses:
 
 	Opcode 0x02 - Register Application MDEP data command/response
 
-		Command parameters: MDEP Role (1 octet)
+		Command parameters: Application ID (2 octets)
+                                    MDEP Role (1 octet)
 		                    Data type (1 octet)
 		                    Channel type (1 octet)
 		                    MDEP description length (2 octets)
-- 
1.8.3.2

