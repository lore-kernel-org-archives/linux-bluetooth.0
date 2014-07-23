Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Add initial PTS files for AVDTP
Date: Wed, 23 Jul 2014 12:19:43 +0200
Message-Id: <1406110783-11163-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am     |   5 +-
 android/pics-avdtp.txt  | 234 +++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-avdtp.txt |  31 +++++++
 android/pts-avdtp.txt   | 236 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 505 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-avdtp.txt
 create mode 100644 android/pixit-avdtp.txt
 create mode 100644 android/pts-avdtp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 5c79c7b..84a05a8 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -292,6 +292,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-hogp.txt \
 				android/pics-scpp.txt \
 				android/pics-dis.txt \
+				android/pics-avdtp.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -316,6 +317,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-dis.txt \
 				android/pixit-rfcomm.txt \
 				android/pixit-spp.txt \
+				android/pixit-avdtp.txt \
 				android/pts-rfcomm.txt \
 				android/pts-spp.txt \
 				android/pts-l2cap.txt \
@@ -339,4 +341,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-sm.txt \
 				android/pts-hogp.txt \
 				android/pts-scpp.txt \
-				android/pts-dis.txt
+				android/pts-dis.txt \
+				android/pts-avdtp.txt
diff --git a/android/pics-avdtp.txt b/android/pics-avdtp.txt
new file mode 100644
index 0000000..be96321
--- /dev/null
+++ b/android/pics-avdtp.txt
@@ -0,0 +1,234 @@
+AVDTP PICS for the PTS tool.
+
+PTS version: 5.2
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory if such role selected
+O - optional
+
+		Versions
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_0_1	False		AVDTP 1.0 (C.1)
+TSPC_AVDTP_0_2	False		AVDTP 1.2 (C.1)
+TSPC_AVDTP_0_3	False		AVDTP 1.3 (C.1)
+-------------------------------------------------------------------------------
+C.1: It is mandatory to select only one of the protocol versions.
+-------------------------------------------------------------------------------
+
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_1_1	False		Source (C.1)
+TSPC_AVDTP_1_2	False		Sink (C.1)
+TSPC_AVDTP_1_3	False		Initiator (C.2)
+TSPC_AVDTP_1_4	False		Aceptor (C.2)
+-------------------------------------------------------------------------------
+C.1: It is mandatory to support at least one of the defined roles.
+C.2: It is within the scope of profiles using the AVDTP specification to
+	mandate Initiator/Acceptor capabilities. It is mandatory to support at
+	least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+		Signaling Message Format (Initiator)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_2_1	True		Transaction label (M)
+TSPC_AVDTP_2_2	True		Packet type (M)
+TSPC_AVDTP_2_3	True		Message type (M)
+TSPC_AVDTP_2_4	True		Signal identifier (M)
+-------------------------------------------------------------------------------
+
+
+		Signaling Channel Establishment/Disconnection (Initiator)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_3_1	False		Establish signaling channel (O)
+TSPC_AVDTP_3_2	False		Disconnect signaling channel (O)
+-------------------------------------------------------------------------------
+
+
+		Stream Discovery and Configuration (Initiator)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_4_1	False		Stream discover command (O)
+TSPC_AVDTP_4_2	False		Stream get capabilities command (C.2)
+TSPC_AVDTP_4_3	False		Set configuration command (O)
+TSPC_AVDTP_4_4	False		Get configuration command (O)
+TSPC_AVDTP_4_5	False		Reconfigure command (O)
+TSPC_AVDTP_4_6	False		Stream get all capabilities command (C.1)
+-------------------------------------------------------------------------------
+C.1: It is optional to support if AVDTP 1.3 is supported, otherwise excluded.
+C.2: Mandatory to support if TSPC_AVDTP_4_6 is supported, otherwise Optional.
+-------------------------------------------------------------------------------
+
+
+		Stream Establishment, Suspension and Release (Initiator)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_5_1	False		Open stream command (O)
+TSPC_AVDTP_5_2	False		Start stream command (O)
+TSPC_AVDTP_5_3	False		Close stream command (O)
+TSPC_AVDTP_5_4	False		Suspend command (O)
+TSPC_AVDTP_5_5	False		Abort stream command (O)
+-------------------------------------------------------------------------------
+
+
+		Security Signaling (Initiator)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_6_1	False		Content security control command (O)
+-------------------------------------------------------------------------------
+
+
+		Message Fragmentation (Initiator)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_7_1	True		Signaling message fragmentation (M)
+-------------------------------------------------------------------------------
+
+
+		Signaling Message Format (Acceptor)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_8_1	True		Transaction label (M)
+TSPC_AVDTP_8_2	True		Packet type (M)
+TSPC_AVDTP_8_3	True		Message type (M)
+TSPC_AVDTP_8_4	True		Signal identifier (M)
+-------------------------------------------------------------------------------
+
+
+		Signaling Channel Establishment/Disconnection (Acceptor)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_9_1	False		Establish signaling channel (O)
+TSPC_AVDTP_9_1	False		Disconnect signaling channel (O)
+-------------------------------------------------------------------------------
+
+
+		Stream Discovery and Configuration (Acceptor)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_10_1	False		Stream discover response (O)
+TSPC_AVDTP_10_2	False		Stream get capabilities response (C.2)
+TSPC_AVDTP_10_3	False		Set configuration response (O)
+TSPC_AVDTP_10_4	False		Get configuration response (O)
+TSPC_AVDTP_10_5	False		Reconfigure response (O)
+TSPC_AVDTP_10_6	False		Stream get all capabilities response (C.1)
+-------------------------------------------------------------------------------
+C.1: It is optional to support if AVDTP 1.3 is supported, otherwise excluded.
+C.2: It is Mandatory to support if TSPC_AVDTP_10_6 is supported, otherwise
+	Optional.
+-------------------------------------------------------------------------------
+
+
+		Stream Establishment, Suspension and Release (Acceptor)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_11_1	False		Open stream response (O)
+TSPC_AVDTP_11_2	False		Start stream response (O)
+TSPC_AVDTP_11_3	False		Close stream response (O)
+TSPC_AVDTP_11_4	False		Suspend response (O)
+TSPC_AVDTP_11_5	False		Abort stream response (O)
+TSPC_AVDTP_11_6	False		General reject message (O)
+-------------------------------------------------------------------------------
+
+
+		Security Signaling (Acceptor)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_12_1	False		Content security control response (O)
+-------------------------------------------------------------------------------
+
+
+		Message Fragmentation (Acceptor)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_13_1	True		Signaling message fragmentation (M)
+-------------------------------------------------------------------------------
+
+
+		Source Capabilities
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_14_1	True		Basic transport service support (M)
+TSPC_AVDTP_14_2	False		Reporting service support (O)
+TSPC_AVDTP_14_3	False		Recovery service support (O)
+TSPC_AVDTP_14_4	False		Multiplexing service support (O)
+TSPC_AVDTP_14_5	False		Robust header compression service support (O)
+TSPC_AVDTP_14_6	False		Delay Reporting (C.1)
+-------------------------------------------------------------------------------
+C.1: It is optional to support if AVDTP 1.3 is supported, else excluded.
+-------------------------------------------------------------------------------
+
+
+		Sink Capabilities
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_15_1	True		Basic transport service support (M)
+TSPC_AVDTP_15_2	False		Reporting service support (O)
+TSPC_AVDTP_15_3	False		Recovery service support (O)
+TSPC_AVDTP_15_4	False		Multiplexing service support (O)
+TSPC_AVDTP_15_5	False		Robust header compression service support (O)
+TSPC_AVDTP_15_6	False		Delay Reporting (C.1)
+-------------------------------------------------------------------------------
+C.1: It is optional to support if AVDTP 1.3 is supported, else excluded.
+-------------------------------------------------------------------------------
+
+
+		Message Error Handling Capabilities
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_16_1	False		Reporting Capability Error (C.1)
+TSPC_AVDTP_16_2	False		Reject Corrupted Messages (C.2)
+TSPC_AVDTP_16_3	False		General Reject Response Includes Signal ID (C.3)
+-------------------------------------------------------------------------------
+C.1: Optional if TSPC_AVDTP_0_2 or TSPC_AVDTP_0_3 supported, excluded
+	otherwise.
+C.2: Optional, excluded if TSPC_AVDTP_16_3 (General Reject Response Includes
+	Signal ID) is supported.
+C.3: Mandatory if TSPC_AVDTP_0_3 supported, otherwise Optional.
+-------------------------------------------------------------------------------
+
+
+		Upper Test Interface
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_17_1	False		Upper Test Interface provided (O)
+-------------------------------------------------------------------------------
+
+
+		L2CAP Capabilities
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_AVDTP_18_1	False		Enhanced Retransmission Mode preferred for
+				signaling channel (O)
+TSPC_AVDTP_18_2	False		Streaming Mode preferred for Media Transport
+				channel (O)
+TSPC_AVDTP_18_3	False		FCS Option (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_AVDTP_18_1 is supported, otherwise Optional.
+-------------------------------------------------------------------------------
diff --git a/android/pixit-avdtp.txt b/android/pixit-avdtp.txt
new file mode 100644
index 0000000..504a126
--- /dev/null
+++ b/android/pixit-avdtp.txt
@@ -0,0 +1,31 @@
+AVDTP PIXIT for the PTS tool.
+
+PTS version: 5.2
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to PTS's bin/audio folder
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name			Value
+-------------------------------------------------------------------------------
+TSPX_SNK_class_of_device	04041C
+TSPX_SRC_class_of_device	080418
+TSPX_security_control_data
+TSPX_content_protection_data
+TSPX_content_protection_type
+TSPX_no_avrcp			TRUE
+TSPX_media_directory
+TSPX_bd_addr_iut		11223344556677 (*&)
+TSPX_delete_link_key		FALSE
+TSPX_pin_code			1234
+TSPX_security_enabled		FALSE
+TSPX_time_guard			300000
+TSPX_use_implicit_send		TRUE
+TSPX_auth_password		0000
+TSPX_auth_user_id		PTS
+TSPX_l2cap_psm			1003
+TSPX_rfcomm_channel		8
+TSPX_no_confirmations		FALSE
+-------------------------------------------------------------------------------
diff --git a/android/pts-avdtp.txt b/android/pts-avdtp.txt
new file mode 100644
index 0000000..db5702f
--- /dev/null
+++ b/android/pts-avdtp.txt
@@ -0,0 +1,236 @@
+PTS test results for AVDTP
+
+PTS version:
+Tested: not tested
+Android version:
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name				Result	Notes
+-------------------------------------------------------------------------------
+TC_ACP_SNK_L2C_EM_BV_02_C		N/A
+TC_ACP_SNK_SIG_FRA_BV_01_C		N/A
+TC_ACP_SNK_SIG_FRA_BV_02_C		N/A
+TC_ACP_SNK_SIG_SEC_BI_01_C		N/A
+TC_ACP_SNK_SIG_SEC_BV_02_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_06_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_08_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_10_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_12_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_14_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_16_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_18_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_20_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_22_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_24_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_26_C		N/A
+TC_ACP_SNK_SIG_SMG_BV_27_C		N/A
+TC_ACP_SNK_SIG_SMG_ESR05_BV_14_C	N/A
+TC_ACP_SNK_SIG_SMG_BI_02_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_03_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_05_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_06_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_08_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_09_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_11_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_12_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_14_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_15_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_17_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_18_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_20_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_21_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_23_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_24_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_26_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_27_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_28_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_29_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_33_C		N/A
+TC_ACP_SNK_SIG_SMG_BI_34_C		N/A
+TC_ACP_SNK_SIG_SMG_ESR04_BI_28_C	N/A
+TC_ACP_SNK_SIG_SMG_ESR05_BI_15_C	N/A
+TC_ACP_SNK_SIG_SYN_BV_01_C		N/A
+TC_ACP_SNK_SIG_SYN_BV_02_C		N/A
+TC_ACP_SNK_SIG_SYN_BV_03_C		N/A
+TC_ACP_SNK_SIG_SYN_BV_04_C		N/A
+TC_ACP_SNK_TRA_BTR_BI_01_C		N/A
+TC_ACP_SNK_TRA_BTR_BV_02_C		N/A
+TC_ACP_SNK_TRA_MUX_BI_01_C		N/A
+TC_ACP_SNK_TRA_MUX_BV_05_C		N/A
+TC_ACP_SNK_TRA_MUX_BV_06_C		N/A
+TC_ACP_SNK_TRA_REC_BI_01_C		N/A
+TC_ACP_SNK_TRA_REC_BV_01_C		N/A
+TC_ACP_SNK_TRA_REC_BV_02_C		N/A
+TC_ACP_SNK_TRA_REP_BI_01_C		N/A
+TC_ACP_SNK_TRA_REP_BV_01_C		N/A
+TC_ACP_SNK_TRA_REP_BV_02_C		N/A
+TC_ACP_SNK_TRA_REP_ESR02_BI_01_C	N/A
+TC_ACP_SNK_TRA_RHC_BI_01_C		N/A
+TC_ACP_SNK_TRA_RHC_BV_01_C		N/A
+TC_ACP_SNK_TRA_RHC_BV_02_C		N/A
+TC_ACP_SRC_L2C_EM_BV_02_C		N/A
+TC_ACP_SRC_SIG_FRA_BV_01_C		N/A
+TC_ACP_SRC_SIG_FRA_BV_02_C		N/A
+TC_ACP_SRC_SIG_SEC_BI_01_C		N/A
+TC_ACP_SRC_SIG_SEC_BV_02_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_06_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_08_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_10_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_12_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_14_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_16_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_18_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_20_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_22_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_24_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_26_C		N/A
+TC_ACP_SRC_SIG_SMG_BV_27_C		N/A
+TC_ACP_SRC_SIG_SMG_ESR05_BV_14_C	N/A
+TC_ACP_SRC_SIG_SMG_BI_02_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_03_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_05_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_06_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_08_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_09_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_11_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_12_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_14_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_15_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_17_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_18_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_20_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_21_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_23_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_24_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_26_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_27_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_28_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_29_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_33_C		N/A
+TC_ACP_SRC_SIG_SMG_BI_34_C		N/A
+TC_ACP_SRC_SIG_SMG_ESR04_BI_28_C	N/A
+TC_ACP_SRC_SIG_SMG_ESR05_BI_15_C	N/A
+TC_ACP_SRC_SIG_SYN_BV_05_C		N/A
+TC_ACP_SRC_SIG_SYN_BV_06_C		N/A
+TC_ACP_SRC_TRA_BTR_BI_01_C		N/A
+TC_ACP_SRC_TRA_BTR_BV_01_C		N/A
+TC_ACP_SRC_TRA_MUX_BI_01_C		N/A
+TC_ACP_SRC_TRA_MUX_BV_05_C		N/A
+TC_ACP_SRC_TRA_MUX_BV_06_C		N/A
+TC_ACP_SRC_TRA_REC_BI_01_C		N/A
+TC_ACP_SRC_TRA_REC_BV_01_C		N/A
+TC_ACP_SRC_TRA_REC_BV_02_C		N/A
+TC_ACP_SRC_TRA_REP_BI_01_C		N/A
+TC_ACP_SRC_TRA_REP_BV_01_C		N/A
+TC_ACP_SRC_TRA_REP_BV_02_C		N/A
+TC_ACP_SRC_TRA_REP_ESR02_BI_01_C	N/A
+TC_ACP_SRC_TRA_RHC_BI_01_C		N/A
+TC_ACP_SRC_TRA_RHC_BV_01_C		N/A
+TC_ACP_SRC_TRA_RHC_BV_02_C		N/A
+TC_INT_SNK_L2C_BM_BV_03_C		N/A
+TC_INT_SNK_L2C_BM_BV_06_C		N/A
+TC_INT_SNK_SIG_FRA_BV_01_C		N/A
+TC_INT_SNK_SIG_FRA_BV_02_C		N/A
+TC_INT_SNK_SIG_SEC_BV_01_C		N/A
+TC_INT_SNK_SIG_SMG_BV_05_C		N/A
+TC_INT_SNK_SIG_SMG_BV_07_C		N/A
+TC_INT_SNK_SIG_SMG_BV_09_C		N/A
+TC_INT_SNK_SIG_SMG_BV_11_C		N/A
+TC_INT_SNK_SIG_SMG_BV_13_C		N/A
+TC_INT_SNK_SIG_SMG_BV_15_C		N/A
+TC_INT_SNK_SIG_SMG_BV_19_C		N/A
+TC_INT_SNK_SIG_SMG_BV_23_C		N/A
+TC_INT_SNK_SIG_SMG_BV_25_C		N/A
+TC_INT_SNK_SIG_SMG_BV_28_C		N/A
+TC_INT_SNK_SIG_SMG_BV_31_C		N/A
+TC_INT_SNK_SIG_SMG_ESR05_BV_13_C	N/A
+TC_INT_SNK_SIG_SMG_BI_01_C		N/A
+TC_INT_SNK_SIG_SMG_BI_04_C		N/A
+TC_INT_SNK_SIG_SMG_BI_07_C		N/A
+TC_INT_SNK_SIG_SMG_BI_10_C		N/A
+TC_INT_SNK_SIG_SMG_BI_13_C		N/A
+TC_INT_SNK_SIG_SMG_BI_16_C		N/A
+TC_INT_SNK_SIG_SMG_BI_19_C		N/A
+TC_INT_SNK_SIG_SMG_BI_22_C		N/A
+TC_INT_SNK_SIG_SMG_BI_25_C		N/A
+TC_INT_SNK_SIG_SMG_BI_30_C		N/A
+TC_INT_SNK_SIG_SMG_BI_32_C		N/A
+TC_INT_SNK_SIG_SMG_BI_35_C		N/A
+TC_INT_SNK_SIG_SMG_BI_36_C		N/A
+TC_INT_SNK_SIG_SMG_ESR05_BI_13_C	N/A
+TC_INT_SNK_SIG_SYN_BV_01_C		N/A
+TC_INT_SNK_SIG_SYN_BV_02_C		N/A
+TC_INT_SNK_SIG_SYN_BV_03_C		N/A
+TC_INT_SNK_SIG_SYN_BV_04_C		N/A
+TC_INT_SNK_TRA_BTR_BI_01_C		N/A
+TC_INT_SNK_TRA_BTR_BV_02_C		N/A
+TC_INT_SNK_TRA_MUX_BI_01_C		N/A
+TC_INT_SNK_TRA_MUX_BV_05_C		N/A
+TC_INT_SNK_TRA_MUX_BV_06_C		N/A
+TC_INT_SNK_TRA_REC_BI_01_C		N/A
+TC_INT_SNK_TRA_REC_BV_01_C		N/A
+TC_INT_SNK_TRA_REC_BV_02_C		N/A
+TC_INT_SNK_TRA_REP_BI_01_C		N/A
+TC_INT_SNK_TRA_REP_BV_01_C		N/A
+TC_INT_SNK_TRA_REP_BV_02_C		N/A
+TC_INT_SNK_TRA_REP_ESR02_BI_01_C	N/A
+TC_INT_SNK_TRA_RHC_BI_01_C		N/A
+TC_INT_SNK_TRA_RHC_BV_01_C		N/A
+TC_INT_SNK_TRA_RHC_BV_02_C		N/A
+TC_INT_SRC_L2C_BM_BV_03_C		N/A
+TC_INT_SRC_L2C_BM_BV_06_C		N/A
+TC_INT_SRC_SIG_FRA_BV_01_C		N/A
+TC_INT_SRC_SIG_FRA_BV_02_C		N/A
+TC_INT_SRC_SIG_SEC_BV_01_C		N/A
+TC_INT_SRC_SIG_SMG_BV_05_C		N/A
+TC_INT_SRC_SIG_SMG_BV_07_C		N/A
+TC_INT_SRC_SIG_SMG_BV_09_C		N/A
+TC_INT_SRC_SIG_SMG_BV_11_C		N/A
+TC_INT_SRC_SIG_SMG_BV_13_C		N/A
+TC_INT_SRC_SIG_SMG_BV_15_C		N/A
+TC_INT_SRC_SIG_SMG_BV_17_C		N/A
+TC_INT_SRC_SIG_SMG_BV_19_C		N/A
+TC_INT_SRC_SIG_SMG_BV_21_C		N/A
+TC_INT_SRC_SIG_SMG_BV_23_C		N/A
+TC_INT_SRC_SIG_SMG_BV_25_C		N/A
+TC_INT_SRC_SIG_SMG_BV_28_C		N/A
+TC_INT_SRC_SIG_SMG_BV_31_C		N/A
+TC_INT_SRC_SIG_SMG_ESR05_BV_13_C	N/A
+TC_INT_SRC_SIG_SMG_BI_01_C		N/A
+TC_INT_SRC_SIG_SMG_BI_04_C		N/A
+TC_INT_SRC_SIG_SMG_BI_07_C		N/A
+TC_INT_SRC_SIG_SMG_BI_10_C		N/A
+TC_INT_SRC_SIG_SMG_BI_13_C		N/A
+TC_INT_SRC_SIG_SMG_BI_16_C		N/A
+TC_INT_SRC_SIG_SMG_BI_19_C		N/A
+TC_INT_SRC_SIG_SMG_BI_22_C		N/A
+TC_INT_SRC_SIG_SMG_BI_25_C		N/A
+TC_INT_SRC_SIG_SMG_BI_30_C		N/A
+TC_INT_SRC_SIG_SMG_BI_32_C		N/A
+TC_INT_SRC_SIG_SMG_BI_35_C		N/A
+TC_INT_SRC_SIG_SMG_BI_36_C		N/A
+TC_INT_SRC_SIG_SMG_ESR05_BI_13_C	N/A
+TC_INT_SRC_SIG_SYN_BV_05_C		N/A
+TC_INT_SRC_SIG_SYN_BV_06_C		N/A
+TC_INT_SRC_TRA_BTR_BI_01_C		N/A
+TC_INT_SRC_TRA_BTR_BV_01_C		N/A
+TC_INT_SRC_TRA_MUX_BI_01_C		N/A
+TC_INT_SRC_TRA_MUX_BV_05_C		N/A
+TC_INT_SRC_TRA_MUX_BV_06_C		N/A
+TC_INT_SRC_TRA_REC_BI_01_C		N/A
+TC_INT_SRC_TRA_REC_BV_01_C		N/A
+TC_INT_SRC_TRA_REC_BV_02_C		N/A
+TC_INT_SRC_TRA_REP_BI_01_C		N/A
+TC_INT_SRC_TRA_REP_BV_01_C		N/A
+TC_INT_SRC_TRA_REP_BV_02_C		N/A
+TC_INT_SRC_TRA_REP_ESR02_BI_01_C	N/A
+TC_INT_SRC_TRA_RHC_BI_01_C		N/A
+TC_INT_SRC_TRA_RHC_BV_01_C		N/A
+TC_INT_SRC_TRA_RHC_BV_02_C		N/A
+-------------------------------------------------------------------------------
-- 
1.8.5.3

