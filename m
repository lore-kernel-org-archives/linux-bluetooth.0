Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Initial test files for DIS
Date: Fri, 20 Jun 2014 12:07:06 +0200
Message-Id: <1403258826-28190-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1403258826-28190-1-git-send-email-sebastian.chlad@tieto.com>
References: <1403258826-28190-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-dis.txt  | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-dis.txt | 25 ++++++++++++++++++++++
 android/pts-dis.txt   | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 android/pics-dis.txt
 create mode 100644 android/pixit-dis.txt
 create mode 100644 android/pts-dis.txt

diff --git a/android/pics-dis.txt b/android/pics-dis.txt
new file mode 100644
index 0000000..e0c61de
--- /dev/null
+++ b/android/pics-dis.txt
@@ -0,0 +1,59 @@
+DIS PICS for the PTS tool.
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
+TSPC_DIS_1_1	False (*)	Service supported over BR/EDR (C.1)
+TSPC_DIS_1_2	True		Service supported over LE (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of 1/1 or 1/2.
+-------------------------------------------------------------------------------
+
+
+		Service Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_DIS_2_1			Device Information Service (M)
+TSPC_DIS_2_2			Manufacturer Name String Characteristic (O)
+TSPC_DIS_2_3			Model Number String Characteristic (O)
+TSPC_DIS_2_4			Serial Number String Characteristic (O)
+TSPC_DIS_2_5			Hardware Revision String Characteristic (O)
+TSPC_DIS_2_6			Firmware Revision String Characteristic (O)
+TSPC_DIS_2_7			Software Revision String Characteristic (O)
+TSPC_DIS_2_8			System ID Characteristic (O)
+TSPC_DIS_2_9			IEEE 11073-20601 Regulatory Certification
+				Data List Characteristic (O)
+TSPC_DIS_2_10	False		SDP Interoperability (C.1)
+TSPC_DIS_2_11			PnP ID (O)
+-------------------------------------------------------------------------------
+C.1: Mandatory if 1/1 (BR/EDR) is supported, otherwise excluded.
+-------------------------------------------------------------------------------
+
+
+		GATT Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_DIS_3_1	True		Generic Attribute Profile Server (M)
+-------------------------------------------------------------------------------
+
+
+		SDP Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_DIS_4_1	False (*)	Support for server role (M)
+TSPC_DIS_4_2	False (*)	ProtocolDescriptorList (M)
+TSPC_DIS_4_3	False (*)	BrowseGroupList (M)
+-------------------------------------------------------------------------------
+Note: Marked as False as TSPC_DIS_1_1 is set to False
+-------------------------------------------------------------------------------
diff --git a/android/pixit-dis.txt b/android/pixit-dis.txt
new file mode 100644
index 0000000..366bb5a
--- /dev/null
+++ b/android/pixit-dis.txt
@@ -0,0 +1,25 @@
+DIS PIXIT for the PTS tool.
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
diff --git a/android/pts-dis.txt b/android/pts-dis.txt
new file mode 100644
index 0000000..8734611
--- /dev/null
+++ b/android/pts-dis.txt
@@ -0,0 +1,38 @@
+PTS test results for DIS
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
+TC_DEC_BV_02_C		INC
+TC_DEC_BV_03_C		INC
+TC_DEC_BV_04_C		INC
+TC_DEC_BV_05_C		INC
+TC_DEC_BV_06_C		INC
+TC_DEC_BV_07_C		INC
+TC_DEC_BV_08_C		INC
+TC_DEC_BV_09_C		INC
+TC_CR_BV_01_C		INC
+TC_CR_BV_02_C		INC
+TC_CR_BV_03_C		INC
+TC_CR_BV_04_C		INC
+TC_CR_BV_05_C		INC
+TC_CR_BV_06_C		INC
+TC_CR_BV_07_C		INC
+TC_CR_BV_08_C		INC
+TC_CR_BV_09_C		INC
+TC_SDP_BV_01_C		N/A
+-------------------------------------------------------------------------------
-- 
1.8.5.3

