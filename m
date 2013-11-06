Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/6] android/hid: Add missing hid send data parameters in ipc document
Date: Wed,  6 Nov 2013 13:48:43 +0200
Message-Id: <1383738528-14550-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index c39cb0d..da4eaaa 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -566,7 +566,9 @@ Commands and responses:
 	Opcode 0x09 - Send Data command/response
 
 		Command parameters: Remote address (6 octets)
-		                    ...
+		                    Report length (2 octets)
+		                    Report data (670 octets)
+
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
-- 
1.8.1.2

