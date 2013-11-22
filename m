Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/build: Add PAN PICS file to EXTRA_DIST
Date: Fri, 22 Nov 2013 11:47:39 +0100
Message-Id: <1385117261-25270-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1385117261-25270-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1385117261-25270-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index c4544ea..eeff912 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -84,4 +84,5 @@ android_haltest_LDFLAGS = -pthread
 endif
 
 EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
-		android/pics-gap.txt android/pics-hid.txt
+		android/pics-gap.txt android/pics-hid.txt \
+		android/pics-pan.txt
-- 
1.8.4.1

