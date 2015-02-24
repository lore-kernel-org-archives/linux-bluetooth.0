Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/3] android/pts: Add PICS, PIXIT and initial SDP PTS tests results
Date: Tue, 24 Feb 2015 13:06:00 +0100
Message-Id: <1424779561-12403-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1424779561-12403-1-git-send-email-szymon.janc@tieto.com>
References: <1424779561-12403-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastian.chlad@tieto.com>

This adds PTS 6.0 SDP test files.
---
 android/Makefile.am   |  2 ++
 android/pics-sdp.txt  | 81 ++++++++++++++++++++++++++-------------------------
 android/pixit-sdp.txt | 45 ++++++++++++++++++++++++++++
 android/pts-sdp.txt   | 19 ++++++++++++
 4 files changed, 108 insertions(+), 39 deletions(-)
 create mode 100644 android/pixit-sdp.txt
 create mode 100644 android/pts-sdp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 3ea32e9..57c3733 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -284,6 +284,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-spp.txt \
 				android/pixit-avdtp.txt \
 				android/pixit-gavdp.txt \
+				android/pixit-sdp.txt \
 				android/pts-rfcomm.txt \
 				android/pts-spp.txt \
 				android/pts-l2cap.txt \
@@ -310,3 +311,4 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-dis.txt \
 				android/pts-avdtp.txt \
 				android/pts-gavdp.txt
+				android/pts-sdp.txt
diff --git a/android/pics-sdp.txt b/android/pics-sdp.txt
index cb98130..9aae190 100644
--- a/android/pics-sdp.txt
+++ b/android/pics-sdp.txt
@@ -1,5 +1,8 @@
+SDP PICS for the PTS tool.
 
-* - different than BITE defaults
+PTS version: 6.0
+
+* - different than PTS defaults
 # - not yet implemented/supported
 
 M - mandatory
@@ -10,9 +13,9 @@ O - optional
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.1.1		True		Support for 128 bit UUID (M)
-E.1.2		True		Support for 32 bit UUID	(M)
-E.1.3		True		Support for 16 bit UUID (M)
+TSPC_SDP_1_1	True		Support for 128 bit UUID (M)
+TSPC_SDP_1_2	True		Support for 32 bit UUID	(M)
+TSPC_SDP_1_3	True		Support for 16 bit UUID (M)
 -------------------------------------------------------------------------------
 
 
@@ -20,8 +23,8 @@ E.1.3		True		Support for 16 bit UUID (M)
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.1b.1		True		Support for server role (C.1)
-E.1b.2		True		Support for client role (C.1)
+TSPC_SDP_1b_1	True (*)	Support for server role (C.1)
+TSPC_SDP_1b_2	True (*)	Support for client role (C.1)
 -------------------------------------------------------------------------------
 C.1 Mandatory to support at least one of the roles
 -------------------------------------------------------------------------------
@@ -31,11 +34,11 @@ C.1 Mandatory to support at least one of the roles
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.2.1		True		Support for respond on search of single
+TSPC_SDP_2_1	True (*)	Support for respond on search of single
 				Service, using ServiceSearchRequest (C.2)
-E.2.2		True		Support for respond on search of Service,
+TSPC_SDP_2_2	True (*)	Support for respond on search of Service,
 				using continuation state (O)
-E.2.3		True		Search for services using the continuation
+TSPC_SDP_2_3	True (*)	Search for services using the continuation
 				state (C.1)
 -------------------------------------------------------------------------------
 C.1 Mandatory to support if the client role is supported (1b/2)
@@ -47,7 +50,7 @@ C.2 Mandatory to support if the server role is supported (1b/1)
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.3.1		True		Support for error response on Service search
+TSPC_SDP_3_1	True		Support for error response on Service search
 				request (M)
 -------------------------------------------------------------------------------
 
@@ -56,11 +59,11 @@ E.3.1		True		Support for error response on Service search
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.4.1		True		Support for respond on search of
+TSPC_SDP_4_1	True		Support for respond on search of
 				Attribute(s) (M)
