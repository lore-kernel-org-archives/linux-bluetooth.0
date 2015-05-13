Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update SDP test results
Date: Wed, 13 May 2015 13:59:10 +0200
Message-Id: <1431518350-12694-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-sdp.txt  | 8 ++++----
 android/pixit-sdp.txt | 4 ++--
 android/pts-sdp.txt   | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/android/pics-sdp.txt b/android/pics-sdp.txt
index 9aae190..508b80d 100644
--- a/android/pics-sdp.txt
+++ b/android/pics-sdp.txt
@@ -1,6 +1,6 @@
 SDP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -41,8 +41,8 @@ TSPC_SDP_2_2	True (*)	Support for respond on search of Service,
 TSPC_SDP_2_3	True (*)	Search for services using the continuation
 				state (C.1)
 -------------------------------------------------------------------------------
-C.1 Mandatory to support if the client role is supported (1b/2)
-C.2 Mandatory to support if the server role is supported (1b/1)
+C.1 Mandatory to support if the client role is supported TSPC_SDP_1b_2
+C.2 Mandatory to support if the server role is supported TSPC_SDP_1b_1
 -------------------------------------------------------------------------------
 
 
@@ -136,5 +136,5 @@ TSPC_SDP_9_17	True (*)	AdditionalProtocolDescriptorList (C.1)
 TSPC_SDP_9_18	True		ServiceRecordHandle (M)
 TSPC_SDP_9_19	True		ServiceClassIDList (M)
 -------------------------------------------------------------------------------
-C.1: Optional if 9/2 is supported, otherwise excluded
+C.1: Optional if TSPC_SDP_9_2 is supported, otherwise excluded
 -------------------------------------------------------------------------------
diff --git a/android/pixit-sdp.txt b/android/pixit-sdp.txt
index 2875256..b430f84 100644
--- a/android/pixit-sdp.txt
+++ b/android/pixit-sdp.txt
@@ -1,6 +1,6 @@
 SDP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -30,7 +30,7 @@ TSPX_sdp_service_search_pattern_service_info_time_to_live
 TSPX_sdp_service_search_pattern_version_number_list		1000(*)
 TSPX_sdp_service_search_pattern_service_name
 TSPX_sdp_service_search_pattern_service_record_state
-TSPX_sdp_unsupported_attribute_id
+TSPX_sdp_unsupported_attribute_id				EEEE
 TSPX_security_enabled						FALSE
 TSPX_delete_link_key						FALSE
 TSPX_bd_addr_iut						112233445566(*&)
diff --git a/android/pts-sdp.txt b/android/pts-sdp.txt
index 592306e..8a3e889 100644
--- a/android/pts-sdp.txt
+++ b/android/pts-sdp.txt
@@ -1,8 +1,8 @@
 PTS test results for SDP
 
-PTS version: 6.0
-Tested: 23-February-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 13-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
@@ -48,7 +48,7 @@ TC_SERVER_SA_BV_21_C		PASS
 TC_SERVER_SS_BI_01_C		PASS
 TC_SERVER_SS_BI_02_C		PASS
 TC_SERVER_SS_BV_01_C		PASS
-TC_SERVER_SS_BV_03_C		PASS	PTS issue #12840
+TC_SERVER_SS_BV_03_C		PASS
 TC_SERVER_SS_BV_04_C		PASS
 TC_SERVER_SSA_BI_01_C		PASS
 TC_SERVER_SSA_BI_02_C		PASS
-- 
1.9.1

