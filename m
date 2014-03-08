Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] android/hal-ipc-api: Fix not describing call numbers as strings
Date: Sat,  8 Mar 2014 17:35:30 +0100
Message-Id: <1394296531-22469-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 1ecf75f..e4a4e9c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -898,7 +898,7 @@ Commands and responses:
 		                    Call mode (1 octet)
 		                    Call multiparty type (1 octet)
 		                    Call number type (1 octet)
-		                    Call number (variable)
+		                    Call number (string)
 		Response parameters: <none>
 
 		Valid call directions: 0x00 = Outgoing
@@ -930,7 +930,7 @@ Commands and responses:
 		                    Number of held calls (1 octet)
 		                    Call setup state (1 octet)
 		                    Call number type (1 octet)
-		                    Call number (variable)
+		                    Call number (string)
 		Response parameters: <none>
 
 		Valid call setup states: 0x00 = Active
-- 
1.8.5.3

