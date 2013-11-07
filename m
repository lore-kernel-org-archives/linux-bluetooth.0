Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 01/11] android/hid: Remove fixed number of hid set report data length in ipc doc
Date: Fri,  8 Nov 2013 00:10:10 +0200
Message-Id: <1383862220-29968-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HAL receives data in ascii format but it should be in hex format. So remove
fixed size of report data length and depend on report length parameter.
---
 android/hal-ipc-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index c39cb0d..297f565 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -553,7 +553,7 @@ Commands and responses:
 		Command parameters: Remote address (6 octets)
 		                    Report type (1 octet)
 		                    Report length (2 octets)
-		                    Report data (670 octets)
+		                    Report data (Report length)
 
 		Response parameters: <none>
 
-- 
1.8.3.2

