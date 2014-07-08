Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Initial PTS docs for RFCOMM
Date: Tue,  8 Jul 2014 16:10:42 +0200
Message-Id: <1404828642-14050-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bite-rfcomm.txt  | 35 ---------------------
 android/pics-rfcomm.txt  | 79 ++++++++++++++++++++++++++++--------------------
 android/pixit-rfcomm.txt | 28 +++++++++++++++++
 android/pts-rfcomm.txt   | 34 +++++++++++++++++++++
 4 files changed, 108 insertions(+), 68 deletions(-)
 delete mode 100644 android/bite-rfcomm.txt
 create mode 100644 android/pixit-rfcomm.txt
 create mode 100644 android/pts-rfcomm.txt

diff --git a/android/bite-rfcomm.txt b/android/bite-rfcomm.txt
deleted file mode 100644
index cf0e94a..0000000
--- a/android/bite-rfcomm.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-
-BITE test results for RFCOMM
-
-Results:
-PASS	test passed
-FAIL	test failed
-INC	test is inconclusive
-N/A	test is disabled due to PICS setup
-
--------------------------------------------------------------------------------
-Test Name	Result	Notes
--------------------------------------------------------------------------------
-TP/RFC/BV-01-C	PASS
-TP/RFC/BV-02-C	PASS
-TP/RFC/BV-03-C	PASS
-TP/RFC/BV-04-C	PASS
-TP/RFC/BV-05-C	PASS
-TP/RFC/BV-06-C	PASS
-TP/RFC/BV-07-C	PASS
-TP/RFC/BV-08-C	PASS
-TP/RFC/BV-09-C	PASS
-TP/RFC/BV-10-C	PASS
-TP/RFC/BV-11-C	PASS
-TP/RFC/BV-12-C	PASS
-TP/RFC/BV-13-C	PASS
-TP/RFC/BV-14-C	PASS
-TP/RFC/BV-15-C	PASS
-TP/RFC/BV-17-C	PASS
-TP/RFC/BV-19-C	PASS
-TP/RFC/BV-20-C	PASS
-TP/RFC/BV-21-C	PASS
-TP/RFC/BV-22-C	PASS
-TP/RFC/BV-23-C	PASS
-TP/RFC/BV-24-C	PASS
--------------------------------------------------------------------------------
diff --git a/android/pics-rfcomm.txt b/android/pics-rfcomm.txt
index 09cea18..36a4578 100644
--- a/android/pics-rfcomm.txt
+++ b/android/pics-rfcomm.txt
@@ -1,17 +1,19 @@
+RFCOMM PICS for the PTS tool.
 
-* - different than BITE defaults
+PTS version: 5.2
+
+* - different than PTS defaults
 # - not yet implemented/supported
 
 M - mandatory
 O - optional
 
-
 		Protocol Version
 -------------------------------------------------------------------------------
-Item		Selected	Description
+Parameter Name		Selected	Description
 -------------------------------------------------------------------------------