-E.4.2		True		Support for respond on search of
+TSPC_SDP_4_2	True (*)	Support for respond on search of
 				Attribute, using continuation state (O)
-E.4.3		True		Support for respond on search on
+TSPC_SDP_4_3	True (*)	Support for respond on search on
 				attribute AdditionalProtocolDescriptorList (O)
 -------------------------------------------------------------------------------
 
@@ -69,7 +72,7 @@ E.4.3		True		Support for respond on search on
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.5.1		True		Support for error response on Attribute
+TSPC_SDP_5_1	True		Support for error response on Attribute
 				search request (M)
 -------------------------------------------------------------------------------
 
@@ -78,11 +81,11 @@ E.5.1		True		Support for error response on Attribute
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.6.1		True		Support for respond on search for Service(s)
+TSPC_SDP_6_1	True		Support for respond on search for Service(s)
 				and Attribute(s) (M)
-E.6.2		True		Support for respond on search of Attribute,
+TSPC_SDP_6_2	True (*)	Support for respond on search of Attribute,
 				using continuation state (O)
-E.6.3		True		Support for respond on search on attribute
+TSPC_SDP_6_3	True (*)	Support for respond on search on attribute
 				AdditionalProtocolDescriptorList on existing
 				service (O)
 -------------------------------------------------------------------------------
@@ -92,7 +95,7 @@ E.6.3		True		Support for respond on search on attribute
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.7.1		True		Support for error response on Service and
+TSPC_SDP_7_1	True		Support for error response on Service and
 				Attribute request (M)
 -------------------------------------------------------------------------------
 
@@ -101,10 +104,10 @@ E.7.1		True		Support for error response on Service and
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.8.1		True		Support for browsing, using
+TSPC_SDP_8_1	True (*)	Support for browsing, using
 				SDP_ServiceSearchRequest and
 				SDP_ServiceAttributeRequest (O)
-E.8.2		True		Support for browsing, using
+TSPC_SDP_8_2	True (*)	Support for browsing, using
 				SDP_ServiceSearchAttributeRequest (O)
 -------------------------------------------------------------------------------
 
@@ -113,25 +116,25 @@ E.8.2		True		Support for browsing, using
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-E.9.1		True		ServiceID (O)
-E.9.2		True		ProtocolDescriptorList (O)
-E.9.3		True		ServiceRecordState (O)
-E.9.4		True		ServiceInfoTimeToLive (O)
-E.9.5		True		BrowseGroupList (O)
-E.9.6		True		LanguageBaseAttributeIdList (O)
-E.9.7		True		ServiceAvailability (O)
-E.9.8		True		IconURL (O)
-E.9.9		True		ServiceName (O)
-E.9.10		True		ServiceDescription (O)
-E.9.11		True		ProviderName (O)
-E.9.12		True		VersionNumberList (O)
-E.9.13		True		ServiceDataBaseState (O)
-E.9.14		True		BluetoothProfileDescriptorList (O)
-E.9.15		True		DocumentationURL (O)
-E.9.16		True		ClientExecutableURL (O)
-E.9.17		True		AdditionalProtocolDescriptorList (C.1)
-E.9.18		True		ServiceRecordHandle (M)
-E.9.19		True		ServiceClassIDList (M)
+TSPC_SDP_9_1	True (*)	ServiceID (O)
+TSPC_SDP_9_2	True (*)	ProtocolDescriptorList (O)
+TSPC_SDP_9_3	True (*)	ServiceRecordState (O)
+TSPC_SDP_9_4	True (*)	ServiceInfoTimeToLive (O)
+TSPC_SDP_9_5	True (*)	BrowseGroupList (O)
+TSPC_SDP_9_6	True (*)	LanguageBaseAttributeIdList (O)
+TSPC_SDP_9_7	True (*)	ServiceAvailability (O)
+TSPC_SDP_9_8	True (*)	IconURL (O)
+TSPC_SDP_9_9	True (*)	ServiceName (O)
+TSPC_SDP_9_10	True (*)	ServiceDescription (O)
+TSPC_SDP_9_11	True (*)	ProviderName (O)
+TSPC_SDP_9_12	True (*)	VersionNumberList (O)
+TSPC_SDP_9_13	True (*)	ServiceDataBaseState (O)
+TSPC_SDP_9_14	True (*)	BluetoothProfileDescriptorList (O)
+TSPC_SDP_9_15	True (*)	DocumentationURL (O)
+TSPC_SDP_9_16	True (*)	ClientExecutableURL (O)
+TSPC_SDP_9_17	True (*)	AdditionalProtocolDescriptorList (C.1)
+TSPC_SDP_9_18	True		ServiceRecordHandle (M)
+TSPC_SDP_9_19	True		ServiceClassIDList (M)
 -------------------------------------------------------------------------------
 C.1: Optional if 9/2 is supported, otherwise excluded
 -------------------------------------------------------------------------------
