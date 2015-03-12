Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v4 7/7] android/pts: Add BNEP PTS 6.0 results for android 5.0
Date: Thu, 12 Mar 2015 17:06:42 +0100
Message-Id: <1426176402-21179-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1426176402-21179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1426176402-21179-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test case list and results for BNEP profile against
android 5.0
---
 android/Makefile.am    |  5 ++++-
 android/pics-bnep.txt  | 26 ++++++++++++++++++++++++++
 android/pixit-bnep.txt | 30 ++++++++++++++++++++++++++++++
 android/pts-bnep.txt   | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 android/pics-bnep.txt
 create mode 100644 android/pixit-bnep.txt
 create mode 100644 android/pts-bnep.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 7eb6440..cb32bc3 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -258,6 +258,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-dis.txt \
 				android/pics-avdtp.txt \
 				android/pics-gavdp.txt \
+				android/pics-bnep.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -285,6 +286,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-avdtp.txt \
 				android/pixit-gavdp.txt \
 				android/pixit-sdp.txt \
+				android/pixit-bnep.txt \
 				android/pts-rfcomm.txt \
 				android/pts-spp.txt \
 				android/pts-l2cap.txt \
@@ -311,4 +313,5 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pts-dis.txt \
 				android/pts-avdtp.txt \
 				android/pts-gavdp.txt \
-				android/pts-sdp.txt
+				android/pts-sdp.txt \
+				android/pts-bnep.txt
diff --git a/android/pics-bnep.txt b/android/pics-bnep.txt
new file mode 100644
index 0000000..4aba68e
--- /dev/null
+++ b/android/pics-bnep.txt
@@ -0,0 +1,26 @@
+BNEP PICS for the PTS tool.
+
+PTS version: 6.0
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory if such role selected
+O - optional
+
+		Profile Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_BNEP_1_1	True		BNEP Connection Setup (M)
+TSPC_BNEP_1_2	True		BNEP Data Packet Reception (M)
+TSPC_BNEP_1_3	True		BNEP Data Packet Transmission (M)
+TSPC_BNEP_1_3a	True		BNEP Compressed Packet Transmission (O)
+TSPC_BNEP_1_3b	True		BNEP Compressed Packet Transmission Source Only
+				(O)
+TSPC_BNEP_1_4	True		BNEP Control Message Processing (M)
+TSPC_BNEP_1_5	True		BNEP Extension Header Processing (M)
+TSPC_BNEP_1_6	True		Network Protocol Filter Message Transmission (O)
+TSPC_BNEP_1_7	True		Multicast Address Filter Message Transmission
+				(O)
+-------------------------------------------------------------------------------
diff --git a/android/pixit-bnep.txt b/android/pixit-bnep.txt
new file mode 100644
index 0000000..9a26cd2
--- /dev/null
+++ b/android/pixit-bnep.txt
@@ -0,0 +1,30 @@
+BNEP PIXIT for the PTS tool.
+
+PTS version: 6.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to PTS's bin/audio folder
+
+Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name			Value
+-------------------------------------------------------------------------------
+TSPX_class_of_device		04041C
+TSPX_security_control_data
+TSPX_content_protection_data
+TSPX_bd_addr_iut		112233445566 (*&)
+TSPX_delete_link_key		FALSE
+TSPX_pin_code			1234
+TSPX_security_enabled		FALSE
+TSPX_time_guard			300000
+TSPX_use_implicit_send		TRUE
+TSPX_auth_password		0000
+TSPX_auth_user_id		PTS
+TSPX_l2cap_psm			000F
+TSPX_rfcomm_channel		8
+TSPX_no_confirmations		FALSE
+TSPX_UUID_dest_address		1116
+TSPX_UUID_source_address	1115
+TSPX_MAC_dest_address		000000000000 (*&)
+TSPX_MAC_source_address		000000000000 (*&)
diff --git a/android/pts-bnep.txt b/android/pts-bnep.txt
new file mode 100644
index 0000000..7482372
--- /dev/null
+++ b/android/pts-bnep.txt
@@ -0,0 +1,48 @@
+PTS test results for BNEP
+
+PTS version: 6.0
+Tested: 11-March-2015
+Android version: 5.0
+Kernel version: 3.20
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+--------------------------------------------------------------------------------
+Test Name		Result	Notes
+--------------------------------------------------------------------------------
+TC_CTRL_BV_01_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_02_C		PASS	bneptest -c <PTS addr> -b <bridge> -n <iface>
+TC_CTRL_BV_03_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_04_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_05_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_06_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_07_C		INC	bneptest -c <PTS addr> -b <bridge> -n <iface>
+					-t 3 -d 0 -e 1500
+TC_CTRL_BV_08_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_09_C		INC	PTS issue #13170
+				bneptest -c <PTS addr> -b <bridge> -n <iface>
+					-t 5 -g 00:00:00:00:00:00
+					-j ff:ff:ff:ff:ff:ff
+TC_CTRL_BV_10_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_CTRL_BV_19_C		INC	Jira issue #BA-343
+				bneptest -s -b <bridge> -n <iface>
+TC_RX_TYPE_0_BV_11_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_C_BV_12_C		PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_C_S_BV_13_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_C_S_BV_14_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_TYPE_0_BV_15_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_TYPE_0_BV_16_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_TYPE_0_BV_17_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_TYPE_0_BV_18_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_TX_TYPE_0_BV_20_C	PASS	bneptest -c <PTS addr> -b <bridge> -n <iface>
+					-w 0 -k <src hw addr> -f <dst hw addr>
+TC_TX_C_BV_21_C		PASS	bneptest -c <PTS addr> -b <bridge> -n <iface>
+					-w 2 -k <src hw addr> -f <dst hw addr>
+TC_TX_C_S_BV_22_C	PASS	bneptest -c <PTS addr> -b <bridge> -n <iface>
+					-w 3 -k <src hw addr> -f <dst hw addr>
+TC_TX_C_D_BV_23_C	PASS	bneptest -c <PTS addr> -b <bridge> -n <iface>
+					-w 4 -k <src hw addr> -f <dst hw addr>
-- 
2.1.0

