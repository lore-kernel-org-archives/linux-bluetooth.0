Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: PTS test results for L2CAP
Date: Wed, 29 Jan 2014 12:33:26 +0200
Message-Id: <1390991606-13576-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-l2cap.txt | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 51eedf5..3e46309 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,7 +1,7 @@
 PTS test results for L2CAP
 
 PTS version: 5.0
-Tested: 10.01.2014
+Tested: 29.01.2014
 
 Results:
 PASS   test passed
@@ -87,16 +87,18 @@ TC_ERM_BV_06_C         PASS
 TC_ERM_BV_07_C         PASS    l2test -X ertm -P 33 &
 TC_ERM_BV_08_C         PASS
 TC_ERM_BV_09_C         PASS    l2test -X ertm -P 33 &
-TC_ERM_BV_10_C         INC
-TC_ERM_BV_11_C         INC
-TC_ERM_BV_12_C         INC
+TC_ERM_BV_10_C         PASS    l2test -x -X ertm -P 33 -D 35000 -Q 1 -R -N 1 &
+				btmgmt disconnect
+TC_ERM_BV_11_C         PASS    l2test -x -X ertm -P 33 -D 35000 -Q 1 -R -N 1 &
+				btmgmt disconnect
+TC_ERM_BV_12_C         PASS    l2test -x -X ertm -P 33 -R -N 1
 TC_ERM_BV_13_C         PASS
 TC_ERM_BV_14_C         PASS
 TC_ERM_BV_15_C         PASS
 TC_ERM_BV_16_C         PASS
 TC_ERM_BV_17_C         PASS
-TC_ERM_BV_18_C         INC
-TC_ERM_BV_19_C         INC
+TC_ERM_BV_18_C         PASS    l2test -x -X ertm -P 33 -R -N 1
+TC_ERM_BV_19_C         PASS    l2test -x -X ertm -P 33 -R -N 1
 TC_ERM_BV_20_C         PASS
 TC_ERM_BV_21_C         PASS
 TC_ERM_BV_22_C         PASS
@@ -106,9 +108,9 @@ TC_ERM_BI_02_C         PASS
 TC_ERM_BI_03_C         PASS
 TC_ERM_BI_04_C         PASS
 TC_ERM_BI_05_C         PASS
-TC_STM_BV_01_C         INC
-TC_STM_BV_02_C         INC
-TC_STM_BV_03_C         INC
+TC_STM_BV_01_C         PASS    l2test -x -X ertm -P 33 -R -N 1 -Y 3 &
+TC_STM_BV_02_C         PASS    l2test -x -X ertm -P 33 -R -N 1 -Y 3 &
+TC_STM_BV_03_C         PASS    l2test -x -X ertm -P 33 -R -N 1 -Y 3 &
 TC_STM_BV_11_C         N/A
 TC_STM_BV_12_C         N/A
 TC_STM_BV_13_C         N/A
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

