Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Initial test files for ScPP
Date: Fri, 20 Jun 2014 13:25:32 +0200
Message-Id: <1403263532-3370-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1403263532-3370-1-git-send-email-sebastian.chlad@tieto.com>
References: <1403263532-3370-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am    |   5 +-
 android/pics-scpp.txt  | 143 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-scpp.txt |  24 +++++++++
 android/pts-scpp.txt   |  25 +++++++++
 4 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-scpp.txt
 create mode 100644 android/pixit-scpp.txt
 create mode 100644 android/pts-scpp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 51c8253..08d72c5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -248,6 +248,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-sm.txt \
 				android/pics-mps.txt \
 				android/pics-hogp.txt \
+				android/pics-scpp.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -268,6 +269,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-sm.txt \
 				android/pixit-mps.txt \
 				android/pixit-hogp.txt \
+				android/pixit-scpp.txt \
 				android/bite-rfcomm.txt \
 				android/bite-spp.txt \
 				android/pts-l2cap.txt \
@@ -289,4 +291,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-mcap.txt \
 				android/pts-mps.txt \
 				android/pts-sm.txt \
-				android/pts-hogp.txt
+				android/pts-hogp.txt \
+				android/pts-scpp.txt
diff --git a/android/pics-scpp.txt b/android/pics-scpp.txt
new file mode 100644
index 0000000..5747533
--- /dev/null
+++ b/android/pics-scpp.txt
@@ -0,0 +1,143 @@
+ScPP PICS for the PTS tool.
+
+PTS version: 5.1
+
+* - different than PTS defaults
+
+M - mandatory
+O - optional
+
+		Connection Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_1_1	False (*)	Scan Server (C.1)
+TSPC_ScPP_1_2	True		Scan Client (C.1)
+-------------------------------------------------------------------------------
+Note: C.1 is not explained in the spec for ScPP.
+-------------------------------------------------------------------------------
+
+
+		Transport Requirements
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_2_1	False (*)	Profile supported over BR/EDR (C.1)
+TSPC_ScPP_2_2	True		Profile supported over LE (M)
+-------------------------------------------------------------------------------
+C.1: Excluded for this profile.
+-------------------------------------------------------------------------------
+
+
+		Services - Scan Server
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_3_1	True		Implements Scan Parameters Service (M)
+-------------------------------------------------------------------------------
+
+
+		GAP Requirements - Scan Server Role
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_4_1	True		Peripheral (M)
+TSPC_ScPP_4_2			Directed Connectable Mode (O)
+TSPC_ScPP_4_3	True		Undirected Connectable Mode (M)
+TSPC_ScPP_4_4			Bondable mode (peripheral) (O)
+TSPC_ScPP_4_5			Bonding procedure (peripheral) (O)
+TSPC_ScPP_4_6	True		LE Security Mode 1 (peripheral) (M)
+-------------------------------------------------------------------------------
+
+
+		Scan Server
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_5_1	True		No security (LE Security Level 1) (M)
+TSPC_ScPP_5_2			Unauthenticated no MITM protection. (LE Security
+				Level 2, Just Works) (O)
+TSPC_ScPP_5_3			Authenticated MITM protection (LE Security
+				Level 3, Passkey) (O)
+-------------------------------------------------------------------------------
+
+
+		Client Services Support - Scan Client Role
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_6_1	True		Scan Parameters Service (M)
+-------------------------------------------------------------------------------
+
+
+		Discover Services and Characteristics - Scan Client Role
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_7_1	True		Discover Scan Parameters Service (M)
+TSPC_ScPP_7_2	True		Discover Scan Parameters characteristic:
+				Scan interval Window (M)
+TSPC_ScPP_7_3	True		Discover Scan Parameters characteristic:
+				Scan Refresh (M)
+TSPC_ScPP_7_4	True		Discover Scan Parameters characteristic:
+				Scan Refresh – Client Characteristic
+				Configuration Descriptor (M)
+-------------------------------------------------------------------------------
+
+
+		Features - Client
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_8_1	True		Write Scan Interval Window characteristic (M)
+TSPC_ScPP_8_2	True		Configure Scan Refresh characteristic:
+				Client Characteristic Configuration
+				characteristic descriptor with 0x0001 (M)
+TSPC_ScPP_8_3	True		Notify Scan Refresh characteristic (M)
+-------------------------------------------------------------------------------
+
+
+		GATT Requirements - Scan Client
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_9_1	True		Attribute Protocol supported over LE Transport
+				(M)
+TSPC_ScPP_9_2	True		Generic Attribute Profile Client (M)
+TSPC_ScPP_9_3			Discover All Primary Services (C.1)
+TSPC_ScPP_9_4			Discover Primary Services by Service UUID (C.1)
+TSPC_ScPP_9_5			Discover All Characteristics of a Service (C.2)
+TSPC_ScPP_9_6			Discover Characteristics by UUID (C.2)
+TSPC_ScPP_9_7	True		Discover All Characteristic Descriptors (M)
+TSPC_ScPP_9_8	True		Write without Response (M)
+TSPC_ScPP_9_9	True		Write Characteristic Descriptors (M)
+TSPC_ScPP_9_10	True		Notifications (M)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support one of these sub-procedures for service discovery
+C.2: Mandatory to support one of these sub-procedures for characteristic
+	discovery
+-------------------------------------------------------------------------------
+
+
+		GAP Requirements - Scan Client
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_10_1	True		Central (M)
+TSPC_ScPP_10_2			Bondable mode (central) (O)
+TSPC_ScPP_10_3			Bonding procedure (central) (O)
+TSPC_ScPP_10_4	True		Central (M)
+-------------------------------------------------------------------------------
+
+
+		SM Requirements - Scan Client
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_ScPP_11_1	True		No Security Requirements (LE Security Level 1,
+				No Security) (M)
+TSPC_ScPP_11_2			Unauthenticated no MITM protection (LE Security
+				Level 2, Just Works) (O)
+TSPC_ScPP_11_3			Authenticated MITM protection (LE Security
+				Level 3, Passkey) (O)
+-------------------------------------------------------------------------------
diff --git a/android/pixit-scpp.txt b/android/pixit-scpp.txt
new file mode 100644
index 0000000..a3eb3ce
--- /dev/null
+++ b/android/pixit-scpp.txt
@@ -0,0 +1,24 @@
+ScPP PIXIT for the PTS tool.
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
+TSPX_tester_appearance					0000
+-------------------------------------------------------------------------------
diff --git a/android/pts-scpp.txt b/android/pts-scpp.txt
new file mode 100644
index 0000000..4ad5b51
--- /dev/null
+++ b/android/pts-scpp.txt
@@ -0,0 +1,25 @@
+PTS test results for ScPP
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
+TC_SPDS_SC_BV_01_I	INC
+TC_SPDC_SC_BV_01_I	INC
+TC_SPDC_SC_BV_02_I	INC
+TC_SPDC_SC_BV_03_I	INC
+TC_SPWF_SC_BV_03_I	INC
+TC_SPCF_SC_BV_03_I	INC
+TC_SPNF_SC_BV_03_I	INC
+-------------------------------------------------------------------------------
-- 
1.8.5.3

