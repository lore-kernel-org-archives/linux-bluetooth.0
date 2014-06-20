Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Initial test files for BAS
Date: Fri, 20 Jun 2014 11:33:35 +0200
Message-Id: <1403256815-24627-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-bas.txt  | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-bas.txt | 25 +++++++++++++++++++++
 android/pts-bas.txt   | 26 +++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 android/pics-bas.txt
 create mode 100644 android/pixit-bas.txt
 create mode 100644 android/pts-bas.txt

diff --git a/android/pics-bas.txt b/android/pics-bas.txt
new file mode 100644
index 0000000..2ab247e
--- /dev/null
+++ b/android/pics-bas.txt
@@ -0,0 +1,62 @@
+SM PICS for the PTS tool.
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
index 0000000..48b0b99
--- /dev/null
+++ b/android/pixit-bas.txt
@@ -0,0 +1,25 @@
+SM PIXIT for the PTS tool.
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
index 0000000..101fa12
--- /dev/null
+++ b/android/pts-bas.txt
@@ -0,0 +1,26 @@
+PTS test results for SM
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

