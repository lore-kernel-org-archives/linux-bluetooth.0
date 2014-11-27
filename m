Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH v2] android/pts: L2CAP pts tests results on Android 5.0
Date: Thu, 27 Nov 2014 12:42:47 +0100
Message-Id: <1417088567-27484-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-l2cap.txt | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 9cd2875..8ee9486 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -1,8 +1,8 @@
 PTS test results for L2CAP
 
 PTS version: 5.3
-Tested: 24-October-2014
-Android version: 4.4.4
+Tested: 25-November-2014
+Android version: 5.0
 Kernel version: 3.18
 
 Results:
@@ -41,10 +41,14 @@ TC_COS_IEX_BV_01_C	PASS	l2test -n -P 4113 <bdaddr>
 TC_COS_IEX_BV_02_C	PASS
 TC_COS_ECH_BV_01_C	PASS
 TC_COS_ECH_BV_02_C	PASS	l2ping -c 1 <bdaddr>
-TC_COS_CFC_BV_01_C	INC	PTS issue #12728
+TC_COS_CFC_BV_01_C	PASS	PTS issue #12728
 				l2test -y -N 1 -b 40 -V le_public <braddr>
-TC_COS_CFC_BV_02_C	INC	PTS issue #12728
+				Note: use Common.dll and ETS for L2CAP
+				from #12712
+TC_COS_CFC_BV_02_C	PASS	PTS issue #12728
 				l2test -y -N 1 -b 1 -V le_public <bdaddr>
+				Note: use Common.dll and ETS for L2CAP
+				from #12712
 TC_COS_CFC_BV_03_C	PASS	l2test -u -V le_public <bdaddr>
 TC_COS_CFC_BV_04_C	PASS	l2test -u -V le_public <bdaddr>
 TC_COS_CFC_BV_05_C	PASS	l2test -m -V le_public <bdaddr>
@@ -95,8 +99,7 @@ TC_ERM_BV_02_C		PASS	l2test -r -X ertm -P 4113
 TC_ERM_BV_03_C		PASS	l2test -r -X ertm -P 4113
 TC_ERM_BV_05_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
 TC_ERM_BV_06_C		PASS	l2test -x -X ertm -P 4113 -N 2 -Y 2
-TC_ERM_BV_07_C		INC	PTS issue #12690
-				l2test -r -H 1000 -K 10000 -X ertm -P 4113
+TC_ERM_BV_07_C		PASS	l2test -r -H 1000 -K 10000 -X ertm -P 4113
 TC_ERM_BV_08_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_09_C		PASS	l2test -X ertm -P 4113
 TC_ERM_BV_10_C		PASS	l2test -x -X ertm -P 4113 -N 1
@@ -111,8 +114,7 @@ TC_ERM_BV_18_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_19_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_20_C		PASS	l2test -x -X ertm -P 4113 -N 1
 TC_ERM_BV_21_C		PASS	l2test -x -X ertm -P 4113 -D 2000 -N 2
-TC_ERM_BV_22_C		INC	PTS issue #12690
-				l2test -r -H 1000 -K 5000 -X ertm -P 4113
+TC_ERM_BV_22_C		PASS	l2test -r -H 1000 -K 5000 -X ertm -P 4113
 TC_ERM_BV_23_C		PASS	l2test -x -X ertm -P 4113 -N 2
 TC_ERM_BI_01_C		N/A
 TC_ERM_BI_02_C		PASS	l2test -X ertm -P 4113
@@ -173,10 +175,14 @@ TC_LE_CFC_BV_04_C	PASS	l2test -n -V le_public -P 241  <braddr>
 TC_LE_CFC_BV_05_C	INC	PTS issue #12665
 TC_LE_CFC_BV_06_C	INC	PTS issue #12711 #12729
 				l2test -s -V le_public <braddr>
-TC_LE_CFC_BV_07_C	INC	PTS issue #12728
+TC_LE_CFC_BV_07_C	PASS	PTS issue #12728
 				l2test -u -V le_public <braddr>
-TC_LE_CFC_BI_01_C	INC	PTS issue #12728 #12712
+				Note: use Common.dll and ETS for L2CAP
+				from #12712
+TC_LE_CFC_BI_01_C	PASS	PTS issue #12728 #12712
 				l2test -u -V le_public <bdaddr>
+				Note: use Common.dll and ETS for L2CAP
+				from #12712
 TC_LE_CFC_BV_08_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_09_C	PASS	l2test -n -V le_public -P 37 <braddr>
 TC_LE_CFC_BV_16_C	PASS	l2test -n -V le_public -P 37 <braddr>
-- 
1.8.5.3

