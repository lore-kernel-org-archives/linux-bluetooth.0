Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Initial test files for BAS
Date: Fri, 20 Jun 2014 11:52:21 +0200
Message-Id: <1403257941-26754-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am   |  5 ++++-
 android/pics-bas.txt  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-bas.txt | 25 +++++++++++++++++++++
 android/pts-bas.txt   | 26 +++++++++++++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-bas.txt
 create mode 100644 android/pixit-bas.txt
 create mode 100644 android/pts-bas.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 51c8253..09128b3 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -248,6 +248,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-sm.txt \
 				android/pics-mps.txt \
 				android/pics-hogp.txt \
+				android/pics-bas.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -268,6 +269,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-sm.txt \
 				android/pixit-mps.txt \
 				android/pixit-hogp.txt \
+				android/pixit-bas.txt \
 				android/bite-rfcomm.txt \
 				android/bite-spp.txt \
 				android/pts-l2cap.txt \
@@ -289,4 +291,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-mcap.txt \
 				android/pts-mps.txt \
 				android/pts-sm.txt \
-				android/pts-hogp.txt
+				android/pts-hogp.txt \
+				android/pts-bas.txt
diff --git a/android/pics-bas.txt b/android/pics-bas.txt
new file mode 100644
index 0000000..170caa0
--- /dev/null
+++ b/android/pics-bas.txt
@@ -0,0 +1,62 @@
+BAS PICS for the PTS tool.
+
+PTS version: 5.1
+
+* - different than PTS defaults
+
+M - mandatory
+O - optional
+
+		Transport Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_BAS_1_1	False (*)	Service supported over BR/EDR (C.1)
+TSPC_BAS_1_2	True		Service supported over LE (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of the defined transports.
+-------------------------------------------------------------------------------
+
+
+		Service Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_BAS_2_1	True		Battery Service (M)
+TSPC_BAS_2_2	True		Battery Service, Multiple Instances (O)
+TSPC_BAS_2_3	True		Battery Level Characteristic (M)
+TSPC_BAS_2_4	True		Battery Level Characteristic Presentation
+				Format Descriptor (C.1)
+TSPC_BAS_2_5	True		Battery Level Client Characteristic
+				Configuration Descriptor (C.2)
+TSPC_BAS_2_6	False (*)	SDP Interoperability (C.3)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 2/2 is supported, otherwise optional.
+C.2: Mandatory if 2a/1 is supported, otherwise excluded.
+C.3: Mandatory if 1/1 (BR/EDR) is supported, otherwise excluded.
+-------------------------------------------------------------------------------
+
+
+		Service Characteristics
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_BAS_2a_1	True		Notify Battery Level characteristic (O)
+-------------------------------------------------------------------------------
+
+
+		GATT Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_BAS_3_1	True		Generic Attribute Profile Server (M)
+TSPC_BAS_3_2	False (*)	Attribute Protocol Supported over BR/EDR (C.1)
+TSPC_BAS_3_3	True		Attribute Protocol Supported over LE (C.2)
+TSPC_BAS_3_4	True		Notifications (O)
+TSPC_BAS_3_5	True		Read Characteristic Descriptors (M)
+TSPC_BAS_3_6	True		Write Characteristic Descriptors (C.3)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 1/1, otherwise excluded for this service.
+C.2: Mandatory if 1/2, otherwise excluded for this service.
+C.3: Mandatory if 2/5, otherwise excluded for this service.
+-------------------------------------------------------------------------------
diff --git a/android/pixit-bas.txt b/android/pixit-bas.txt
new file mode 100644
index 0000000..d50c8c0
--- /dev/null
+++ b/android/pixit-bas.txt
@@ -0,0 +1,25 @@
+BAS PIXIT for the PTS tool.
+
+PTS version: 5.1
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_time_guard						180000
+TSPX_use_implicit_send					TRUE
+TSPX_tester_database_file				C:/Program Files/...
+TSPX_mtu_size						23
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_delete_link_key					FALSE
+TSPX_pin_code						0000
+TSPX_use_dynamic_pin					FALSE
+TSPX_delete_ltk						FALSE
+TSPX_security_enabled					FALSE
+TSPX_iut_setup_att_over_br_edr				FALSE
+TSPX_tester_appearance					0000
+-------------------------------------------------------------------------------
diff --git a/android/pts-bas.txt b/android/pts-bas.txt
new file mode 100644
index 0000000..0e35de3
--- /dev/null
+++ b/android/pts-bas.txt
@@ -0,0 +1,26 @@
+PTS test results for BAS
+
+PTS version:
+Tested: not tested
+Android version:
+kernel version:
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
+TC_SD_BV_01_C		INC
+TC_DEC_BV_01_C		INC
+TC_DES_BV_01_C		INC
+TC_DES_BV_02_C		INC
+TC_CR_BV_01_C		INC
+TC_CON_BV_01_C		INC
+TC_CN_BV_01_C		INC
+TC_SDP_BV_01_C		N/A
+-------------------------------------------------------------------------------
-- 
1.8.5.3

