Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] android/build: Add DID PICS file to EXTRA_DIST
Date: Fri, 22 Nov 2013 11:47:41 +0100
Message-Id: <1385117261-25270-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1385117261-25270-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1385117261-25270-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index eeff912..5f6b1a3 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -85,4 +85,4 @@ endif
 
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-gap.txt android/pics-hid.txt \
-		android/pics-pan.txt
+		android/pics-pan.txt android/pics-did.txt
-- 
1.8.4.1

