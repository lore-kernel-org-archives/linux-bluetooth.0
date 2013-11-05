Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 06/12] android/hid: Add missing set report parameters to ipc document
Date: Tue,  5 Nov 2013 23:09:12 +0200
Message-Id: <1383685758-3900-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383685758-3900-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 6b11684..48bcc45 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -552,7 +552,9 @@ Commands and responses:
 
 		Command parameters: Remote address (6 octets)
 		                    Report type (1 octet)
-		                    ...
+		                    Report length (2 octet)
+		                    Report data (670 octet) L2CAP default MTU
+
 		Response parameters: <none>
 
 		Valid report types: 0x01 = Input
-- 
1.8.1.2

