Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1] doc/pts: Add OPP PTS 6.2 results for Linux
Date: Mon, 03 Aug 2015 11:26:31 +0530
Message-id: <1438581391-24176-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test case list and results for OPP profile
tested against Linux-kernel-4.1 (Ubuntu 14.04).
---
 Makefile.am       |   3 +
 doc/pics-opp.txt  | 187 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/pixit-opp.txt |  27 ++++++++
 doc/pts-opp.txt   | 119 ++++++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 doc/pics-opp.txt
 create mode 100644 doc/pixit-opp.txt
 create mode 100644 doc/pts-opp.txt

diff --git a/Makefile.am b/Makefile.am
index ad4a9ae..3df694c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -257,6 +257,9 @@ EXTRA_DIST += doc/alert-api.txt \
 
 EXTRA_DIST += doc/obex-api.txt doc/obex-agent-api.txt
 
+EXTRA_DIST += doc/pics-opp.txt doc/pixit-opp.txt \
+		doc/pts-opp.txt
+
 EXTRA_DIST += tools/magic.btsnoop
 
 AM_CFLAGS += @DBUS_CFLAGS@ @GLIB_CFLAGS@
diff --git a/doc/pics-opp.txt b/doc/pics-opp.txt
new file mode 100644
index 0000000..f3bd0aa
--- /dev/null
+++ b/doc/pics-opp.txt
@@ -0,0 +1,187 @@
+OPP PICS for the PTS tool.
+
+PTS version: 6.2.0
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory
+O - optional
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_OPP_1_1	True (*)	Role: Object Push Client (C.1)
+TSPC_OPP_1_2	True (*)	Role: Object Push Server (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+		Client Profile Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_OPP_1b_1	False		Client supports OPP version 1.1. (C.1)
+TSPC_OPP_1b_2	True (*)	Client supports OPP version 1.2. (C.1)
+-------------------------------------------------------------------------------
+C.1: It is mandatory to support at least one of the profile versions.
+-------------------------------------------------------------------------------
+
+
+		Client Application Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_OPP_2_1	True		Client: Perform Service Discovery request (M)
+TSPC_OPP_2_2	True		Client: Authentication/PIN exchange supported.
+					(M)
+TSPC_OPP_2_2a	True (*)	Client: Require Authentication/PIN by default.
+					(O)
+TSPC_OPP_2_3	True		Client: Object Push (M)
+TSPC_OPP_2_4	True (*)	Client: vCard 2.1 (C.3)
+TSPC_OPP_2_5	False		Client: vCalender 1.0 (O)
+TSPC_OPP_2_6	False		Client: vMsg as defined in IrMC 1.1 (O)
+TSPC_OPP_2_7	False		Client: vNote as defined in IrMC 1.1 (O)
+TSPC_OPP_2_8	True (*)	Client: Support content formats other than those
+					declared in TSPC_OPP_2_4 through
+					TSPC_OPP_2_7. (O)
+TSPC_OPP_2_8a	False		Client: Support specific set of other content
+					formats. (C.4)
+TSPC_OPP_2_8b	True (*)	Client: Support all content formats. (C.4)
+TSPC_OPP_2_9	True (*)	Client: Push multiple vCard objects. (O)
+TSPC_OPP_2_9a	True (*)	Client: Push multiple vCard objects using
+					different PUT operations. (C.5)
+TSPC_OPP_2_9b	False		Client: Push multiple vCard objects using the
+					same PUT operation. (C.5)
+TSPC_OPP_2_10	True (*)	Client: Push multiple vCalender objects. (O)
+TSPC_OPP_2_10a	True		Client: Push multiple vCalendar objects using
+					different PUT operations. (C.6)
+TSPC_OPP_2_10b	False		Client: Push multiple vCalendar objects using
+					the same PUT operation. (C.6)
+TSPC_OPP_2_11	True (*)	Client: Push multiple vMsg objects. (O)
+TSPC_OPP_2_11a	True (*)	Client: Push multiple vMsg objects using
+					different PUT operations. (C.7)
+TSPC_OPP_2_11b	False		Client: Push multiple vMsg objects using the
+					same PUT operation. (C.7)
+TSPC_OPP_2_12	True (*)	Client: Push multiple vNote objects. (O)
+TSPC_OPP_2_12a	True (*)	Client: Push multiple vNote objects using
+					different PUT operations. (C.8)
+TSPC_OPP_2_12b	False		Client: Push multiple vNote objects using the
+					same PUT operation. (C.8)
+TSPC_OPP_2_13	True (*)	Client: Pull business card (O)
+TSPC_OPP_2_14	True (*)	Client: vCard 2.1 (C.1)
+TSPC_OPP_2_15	True (*)	Client: Exchange business card (O)
+TSPC_OPP_2_16	False		Client: vCard 2.1 (C.2)
+TSPC_OPP_2_17	True (*)	GOEP v2 (C.9)
+TSPC_OPP_2_18	True (*)	GOEP v2 Backward Compability (C.9)
+TSPC_OPP_2_19	True (*)	OBEX over L2CAP (C.9)
+TSPC_OPP_2_20	False		OBEX Reliable Session (C.10)
+TSPC_OPP_2_21	False		OBEX SRM (C.10)
+TSPC_OPP_2_22	False		Send OBEX SRMP header (C.10)
+TSPC_OPP_2_23	False		Receive OBEX SRMP header (C.11)
+-------------------------------------------------------------------------------
+C.1: Mandatory to Support IF (TSPC_OPP_2_13) Business Card Pull is supported.
+C.2: Mandatory to Support IF (TSPC_OPP_2_15) Business Card Exchange is
+	supported.
+C.3: vCard 2.1 support is required for devices containing phonebook
+	applications. vCard 2.1 support optional for other devices.
+C.4: Mandatory to support one of TSPC_OPP_2_8a or TSPC_OPP_2_8b if TSPC_OPP_2_8
+	is supported. Otherwise, both items are excluded.
+C.5: Mandatory to support at least one of TSPC_OPP_2_9a and TSPC_OPP_2_9b if
+	TSPC_OPP_2_9 is supported. Otherwise, both items are excluded.
+C.6: Mandatory to support at least one of TSPC_OPP_2_10a and TSPC_OPP_2_10b if
+	TSPC_OPP_2_10 is supported. Otherwise, both items are excluded.
+C.7: Mandatory to support at least one of TSPC_OPP_2_11a and TSPC_OPP_2_11b if
+	TSPC_OPP_2_11 is supported. Otherwise, both items are excluded.
+C.8: Mandatory to support at least one of TSPC_OPP_2_12a and TSPC_OPP_2_12b if
+	TSPC_OPP_2_12 is supported. Otherwise, both items are excluded.
+C.9: Mandatory if TSPC_OPP_1b_2 supported.
+C.10: Optional to support if TSPC_OPP_1b_2 supported else excluded.
+C.11: Mandatory if TSPC_OPP_17 and TSPC_OPP_21 supported else excluded.
+-------------------------------------------------------------------------------
+
+
+		Server Profile Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_OPP_2b_1	False		Server supports OPP version 1.1.
+TSPC_OPP_2b_2	True (*)	Server supports OPP version 1.2.
+-------------------------------------------------------------------------------
+C.1: It is mandatory to support at least one of the profile versions.
+-------------------------------------------------------------------------------
+
+
+		Server Application Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_OPP_3_1	True		Server: Provide information on supported
+					contents type on service discovery
+					request. (M)
+TSPC_OPP_3_2	True		Server: Authentication/PIN exchange supported.
+					(M)
+TSPC_OPP_3_3	True		Server: Object Push (M)
+TSPC_OPP_3_3a	True (*)	Server: Receive multiple objects in the same
+					PUT operation. (O)
+TSPC_OPP_3_4	True (*)	Server: vCard 2.1 (C.3)
+TSPC_OPP_3_5	False		Server: vCalender 1.0 format (O)
+TSPC_OPP_3_6	False		Server: vMsg as defined in IrMC 1.1 (O)
+TSPC_OPP_3_7	False		Server: vNote as defined in IrMC 1.1 (O)
+TSPC_OPP_3_8	True (*)	Server: Support content formats other than those
+					declared in TSPC_OPP_3_4 through
+					TSPC_OPP_3_7. (O)
+TSPC_OPP_3_8a	False		Server: Support specific set of other content
+					formats. (C.4)
+TSPC_OPP_3_8b	True (*)	Server: Support all content formats. (C.4)
+TSPC_OPP_3_9	True (*)	Server: Object Push vCard reject. (O)
+TSPC_OPP_3_10	True (*)	Server: Object Push vCal reject. (O)
+TSPC_OPP_3_11	True (*)	Server: Object Push vMsg reject. (O)
+TSPC_OPP_3_12	True (*)	Server: Object Push vNote reject. (O)
+TSPC_OPP_3_13	True (*)	Server: Business card pull (O.1)
+TSPC_OPP_3_14	True (*)	Server: vCard 2.1 (C.1)
+TSPC_OPP_3_15	True (*)	Server: Business card pull reject. (O)
+TSPC_OPP_3_16	True (*)	Server: Business card exchange (O.2)
+TSPC_OPP_3_17	True (*)	Server: vCard 2.1 (C.2)
+TSPC_OPP_3_18	True (*)	Server: Business card exchange reject. (O)
+TSPC_OPP_3_19	True (*)	GOEP v2 (C.5)
+TSPC_OPP_3_20	True (*)	GOEP v2 Backward Compability (C.5)
+TSPC_OPP_3_21	True (*)	OBEX over L2CAP (C.5)
+TSPC_OPP_3_22	False		OBEX Reliable Session (C.16)
+TSPC_OPP_3_23	False		OBEX SRM (C.6)
+TSPC_OPP_3_24	False		Send OBEX SRMP header (C.6)
+TSPC_OPP_3_25	False		Receive OBEX SRMP header (C.7)
+-------------------------------------------------------------------------------
+O.1: IF NOT Supported, an error message must be sent on request for Business
+	Card Pull.
+O.2: IF NOT Supported, an error message must be sent on request for Business
+	Card Exchange.
+C.1: Mandatory to Support IF (TSPC_OPP_3_13) Business Card Pull is supported.
+C.2: Mandatory to Support IF (TSPC_OPP_3_16) Business Card Exchange is
+	supported.
+C.3: vCard 2.1 support is required for devices containing phonebook
+	applications. vCard 2.1 support optional for other devices.
+C.4: Mandatory to support one of TSPC_OPP_3_8a or TSPC_OPP_3_8b if TSPC_OPP_3_8
+	is supported. Otherwise, both items are excluded.
+C.5: Mandatory if TSPC_OPP_2b_2 supported.
+C.6: Optional to support if TSPC_OPP_2b_2 supported, else excluded.
+C.7: Mandatory if TSPC_OPP_3_19 and TSPC_OPP_3_23 supported else excluded.
+-------------------------------------------------------------------------------
+
+
+		Additional OPP Capabilities
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_OPP_4_1	False		Abort-Push Operation (O)
+TSPC_OPP_4_2	False		Intentionally Left Blank (N/A)
+TSPC_OPP_4_3	True (*)	Multiple vCards transferred as a single vObject
+					(C.1)
+TSPC_OPP_4_4	True (*)	Multiple vCards transfer (C.1)
+TSPC_OPP_4_5	True (*)	vCards with multiple Phone Number Fields (C.1)
+TSPC_OPP_4_6	True (*)	Push vCal to Different Time Zone Server (C.1)
+-------------------------------------------------------------------------------
+C.1: Optional if TSPC_OPP_1_2 is supported, otherwise excluded.
+-------------------------------------------------------------------------------
diff --git a/doc/pixit-opp.txt b/doc/pixit-opp.txt
new file mode 100644
index 0000000..b7461d6
--- /dev/null
+++ b/doc/pixit-opp.txt
@@ -0,0 +1,27 @@
+OPP PIXIT for the PTS tool.
+
+PTS version: 6.2.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_supported_extension				bmp
+TSPX_unsupported_extension				pts
+TSPX_client_class_of_device				100104
+TSPX_server_class_of_device				100104
+TSPX_auth_password					0000
+TSPX_auth_user_id					PTS
+TSPX_l2cap_psm						1003
+TSPX_rfcomm_channel					8
+TSPX_no_confirmations					FALSE
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_delete_link_key					FALSE
+TSPX_pin_code						0000
+TSPX_security_enabled					FALSE
+TSPX_time_guard						300000
+TSPX_use_implicit_send					TRUE
+-------------------------------------------------------------------------------
diff --git a/doc/pts-opp.txt b/doc/pts-opp.txt
new file mode 100644
index 0000000..ae1bb7c
--- /dev/null
+++ b/doc/pts-opp.txt
@@ -0,0 +1,119 @@
+PTS test results for OPP
+
+PTS version: 6.2.0
+Tested: 30-Jul-2015
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
+TC_CLIENT_BC_BV_02_I	PASS
+TC_CLIENT_BC_BV_04_I	PASS
+TC_CLIENT_BCE_BV_01_I   PASS
+TC_CLIENT_BCE_BV_03_I   N/A
+TC_CLIENT_BCE_BV_04_I   PASS
+TC_CLIENT_BCE_BV_05_I   PASS
+TC_CLIENT_BCE_BV_06_I   PASS
+TC_CLIENT_BCE_BV_07_I   PASS
+TC_CLIENT_BCP_BV_01_I   PASS
+TC_CLIENT_BCP_BV_02_I   PASS
+TC_CLIENT_BCP_BV_03_I   N/A
+TC_CLIENT_BCP_BV_04_I   PASS
+TC_CLIENT_BCP_BV_05_I   PASS
+TC_CLIENT_CON_BV_01_C	PASS
+TC_CLIENT_OPH_BI_01_C	PASS
+TC_CLIENT_OPH_BV_01_I	PASS
+TC_CLIENT_OPH_BV_02_I	N/A
+TC_CLIENT_OPH_BV_03_I	PASS
+TC_CLIENT_OPH_BV_04_I	PASS
+TC_CLIENT_OPH_BV_05_I	PASS
+TC_CLIENT_OPH_BV_07_I	N/A
+TC_CLIENT_OPH_BV_08_I	PASS
+TC_CLIENT_OPH_BV_09_I	N/A
+TC_CLIENT_OPH_BV_10_I	N/A
+TC_CLIENT_OPH_BV_11_I	N/A
+TC_CLIENT_OPH_BV_12_I	PASS
+TC_CLIENT_OPH_BV_13_I	N/A
+TC_CLIENT_OPH_BV_14_I	N/A
+TC_CLIENT_OPH_BV_15_I	N/A
+TC_CLIENT_OPH_BV_16_I	PASS
+TC_CLIENT_OPH_BV_17_I	N/A
+TC_CLIENT_OPH_BV_18_I	N/A
+TC_CLIENT_OPH_BV_19_I	PASS	Send file other than vCard
+TC_CLIENT_OPH_BV_20_I	PASS
+TC_CLIENT_OPH_BV_22_I	PASS	Send file greater than 2 MB
+TC_CLIENT_OPH_BV_23_I	N/A
+TC_CLIENT_OPH_BV_24_I	N/A
+TC_CLIENT_OPH_BV_25_I	N/A
+TC_CLIENT_OPH_BV_26_I	N/A
+TC_CLIENT_SRM_BV_01_C	N/A
+TC_CLIENT_SRM_BV_03_C	N/A
+TC_CLIENT_SRM_BV_05_C	N/A
+TC_CLIENT_SRM_BV_07_C	N/A
+TC_CLIENT_SRMP_BI_01_C	N/A
+TC_CLIENT_SRMP_BV_01_C	N/A
+TC_CLIENT_SRMP_BV_04_C	N/A
+TC_CLIENT_SRMP_BV_05_C	N/A
+TC_CLIENT_SRMP_BV_06_C	N/A
+TC_SERVER_BC_BV_01_I	PASS
+TC_SERVER_BC_BV_03_I	PASS
+TC_SERVER_BCE_BV_01_I	PASS
+TC_SERVER_BCE_BV_03_I	PASS
+TC_SERVER_BCE_BV_04_I	PASS
+TC_SERVER_BCE_BV_05_I	PASS
+TC_SERVER_BCE_BV_06_I	PASS
+TC_SERVER_BCE_BV_07_I	PASS
+TC_SERVER_BCP_BV_01_I	PASS
+TC_SERVER_BCP_BV_02_I	N/A
+TC_SERVER_BCP_BV_03_I	PASS
+TC_SERVER_BCP_BV_04_I	PASS
+TC_SERVER_BCP_BV_05_I	PASS
+TC_SERVER_CON_BV_02_C	PASS
+TC_SERVER_OPH_BV_01_I	PASS
+TC_SERVER_OPH_BV_02_I	PASS
+TC_SERVER_OPH_BV_03_I	PASS
+TC_SERVER_OPH_BV_04_I	PASS
+TC_SERVER_OPH_BV_05_I	PASS
+TC_SERVER_OPH_BV_07_I	N/A
+TC_SERVER_OPH_BV_08_I	N/A
+TC_SERVER_OPH_BV_09_I	PASS
+TC_SERVER_OPH_BV_10_I	PASS
+TC_SERVER_OPH_BV_11_I	N/A
+TC_SERVER_OPH_BV_12_I	N/A
+TC_SERVER_OPH_BV_13_I	PASS
+TC_SERVER_OPH_BV_14_I	PASS
+TC_SERVER_OPH_BV_15_I	N/A
+TC_SERVER_OPH_BV_16_I	N/A
+TC_SERVER_OPH_BV_17_I	PASS
+TC_SERVER_OPH_BV_18_I	PASS
+TC_SERVER_OPH_BV_19_I	INC	PTS issue #13842
+TC_SERVER_OPH_BV_21_I	N/A
+TC_SERVER_OPH_BV_22_I	INC	PTS issue #13842
+TC_SERVER_OPH_BV_23_I	PASS
+TC_SERVER_OPH_BV_24_I	N/A
+TC_SERVER_OPH_BV_25_I	N/A
+TC_SERVER_OPH_BV_26_I	N/A
+TC_SERVER_ROB_BV_01_C	PASS
+TC_SERVER_ROB_BV_02_C	PASS
+TC_SERVER_SRM_BI_02_C	N/A
+TC_SERVER_SRM_BI_03_C	PASS
+TC_SERVER_SRM_BI_05_C	N/A
+TC_SERVER_SRM_BV_04_C	N/A
+TC_SERVER_SRM_BV_08_C	N/A
+TC_SERVER_SRMP_BV_02_C	N/A
+TC_SERVER_SRMP_BV_03_C	N/A
+TC_CLIENT_OPH_BV_27_I	N/A
+TC_CLIENT_OPH_BV_34_I	PASS
+TC_SERVER_OPH_BV_27_I	N/A
+TC_SERVER_OPH_BV_30_I	PASS
+TC_SERVER_OPH_BV_31_I	PASS
+TC_SERVER_OPH_BV_32_I	PASS
+TC_SERVER_OPH_BV_33_I	N/A
+TC_SERVER_OPH_BV_34_I	PASS
+-------------------------------------------------------------------------------
-- 
1.9.1

