Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: HDP regression tests
Date: Tue, 26 Aug 2014 11:07:56 +0200
Message-Id: <1409044076-30066-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Regression round for HDP against PTS 5.2 and Android 4.4.4
---
 android/pics-hdp.txt  | 4 ++--
 android/pixit-hdp.txt | 8 ++++----
 android/pts-hdp.txt   | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/pics-hdp.txt b/android/pics-hdp.txt
index d48e576..b179f9e 100644
--- a/android/pics-hdp.txt
+++ b/android/pics-hdp.txt
@@ -1,6 +1,6 @@
 HDP PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -14,7 +14,7 @@ O - optional
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_HDP_0_1	False		HDP 1.0 (C.1)
-TSPC_HDP_0_2	True		HDP 1.1(C.1)
+TSPC_HDP_0_2	True		HDP 1.1 (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support only one Profile version.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-hdp.txt b/android/pixit-hdp.txt
index 24cdcec..c0ad7e2 100644
--- a/android/pixit-hdp.txt
+++ b/android/pixit-hdp.txt
@@ -1,6 +1,6 @@
 HDP PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -9,7 +9,7 @@ PTS version: 5.1
 -------------------------------------------------------------------------------
 Parameter Name						Value
 -------------------------------------------------------------------------------
-TSPX_security_enabled					TRUE (*)
+TSPX_security_enabled					TRUE
 TSPX_delete_link_key					FALSE
 TSPX_bd_addr_iut					112233445566 (*&)
 TSPX_sink_device_class_of_device			00900
@@ -23,9 +23,9 @@ TSPX_MCAP_sync_lead_time				0BB8
 TSPX_MCAP_timestamp_native_resolution			2233
 TSPX_MCAP_timestamp_native_accuracy			1400
 TSPX_MCAP_timestamp_required_accuracy			6400
-TSPX_DC_max					1
+TSPX_DC_max						1
 TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
-TSPX_time_guard						6000000
+TSPX_time_guard						60000000
 TSPX_ieee_device_specialization				10417
 TSPX_ieee_standard_configuration			TRUE
 TSPX_MCAP_bluetooth_clock_access_resolution		55
diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index 4337e0e..2fad385 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -1,8 +1,8 @@
 PTS test results for HDP
 
-PTS version: 5.1
-Tested: 30-June-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 25-August-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
-- 
1.8.5.3

