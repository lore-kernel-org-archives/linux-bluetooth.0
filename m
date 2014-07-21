Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Interim PTS tests results for RFCOMM
Date: Mon, 21 Jul 2014 09:54:15 +0200
Message-Id: <1405929255-8632-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pixit-rfcomm.txt |  2 +-
 android/pts-rfcomm.txt   | 31 +++++++++++++++++++------------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/android/pixit-rfcomm.txt b/android/pixit-rfcomm.txt
index a266ab3..07810d2 100644
--- a/android/pixit-rfcomm.txt
+++ b/android/pixit-rfcomm.txt
@@ -18,7 +18,7 @@ TSPX_time_guard				300000
 TSPX_use_implicit_send			TRUE
 TSPX_service_name_tester		COM5
 TSPX_class_of_device_tester		200408
-TSPX_server_channel_iut			00
+TSPX_server_channel_iut			01 (*)
 TSPX_verification_pattern_length	4
 TSPX_T1_Acknowledgement_Timer		20000
 TSPX_T1_Acknowledgement_Timer_Dlc	300000
diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
index cf60efb..b96caab 100644
--- a/android/pts-rfcomm.txt
+++ b/android/pts-rfcomm.txt
@@ -1,7 +1,7 @@
 PTS test results for RFCOMM
 
 PTS version: 5.2
-Tested: 08-July-2014
+Tested: 17-July-2014
 Android version: 4.4.4
 
 Results:
@@ -14,20 +14,27 @@ NONE	test result is none
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_RFC_BV_01_C		INC
-TC_RFC_BV_02_C		INC
-TC_RFC_BV_03_C		INC
-TC_RFC_BV_04_C		INC
+TC_RFC_BV_01_C		PASS	rctest -n -P 1 <btaddr>
+TC_RFC_BV_02_C		PASS	rctest -r -P 1
+TC_RFC_BV_03_C		PASS	rctest -r -P 1
+TC_RFC_BV_04_C		FAIL
+				NOTE: DISC on DLC is expected; IUT disconnects
+					rfcomm session (close)
 TC_RFC_BV_05_C		INC
-TC_RFC_BV_06_C		INC
-TC_RFC_BV_07_C		INC
+TC_RFC_BV_06_C		PASS	rctest -r -P 1
+TC_RFC_BV_07_C		PASS	rctest -r -P 1
 TC_RFC_BV_08_C		INC
-TC_RFC_BV_11_C		INC
-TC_RFC_BV_13_C		INC
+				NOTE: Incorrect frame type sent in response to
+					the DISC command
+TC_RFC_BV_11_C		PASS	rctest -r -P 1
+TC_RFC_BV_13_C		FAIL
+				NOTE: IUT sent the correct frame type (UIH)
+				but the parameters did not match the
+				requirements
 TC_RFC_BV_14_C		N/A
-TC_RFC_BV_15_C		INC
-TC_RFC_BV_17_C		INC
-TC_RFC_BV_19_C		INC
+TC_RFC_BV_15_C		PASS	rctest -r -P 1
+TC_RFC_BV_17_C		PASS	rctest -d -P 1
+TC_RFC_BV_19_C		PASS
 TC_RFC_BV_21_C		INC
 TC_RFC_BV_22_C		INC
 TC_RFC_BV_25_C		INC
-- 
1.8.5.3

