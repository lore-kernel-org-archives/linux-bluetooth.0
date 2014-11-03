Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Interim PTS tests results for L2CAP
Date: Mon,  3 Nov 2014 14:44:46 +0100
Message-Id: <1415022286-30683-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-l2cap.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 9706d69..ea58899 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -83,19 +83,18 @@ TC_FOC_BV_03_C		PASS	l2test -r -X ertm -P 4113 -F 0
 TC_OFS_BV_01_C		PASS	l2test -x -X ertm -P 4113 -F 0 -N 1
 TC_OFS_BV_02_C		PASS	l2test -r -X ertm -P 4113 -F 0
 TC_OFS_BV_03_C		PASS	l2test -x -X streaming -P 4113 -F 0 -N 1
-TC_OFS_BV_04_C		PASS	l2test -r -X streaming -P 4113 -F 0
-				JIRA issue #BA-180
+TC_OFS_BV_04_C		PASS	l2test -d -X streaming -P 4113 -F 0
 TC_OFS_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_OFS_BV_06_C		PASS	l2test -r -X ertm -P 4113
 TC_OFS_BV_07_C		PASS	l2test -x -X streaming -P 4113 -F 0 -N 1
-TC_OFS_BV_08_C		PASS	l2test -r -X streaming -P 4113
-				JIRA issue #BA-180
+TC_OFS_BV_08_C		PASS	l2test -d -X streaming -P 4113
 TC_ERM_BV_01_C		PASS	l2test -x -X ertm -P 4113 -N 3 -Y 3
 TC_ERM_BV_02_C		PASS	l2test -r -X ertm -P 4113
 TC_ERM_BV_03_C		PASS	l2test -r -X ertm -P 4113
 TC_ERM_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
 TC_ERM_BV_06_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
-TC_ERM_BV_07_C		PASS	l2test -r -H 1000 -K 10000 -X ertm -P 4113
+TC_ERM_BV_07_C		INC	PTS issue #12690
+				l2test -r -H 1000 -K 10000 -X ertm -P 4113
 TC_ERM_BV_08_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_09_C		PASS	l2test -X ertm -P 4113
 TC_ERM_BV_10_C		PASS	l2test -x -X ertm -P 4113 -N 1
@@ -107,10 +106,11 @@ TC_ERM_BV_15_C		PASS	l2test -x -X ertm -P 4113 -N 4
 TC_ERM_BV_16_C		N/A
 TC_ERM_BV_17_C		PASS	l2test -X ertm -P 4113
 TC_ERM_BV_18_C		PASS	l2test -x -X ertm -P 4113 -N 1
-TC_ERM_NV_19_C		PASS	l2test -x -X ertm -P 4113 -N 1
+TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_21_C		PASS	l2test -x -X ertm -P 4113 -D 2000 -N 2
-TC_ERM_BV_22_C		PASS	l2test -r -H 1000 -K 5000 -X ertm -P 4113
+TC_ERM_BV_22_C		INC	PTS issue #12690
+				l2test -r -H 1000 -K 5000 -X ertm -P 4113
 TC_ERM_BV_23_C		PASS	l2test -x -X ertm -P 4113 -N 2
 TC_ERM_BI_01_C		N/A
 TC_ERM_BI_02_C		PASS	l2test -X ertm -P 4113
@@ -118,7 +118,7 @@ TC_ERM_BI_03_C		PASS	l2test -x -X ertm -P 4113 -N 2
 TC_ERM_BI_04_C		PASS	l2test -x -X ertm -P 4113 -N 2
 TC_ERM_BI_05_C		PASS	l2test -x -X ertm -P 4113 -N 2
 TC_STM_BV_01_C		PASS	l2test -x -X streaming -P 4113 -N 3 -Y 3
-TC_STM_BV_02_C		PASS	l2test -r -X streaming -P 4113
+TC_STM_BV_02_C		PASS	l2test -d -X streaming -P 4113
 TC_STM_BV_03_C		PASS	l2test -x -X streaming -P 4113 -N 2
 TC_STM_BV_11_C		N/A
 TC_STM_BV_12_C		N/A
-- 
1.8.5.3

