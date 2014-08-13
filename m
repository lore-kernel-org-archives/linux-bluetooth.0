Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Correct trivial typos
Date: Wed, 13 Aug 2014 11:02:16 +0200
Message-Id: <1407920536-9518-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-pbap.txt |  2 +-
 android/pts-sm.txt   | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index 4f8b534..bead56d 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -141,5 +141,5 @@ TC_PSE_SRM_BI_03_I	N/A
 TC_PSE_SRM_BI_05_I	N/A
 TC_PSE_SRM_BV_08_I	N/A
 TC_PSE_SRMP_BI_02_I	N/A
-TX_PSE_SRMP_BV_02_I	N/A
+TC_PSE_SRMP_BV_02_I	N/A
 -------------------------------------------------------------------------------
diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index 8f1034b..d2cf1d7 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -52,18 +52,18 @@ TC_PKE_BI_03_C		PASS	btmgmt io-cap 0x04
 				btmgmt advertising on
 				btmgmt monitor
 				Note: Enter invalid passkey in PTS
-TC_OOB_BV_01_C		NA
-TC_OOB_BV_02_C		NA
-TC_OOB_BV_03_C		NA
-TC_OOB_BV_04_C		NA
+TC_OOB_BV_01_C		N/A
+TC_OOB_BV_02_C		N/A
+TC_OOB_BV_03_C		N/A
+TC_OOB_BV_04_C		N/A
 TC_OOB_BV_05_C		PASS
 TC_OOB_BV_06_C		PASS
 TC_OOB_BV_07_C		PASS
 TC_OOB_BV_08_C		PASS
-TC_OOB_BV_09_C		NA
-TC_OOB_BV_10_C		NA
-TC_OOB_BI_01_C		NA
-TC_OOB_BI_02_C		NA
+TC_OOB_BV_09_C		N/A
+TC_OOB_BV_10_C		N/A
+TC_OOB_BI_01_C		N/A
+TC_OOB_BI_02_C		N/A
 TC_EKS_BV_01_C		PASS
 TC_EKS_BV_02_C		PASS
 TC_EKS_BI_01_C		INC	btmgmt io-cap 0x03
-- 
1.8.5.3

