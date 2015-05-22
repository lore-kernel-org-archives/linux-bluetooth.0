Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update AVDTP test results
Date: Fri, 22 May 2015 11:58:14 +0200
Message-Id: <1432288694-11443-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-avdtp.txt  | 14 ++++++++------
 android/pixit-avdtp.txt |  2 +-
 android/pts-avdtp.txt   |  8 ++++----
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/android/pics-avdtp.txt b/android/pics-avdtp.txt
index 191eaa4..c0c5529 100644
--- a/android/pics-avdtp.txt
+++ b/android/pics-avdtp.txt
@@ -1,6 +1,6 @@
 AVDTP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -27,7 +27,7 @@ Parameter Name	Selected	Description
 TSPC_AVDTP_1_1	True (*)	Source (C.1)
 TSPC_AVDTP_1_2	True (*)	Sink (C.1)
 TSPC_AVDTP_1_3	True (*)	Initiator (C.2)
-TSPC_AVDTP_1_4	True (*)	Aceptor (C.2)
+TSPC_AVDTP_1_4	True (*)	Acceptor (C.2)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 C.2: It is within the scope of profiles using the AVDTP specification to
@@ -67,7 +67,8 @@ TSPC_AVDTP_4_4	True (*)	Get configuration command (O)
 TSPC_AVDTP_4_5	False		Reconfigure command (O)
 TSPC_AVDTP_4_6	True (*)	Stream get all capabilities command (C.1)
 -------------------------------------------------------------------------------
-C.1: It is optional to support if AVDTP 1.3 is supported, otherwise excluded.
+C.1: It is optional to support if TSPC_AVDTP_0_3 is supported, otherwise
+	excluded.
 C.2: Mandatory to support if TSPC_AVDTP_4_6 is supported, otherwise Optional.
 -------------------------------------------------------------------------------
 
@@ -131,7 +132,8 @@ TSPC_AVDTP_10_4	True (*)	Get configuration response (O)
 TSPC_AVDTP_10_5 False		Reconfigure response (O)
 TSPC_AVDTP_10_6	True (*)	Stream get all capabilities response (C.1)
 -------------------------------------------------------------------------------
-C.1: It is optional to support if AVDTP 1.3 is supported, otherwise excluded.
+C.1: It is optional to support if TSPC_AVDTP_0_3 is supported, otherwise
+	excluded.
 C.2: It is Mandatory to support if TSPC_AVDTP_10_6 is supported, otherwise
 	Optional.
 -------------------------------------------------------------------------------
@@ -177,7 +179,7 @@ TSPC_AVDTP_14_4	False		Multiplexing service support (O)
 TSPC_AVDTP_14_5	False		Robust header compression service support (O)
 TSPC_AVDTP_14_6	True (*)	Delay Reporting (C.1)
 -------------------------------------------------------------------------------
-C.1: It is optional to support if AVDTP 1.3 is supported, else excluded.
+C.1: It is optional to support if TSPC_AVDTP_0_3 is supported, else excluded.
 -------------------------------------------------------------------------------
 
 
@@ -192,7 +194,7 @@ TSPC_AVDTP_15_4	False		Multiplexing service support (O)
 TSPC_AVDTP_15_5	False		Robust header compression service support (O)
 TSPC_AVDTP_15_6	True (*)	Delay Reporting (C.1)
 -------------------------------------------------------------------------------
-C.1: It is optional to support if AVDTP 1.3 is supported, else excluded.
+C.1: It is optional to support if TSPC_AVDTP_0_3 is supported, else excluded.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-avdtp.txt b/android/pixit-avdtp.txt
index c4b7ed8..f73b676 100644
--- a/android/pixit-avdtp.txt
+++ b/android/pixit-avdtp.txt
@@ -1,6 +1,6 @@
 AVDTP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-avdtp.txt b/android/pts-avdtp.txt
index 683ba6d..1a5699d 100644
--- a/android/pts-avdtp.txt
+++ b/android/pts-avdtp.txt
@@ -1,8 +1,8 @@
 PTS test results for AVDTP
 
-PTS version: 6.0
-Tested: 16-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 22-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -90,7 +90,7 @@ TC_ACP_SRC_SIG_SMG_BV_24_C		PASS	avdtptest -d SRC -l
 TC_ACP_SRC_SIG_SMG_BV_26_C		PASS	avdtptest -d SRC -l
 TC_ACP_SRC_SIG_SMG_BV_27_C		PASS	avdtptest -d SRC -l
 TC_ACP_SRC_SIG_SMG_ESR05_BV_14_C	N/A
-TC_ACP_SRC_SIG_SMG_BI_02_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_02_C		PASS	avdtptest -d SRC -l
 TC_ACP_SRC_SIG_SMG_BI_03_C		N/A
 TC_ACP_SRC_SIG_SMG_BI_05_C		PASS	avdtptest -d SRC -l
 TC_ACP_SRC_SIG_SMG_BI_06_C		N/A
-- 
1.9.1

