Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 4/4] android/hsp: Add MCAP and HDP files
Date: Sat, 29 Mar 2014 11:34:42 +0100
Message-Id: <1396089282-5325-4-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1396089282-5325-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396089282-5325-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/Makefile.am b/android/Makefile.am
index 58ee3c9..6bcf0e8 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -204,6 +204,8 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-hsp.txt \
 				android/pics-hfp.txt \
 				android/pics-gatt.txt \
+				android/pics-mcap.txt \
+				android/pics-hdp.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -218,6 +220,8 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-hsp.txt \
 				android/pixit-hfp.txt \
 				android/pixit-gatt.txt \
+				android/pixit-mcap.txt \
+				android/pixit-hdp.txt \
 				android/pts-l2cap.txt \
 				android/pts-gap.txt \
 				android/pts-did.txt \
-- 
1.8.5.3