-F.1.0.1		False		RFCOMM 1.1 with TS 07.10 (C.1)
-F.1.0.2		True		RFCOMM 1.2 with TS 07.10 (C.1)
+TSPC_RFCOMM_0_1		False		RFCOMM 1.1 with TS 07.10 (C.1)
+TSPC_RFCOMM_0_2		True (*)	RFCOMM 1.2 with TS 07.10 (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support one and only one of the protocol versions.
 -------------------------------------------------------------------------------
@@ -19,36 +21,47 @@ C.1: Mandatory to support one and only one of the protocol versions.
 
 		Supported Procedures
 -------------------------------------------------------------------------------
-Item		Selected	Description
--------------------------------------------------------------------------------
-F.1.1.1		True		Initialize RFCOMM Session (C.2)
-F.1.1.2		True		Respond to Initialization of an RFCOMM
-				Session (C.1)
-F.1.1.3		True		Shutdown RFCOMM Session (M)
-F.1.1.4		True		Respond to a Shutdown of an RFCOMM Session (M)
-F.1.1.5		True		Establish DLC (C.2)
-F.1.1.6		True		Respond to Establishment of a DLC (C.1)
-F.1.1.7		True		Disconnect DLC (M)
-F.1.1.8		True		Respond to Disconnection of a DLC (M)
-F.1.1.9		True		Respond to and send MSC Command (M)
-F.1.1.10	True		Initiate Transfer Information (M)
-F.1.1.11	True		Respond to Test Command (M)
-F.1.1.12	True		Send Test Command (O)
-F.1.1.13	True		React to Aggregate Flow Control (M)
-F.1.1.14	True		Respond to RLS Command (M)
-F.1.1.15	False (*)	Send RLS Command (O)
-F.1.1.16	True		Respond to PN Command (M)
-F.1.1.17	True		Send PN Command (C.3)
-F.1.1.18	True		Send Non-Supported Command (NSC) response (C.4)
-F.1.1.19	True		Respond to RPN Command (M)
-F.1.1.18			Send RPN Command (O)
-F.1.1.21	True		Closing Multiplexer by First Sending a DISC
-				Command (O)
-F.1.1.22	True		Support of Credit Based Flow Control (M)
-F.1.1.23	True		IUT Responds to Establishment of a DLC (C.1)
+Parameter Name		Selected	Description
+-------------------------------------------------------------------------------
+TSPC_RFCOMM_1_1		False		Initialize RFCOMM Session (C.2)
+TSPC_RFCOMM_1_2		False		Respond to Initialization of an RFCOMM
+					Session (C.2)
+TSPC_RFCOMM_1_3		True		Shutdown RFCOMM Session (M)
+TSPC_RFCOMM_1_4		True		Respond to a Shutdown of an RFCOMM
+					Session (M)
+TSPC_RFCOMM_1_5		False		Establish DLC (C.2)
+TSPC_RFCOMM_1_6		False		Respond to Establishment of a DLC (C.1)
+TSPC_RFCOMM_1_7		True		Disconnect DLC (M)
+TSPC_RFCOMM_1_8		True		Respond to Disconnection of a DLC (M)
+TSPC_RFCOMM_1_9		True		Respond to and send MSC Command (M)
+TSPC_RFCOMM_1_10	True		Initiate Transfer Information (M)
+TSPC_RFCOMM_1_11	True		Respond to Test Command (M)
+TSPC_RFCOMM_1_12	False		Send Test Command (O)
+TSPC_RFCOMM_1_13	True		React to Aggregate Flow Control (M)
+TSPC_RFCOMM_1_14	True		Respond to RLS Command (M)
+TSPC_RFCOMM_1_15	False		Send RLS Command (O)
+TSPC_RFCOMM_1_16	True		Respond to PN Command (M)
+TSPC_RFCOMM_1_17	False		Send PN Command (C.3)
+TSPC_RFCOMM_1_18	False		Send Non-Supported Command (NSC)
+					response (C.4)
+TSPC_RFCOMM_1_19	True		Respond to RPN Command (M)
+TSPC_RFCOMM_1_20	False		Send RPN Command (O)
+TSPC_RFCOMM_1_21	False		Closing Multiplexer by First Sending
+					a DISC Command (O)
+TSPC_RFCOMM_1_22	True		Support of Credit Based Flow Control (M)
+TSPC_RFCOMM_1_23	False		IUT Responds to Establishment of
+					a DLC (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory if SPP 1/2 (Device B) is supported, otherwise Excluded.
 C.2: Mandatory if SPP 1/1 (Device A) is supported, otherwise Excluded.
-C.3: Mandatory if SPP 1/1 (Device A) is supported, otherwise Optional
+C.3: Mandatory if SPP 1/1 (Device A) is supported, otherwise Optional.
 C.4: Mandatory to support if 0/2 (RFCOMM 1.2) is supported, otherwise Optional.
 -------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+Parameter Name		Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SPP_2_1		False		Channel the tester should use when
+					connecting to the IUT (Default "")
+-------------------------------------------------------------------------------
diff --git a/android/pixit-rfcomm.txt b/android/pixit-rfcomm.txt
new file mode 100644
index 0000000..a266ab3
--- /dev/null
+++ b/android/pixit-rfcomm.txt
@@ -0,0 +1,28 @@
+RFCOMM PIXIT for the PTS tool.
+
+PTS version: 5.2
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to PTS's bin/audio folder
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name				Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut			11223344556677 (*&)
+TSPX_delete_link_key			FALSE
+TSPX_pin_code				1234
+TSPX_security_enabled			TRUE
+TSPX_time_guard				300000
+TSPX_use_implicit_send			TRUE
+TSPX_service_name_tester		COM5
+TSPX_class_of_device_tester		200408
+TSPX_server_channel_iut			00
+TSPX_verification_pattern_length	4
+TSPX_T1_Acknowledgement_Timer		20000
+TSPX_T1_Acknowledgement_Timer_Dlc	300000
+TSPX_T2_Response_Timer			20000
+TSPX_max_frame_size_iut			127
+TSPX_RPN_parameters_iut			0302001113
+-------------------------------------------------------------------------------
diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
new file mode 100644
index 0000000..cf60efb
--- /dev/null
+++ b/android/pts-rfcomm.txt
@@ -0,0 +1,34 @@
+PTS test results for RFCOMM
+
+PTS version: 5.2
+Tested: 08-July-2014
+Android version: 4.4.4
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+NONE	test result is none
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_RFC_BV_01_C		INC
+TC_RFC_BV_02_C		INC
+TC_RFC_BV_03_C		INC
+TC_RFC_BV_04_C		INC
+TC_RFC_BV_05_C		INC
+TC_RFC_BV_06_C		INC
+TC_RFC_BV_07_C		INC
+TC_RFC_BV_08_C		INC
+TC_RFC_BV_11_C		INC
+TC_RFC_BV_13_C		INC
+TC_RFC_BV_14_C		N/A
+TC_RFC_BV_15_C		INC
+TC_RFC_BV_17_C		INC
+TC_RFC_BV_19_C		INC
+TC_RFC_BV_21_C		INC
+TC_RFC_BV_22_C		INC
+TC_RFC_BV_25_C		INC
+-------------------------------------------------------------------------------
-- 
1.8.5.3

