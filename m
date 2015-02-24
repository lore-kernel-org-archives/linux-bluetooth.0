Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] android/pts: Update SDP PTS tests results
Date: Tue, 24 Feb 2015 13:06:01 +0100
Message-Id: <1424779561-12403-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1424779561-12403-1-git-send-email-szymon.janc@tieto.com>
References: <1424779561-12403-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pixit-sdp.txt |  4 ++--
 android/pts-sdp.txt   | 66 +++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/android/pixit-sdp.txt b/android/pixit-sdp.txt
index 80b5931..2875256 100644
--- a/android/pixit-sdp.txt
+++ b/android/pixit-sdp.txt
@@ -23,11 +23,11 @@ TSPX_sdp_service_search_pattern_language_base_attribute_id_list
 TSPX_sdp_service_search_pattern_protocol_descriptor_list
 TSPX_sdp_service_search_pattern_provider_name
 TSPX_sdp_service_search_pattern_service_availability
-TSPX_sdp_service_search_pattern_service_data_base_state
+TSPX_sdp_service_search_pattern_service_data_base_state		1000(*)
 TSPX_sdp_service_search_pattern_service_description
 TSPX_sdp_service_search_pattern_service_id
 TSPX_sdp_service_search_pattern_service_info_time_to_live
-TSPX_sdp_service_search_pattern_version_number_list
+TSPX_sdp_service_search_pattern_version_number_list		1000(*)
 TSPX_sdp_service_search_pattern_service_name
 TSPX_sdp_service_search_pattern_service_record_state
 TSPX_sdp_unsupported_attribute_id
diff --git a/android/pts-sdp.txt b/android/pts-sdp.txt
index 1e29152..592306e 100644
--- a/android/pts-sdp.txt
+++ b/android/pts-sdp.txt
@@ -1,7 +1,7 @@
 PTS test results for SDP
 
 PTS version: 6.0
-Tested: 16-December-2014
+Tested: 23-February-2015
 Android version: 5.0
 
 Results:
@@ -11,9 +11,67 @@ INC	test is inconclusive
 N/A	test is disabled due to PICS setup
 NONE	test result is none
 
+Note: from haltest:
+bluetooth set_adapter_property BT_PROPERTY_ADAPTER_SCAN_MODE
+						BT_SCAN_MODE_CONNECTABLE
+bluetooth enable
+socket listen BTSOCK_L2CAP BlueZ 0
+
 -------------------------------------------------------------------------------
-Test Name				Result	Notes
+Test Name			Result	Notes
 -------------------------------------------------------------------------------
-TC_SERVER_BRW_BV_01_C			PASS
-TC_SERVER_BRW_BV_01_C			PASS
+TC_SERVER_BRW_BV_01_C		PASS
+TC_SERVER_BRW_BV_01_C		PASS
+TC_SERVER_SA_BI_01_C		PASS
+TC_SERVER_SA_BI_02_C		PASS
+TC_SERVER_SA_BI_03_C		PASS
+TC_SERVER_SA_BV_01_C		PASS
+TC_SERVER_SA_BV_03_C		PASS
+TC_SERVER_SA_BV_04_C		PASS
+TC_SERVER_SA_BV_05_C		PASS
+TC_SERVER_SA_BV_06_C		PASS
+TC_SERVER_SA_BV_07_C		PASS
+TC_SERVER_SA_BV_08_C		PASS
+TC_SERVER_SA_BV_09_C		PASS
+TC_SERVER_SA_BV_10_C		PASS
+TC_SERVER_SA_BV_11_C		PASS
+TC_SERVER_SA_BV_12_C		PASS
+TC_SERVER_SA_BV_13_C		PASS
+TC_SERVER_SA_BV_14_C		PASS
+TC_SERVER_SA_BV_15_C		PASS
+TC_SERVER_SA_BV_16_C		PASS
+TC_SERVER_SA_BV_17_C		PASS
+TC_SERVER_SA_BV_18_C		PASS
+TC_SERVER_SA_BV_19_C		PASS
+TC_SERVER_SA_BV_20_C		PASS
+TC_SERVER_SA_BV_21_C		PASS
+TC_SERVER_SS_BI_01_C		PASS
+TC_SERVER_SS_BI_02_C		PASS
+TC_SERVER_SS_BV_01_C		PASS
+TC_SERVER_SS_BV_03_C		PASS	PTS issue #12840
+TC_SERVER_SS_BV_04_C		PASS
+TC_SERVER_SSA_BI_01_C		PASS
+TC_SERVER_SSA_BI_02_C		PASS
+TC_SERVER_SSA_BV_01_C		PASS
+TC_SERVER_SSA_BV_02_C		PASS
+TC_SERVER_SSA_BV_03_C		PASS
+TC_SERVER_SSA_BV_04_C		PASS
+TC_SERVER_SSA_BV_06_C		PASS
+TC_SERVER_SSA_BV_07_C		PASS
+TC_SERVER_SSA_BV_08_C		PASS
+TC_SERVER_SSA_BV_09_C		PASS
+TC_SERVER_SSA_BV_10_C		PASS
+TC_SERVER_SSA_BV_11_C		PASS
+TC_SERVER_SSA_BV_12_C		PASS
+TC_SERVER_SSA_BV_13_C		PASS
+TC_SERVER_SSA_BV_14_C		PASS
+TC_SERVER_SSA_BV_15_C		PASS
+TC_SERVER_SSA_BV_16_C		PASS
+TC_SERVER_SSA_BV_17_C		PASS
+TC_SERVER_SSA_BV_18_C		PASS
+TC_SERVER_SSA_BV_19_C		PASS
+TC_SERVER_SSA_BV_20_C		PASS
+TC_SERVER_SSA_BV_21_C		PASS
+TC_SERVER_SSA_BV_22_C		PASS
+TC_SERVER_SSA_BV_23_C		PASS
 -------------------------------------------------------------------------------
-- 
1.9.3

