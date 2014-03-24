Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH 4/4] android: Adjust EXTRA_DIST in Makefile.am
Date: Mon, 24 Mar 2014 15:14:57 +0100
Message-Id: <1395670497-12969-4-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
References: <1395670497-12969-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastianchlad@gmail.com>

---
 android/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 58ee3c9..f9c084b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -199,7 +199,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-map.txt \
 				android/pics-pbap.txt \
 				android/pics-a2dp.txt \
-				android/pics-avctp.txt \
+				android/doc/pics-avctp.txt \
 				android/pics-avrcp.txt \
 				android/pics-hsp.txt \
 				android/pics-hfp.txt \
@@ -213,7 +213,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-map.txt \
 				android/pixit-pbap.txt \
 				android/pixit-a2dp.txt \
-				android/pixit-avctp.txt \
+				android/doc/pixit-avctp.txt \
 				android/pixit-avrcp.txt \
 				android/pixit-hsp.txt \
 				android/pixit-hfp.txt \
@@ -227,7 +227,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-map.txt \
 				android/pts-a2dp.txt \
 				android/pts-avrcp.txt \
-				android/pts-avctp.txt \
+				android/doc/pts-avctp.txt \
 				android/pts-pbap.txt \
 				android/pts-hfp.txt \
 				android/pts-hsp.txt
-- 
1.8.5.3

