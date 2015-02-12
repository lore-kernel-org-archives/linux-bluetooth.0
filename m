Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update HSP pixits, pics and test results for PTS 6.0
Date: Thu, 12 Feb 2015 14:17:31 +0100
Message-Id: <1423747051-31810-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics and results for HSP profile against
android 5.0
---
 android/pics-hfp.txt  | 8 ++++----
 android/pics-hsp.txt  | 6 +++---
 android/pixit-hsp.txt | 2 +-
 android/pts-hsp.txt   | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/android/pics-hfp.txt b/android/pics-hfp.txt
index 65f5112..da0eb23 100644
--- a/android/pics-hfp.txt
+++ b/android/pics-hfp.txt
@@ -1,6 +1,6 @@
 HFP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -40,7 +40,7 @@ TSPC_HFP_2_1a	True (*)	SLC initiation during active ongoing call (O)
 TSPC_HFP_2_2	True		Phone Status Information (M)
 TSPC_HFP_2_3	True		Audio connection handling (M)
 TSPC_HFP_2_3a	False		Audio connection establishment independent of
-					call processing (O)
+					a call processing (O)
 TSPC_HFP_2_3b	True (*)	eSCO support in Audio Connection (C.10)
 TSPC_HFP_2_3c	True (*)	Codec negotiation (C.7)
 TSPC_HFP_2_4a	False		Accept an incoming voice call
@@ -83,7 +83,7 @@ TSPC_HFP_2_21b	False		Enhanced Call Control (C.3)
 TSPC_HFP_2_21c	True (*)	Enhanced Call Status with limited network
 					notification (C.4)
 TSPC_HFP_2_22	False		Support for automatic link loss recovery (O)
-TSPC_HFP_2_23	True (*)	Individual Indicator Activation (C.9)
+TSPC_HFP_2_23	True		Individual Indicator Activation (C.9)
 TSPC_HFP_2_24	True (*)	Wide Band Speech service (C.8)
 TSPC_HFP_2_25	False		Support roaming function (O)
 TSPC_HFP_2_26	False		HF Indicators (C.11)
@@ -169,7 +169,7 @@ TSPC_HFP_3_22	False		Support for automatic link loss recovery (O)
 TSPC_HFP_3_23	False		Individual Indicator Activation (C.6)
 TSPC_HFP_3_24	False		Wide Band Speech service (C.6)
 TSPC_HFP_3_25	False		HF Indicators (C.8)
-TSPC_HFP_3_36	False		Support CVSD eSCO S4 setting (C.9)
+TSPC_HFP_3_26	False		Support CVSD eSCO S4 setting (C.9)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_HFP_3_12; otherwise excluded
 C.2: Optional if TSPC_HFP_3_12; otherwise excluded
diff --git a/android/pics-hsp.txt b/android/pics-hsp.txt
index 7e71b14..3818e74 100644
--- a/android/pics-hsp.txt
+++ b/android/pics-hsp.txt
@@ -1,6 +1,6 @@
 HSP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -82,8 +82,8 @@ TSPC_HSP_3_11	False		Audio volume setting storage by HS (O)
 TSPC_HSP_3_12	False		Remote microphone gain control (C.2)
 TSPC_HSP_3_13	False		HS informs AG about local changes of microphone
                                         gain (O)
-TSPC_HSP_3_14	False (*)	Microphone gain setting storage by HS (O)
-TSPC_HSP_3_15	False		Connection handling with Detach/Page (M)
+TSPC_HSP_3_14	False		Microphone gain setting storage by HS (O)
+TSPC_HSP_3_15	False (*)	Connection handling with Detach/Page (M)
 TSPC_HSP_3_16	False		Connection handling with Park Mode (C.3)
 -------------------------------------------------------------------------------
 C.1: Mandatory if TSPC_HSP_3_10 is supported, otherwise optional
diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
index 6be4731..d7a8e3c 100644
--- a/android/pixit-hsp.txt
+++ b/android/pixit-hsp.txt
@@ -1,6 +1,6 @@
 HSP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-hsp.txt b/android/pts-hsp.txt
index 9f03ead..04a6413 100644
--- a/android/pts-hsp.txt
+++ b/android/pts-hsp.txt
@@ -1,7 +1,7 @@
 PTS test results for HSP
 
-PTS version: 5.3
-Tested: 24-November-2014
+PTS version: 6.0
+Tested: 12-February-2015
 Android version: 5.0
 
 Results:
-- 
1.9.3