diff --git a/android/pixit-sdp.txt b/android/pixit-sdp.txt
new file mode 100644
index 0000000..80b5931
--- /dev/null
+++ b/android/pixit-sdp.txt
@@ -0,0 +1,45 @@
+SDP PIXIT for the PTS tool.
+
+PTS version: 6.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+^ - should be set accordingly
+# - should be set according to the reported phone number's type
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name							Value
+-------------------------------------------------------------------------------
+TSPX_sdp_service_search_pattern					0100
+TSPX_sdp_service_search_pattern_no_results			EEEE
+TSPX_sdp_service_search_additional_protocol_descriptor_list
+TSPX_sdp_service_search_bluetooth_profile_descriptor_list
+TSPX_sdp_service_search_pattern_browse_group_list
+TSPX_sdp_service_search_pattern_client_exe_url
+TSPX_sdp_service_search_pattern_documentation_url
+TSPX_sdp_service_search_pattern_icon_url
+TSPX_sdp_service_search_pattern_language_base_attribute_id_list
+TSPX_sdp_service_search_pattern_protocol_descriptor_list
+TSPX_sdp_service_search_pattern_provider_name
+TSPX_sdp_service_search_pattern_service_availability
+TSPX_sdp_service_search_pattern_service_data_base_state
+TSPX_sdp_service_search_pattern_service_description
+TSPX_sdp_service_search_pattern_service_id
+TSPX_sdp_service_search_pattern_service_info_time_to_live
+TSPX_sdp_service_search_pattern_version_number_list
+TSPX_sdp_service_search_pattern_service_name
+TSPX_sdp_service_search_pattern_service_record_state
+TSPX_sdp_unsupported_attribute_id
+TSPX_security_enabled						FALSE
+TSPX_delete_link_key						FALSE
+TSPX_bd_addr_iut						112233445566(*&)
+TSPX_class_of_device_pts					200404
+TSPX_class_of_device_test_pts_initiator				TRUE
+TSPX_limited_inquiry_used					FALSE
+TSPX_pin_code							0000
+TSPX_time_guard							200000
+TSPX_device_search_time						20
+TSPX_use_implicit_send						TRUE
+TSPX_secure_simple_pairing_pass_key_confirmation		FALSE
+-------------------------------------------------------------------------------
diff --git a/android/pts-sdp.txt b/android/pts-sdp.txt
new file mode 100644
index 0000000..1e29152
--- /dev/null
+++ b/android/pts-sdp.txt
@@ -0,0 +1,19 @@
+PTS test results for SDP
+
+PTS version: 6.0
+Tested: 16-December-2014
+Android version: 5.0
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+NONE	test result is none
+
+-------------------------------------------------------------------------------
+Test Name				Result	Notes
+-------------------------------------------------------------------------------
+TC_SERVER_BRW_BV_01_C			PASS
+TC_SERVER_BRW_BV_01_C			PASS
+-------------------------------------------------------------------------------
-- 
1.9.3

