Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/3] android: Add missing error status description for Core Service
Date: Mon, 21 Oct 2013 14:56:49 +0200
Message-Id: <1382360211-3565-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We need at least one failed status description.
---
 android/hal-ipc-api.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9a8b770..5d8e085 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -117,7 +117,9 @@ Core Service (ID 0)
 
 	Opcode 0x00 - Error response
 
-		Response parameters: Error (1 octet)
+		Response parameters: Status (1 octet)
+
+		Valid status values: 0x01 = Fail
 
 	Opcode 0x01 - Register module command/response
 
-- 
1.8.4

