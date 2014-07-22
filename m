Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Initial PTS docs for SPP
Date: Tue, 22 Jul 2014 10:39:29 +0200
Message-Id: <1406018369-4078-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS tests done on Android 4.4.4 and PTS 5.2
---
 android/Makefile.am   |  3 ++-
 android/bite-spp.txt  | 19 ----------------
 android/pics-spp.txt  | 61 ++++++++++++++++++++++++++++++++++++++++-----------
 android/pixit-spp.txt | 19 ++++++++++++++++
 android/pts-spp.txt   | 26 ++++++++++++++++++++++
 5 files changed, 95 insertions(+), 33 deletions(-)
 delete mode 100644 android/bite-spp.txt
 create mode 100644 android/pixit-spp.txt
 create mode 100644 android/pts-spp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 057e92a..5c79c7b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -315,8 +315,9 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-scpp.txt \
 				android/pixit-dis.txt \
 				android/pixit-rfcomm.txt \
+				android/pixit-spp.txt \
 				android/pts-rfcomm.txt \
-				android/bite-spp.txt \
+				android/pts-spp.txt \
 				android/pts-l2cap.txt \
 				android/pts-gap.txt \
 				android/pts-did.txt \
diff --git a/android/bite-spp.txt b/android/bite-spp.txt
deleted file mode 100644
index 1994b05..0000000
--- a/android/bite-spp.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-
-BITE test results for SPP
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
-TP/APP/BV-01-C	PASS
-TP/APP/BV-02-C	PASS
-TP/APP/BV-03-C	PASS
-TP/APP/BV-04-C	PASS
-TP/APP/BV-05-C	PASS
-TP/APP/BV-06-C	PASS
--------------------------------------------------------------------------------
diff --git a/android/pics-spp.txt b/android/pics-spp.txt
index 6057d45..3296738 100644
--- a/android/pics-spp.txt
+++ b/android/pics-spp.txt
@@ -1,5 +1,8 @@
+SPP PICS for the PTS tool.
 
-* - different than BITE defaults
+PTS version: 5.2
+
+* - different than PTS defaults
 # - not yet implemented/supported
 
 M - mandatory
@@ -10,18 +13,19 @@ O - optional
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-K.5.0.1		False		SPP v1.1 (C.1)
-K.5.0.2		True		SPP v1.2 (C.1)
+TSPC_SPP_0_1	False		SPP v1.1 (C.1)
+TSPC_SPP_0_2	True (*)	SPP v1.2 (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support only one Profile version.
 -------------------------------------------------------------------------------
 
+
 		Device Role
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-K.5.1.1		True		Device A (DevA) (C.1)
-K.5.1.2		True		Device B (DevB) (C.1)
+TSPC_SPP_1_1	True (*)	Device A (DevA) (C.1)
+TSPC_SPP_1_2	True (*)	Device B (DevB) (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 -------------------------------------------------------------------------------
@@ -31,7 +35,7 @@ C.1: It is mandatory to support at least one of the defined roles.
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-K.5.2.1		True		Support of Serial Profile Service (C.1)
+TSPC_SPP_2_1	True (*)	Support of Serial Profile Service (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory for devices that support Serial Profile for serial cable
      emulation as a Bluetooth service. Irrelevant of devices that only
@@ -44,21 +48,52 @@ C.1: Mandatory for devices that support Serial Profile for serial cable
 -------------------------------------------------------------------------------
 Item		Selected	Description
 -------------------------------------------------------------------------------
-K.5.3.1		True		Establish link and set up virtual serial
+TSPC_SPP_3_1	True (*)	Establish link and set up virtual serial
 				connection (C.1)
-K.5.3.2		True		Accept link and virtual serial connection
+TSPC_SPP_3_2	True (*)	Accept link and virtual serial connection
 				establishment (C.2)
-K.5.3.3		True		Register Service record for application in
+TSPC_SPP_3_3	True (*)	Register Service record for application in
 				local SDP database (C.2)
-K.5.3.4		True		No release in Sniff mode. Sniff mode enabled
+TSPC_SPP_3_4	True (*)	No release in Sniff mode. Sniff mode enabled
 				in the Link Manager (O)
-K.5.3.5		True		No release in Hold mode. Hold mode enabled
+TSPC_SPP_3_5	True (*)	No release in Hold mode. Hold mode enabled
 				in the Link Manager (O)
-K.5.3.6		True		No release in Park mode. Park mode enabled
+TSPC_SPP_3_6	True (*)	No release in Park mode. Park mode enabled
 				in the Link Manager (O)
-K.5.3.7		True		No release after Master/Slave switch. M/S
+TSPC_SPP_3_7	True (*)	No release after Master/Slave switch. M/S
 				switch enabled in the Link manager (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory for Device A, Irrelevant for Device B.
 C.2: Mandatory for Device B, Irrelevant for Device A.
 -------------------------------------------------------------------------------
+
+
+		Service Port Profile Record Content (SerialPort UUID)
+-------------------------------------------------------------------------------
+Item		Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SPP_4_1	True (*)	SerialPort service class (UUID16: 0x1101) (C.1)
+TSPC_SPP_4_2	True (*)	Protocol0, L2CAP (C.1)
+TSPC_SPP_4_3	True (*)	Protocol1, RFCOMM (C.1)
+TSPC_SPP_4_4	True (*)	Server Channel number (C.1)
+TSPC_SPP_4_5	True (*)	Displayable text name (C.2)
+TSPC_SPP_4_6	True (*)	BluetoothProfileDescriptorList (C.3)
+-------------------------------------------------------------------------------
+C.1: Mandatory for role B, if capability 'Support of Serial Profile Service'
+	(SPP 2/1) supported. Irrelevant for role A.
+C.2: Mandatory to support if 2/1 (Support of Serial Profile Service) AND 0/1
+	(SPP v1.1) are supported, otherwise Optional.
+C.3: Mandatory to support if 2/1 (Support of Serial Profile Service) AND 0/2
+	(SPP v1.2) are supported, otherwise Optional.
+-------------------------------------------------------------------------------
+
+
+		Encryption
+-------------------------------------------------------------------------------
+Item		Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SPP_5_1	True (*)	Initiate encryption (O)
+TSPC_SPP_5_2	True		Accept encryption request (M)
+TSPC_SPP_5_3	True		Point to point encryption (M)
+TSPC_SPP_5_4	True		Stop encryption (M)
+-------------------------------------------------------------------------------
diff --git a/android/pixit-spp.txt b/android/pixit-spp.txt
new file mode 100644
index 0000000..bb9605e
--- /dev/null
+++ b/android/pixit-spp.txt
@@ -0,0 +1,19 @@
+SPP PIXIT for the PTS tool.
+
+PTS version: 5.2
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_security_enabled					TRUE
+TSPX_pin_code						0000
+TSPX_time_guard						300000
+TSPX_delete_link_key					FALSE
+TSPX_stop_immediately_when_fail				TRUE
+TSPX_class_of_device_tester				200408
+-------------------------------------------------------------------------------
diff --git a/android/pts-spp.txt b/android/pts-spp.txt
new file mode 100644
index 0000000..9a877ad
--- /dev/null
+++ b/android/pts-spp.txt
@@ -0,0 +1,26 @@
+PTS test results for SPP
+
+PTS version: 5.2
+Tested: 21-July-2014
+Android version: 4.4.4
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_DevA_APP_BV_01_C	PASS	rctest -n -P <channel> <bdaddr>
+				Note: IUT should sdp query PTS in order to
+				check given channel for COM5
+TC_DevB_APP_BV_02_C	PASS	haltest: socket listen BTSOCK_RFCOMM
+				<srvc_name> <uuid>
+TC_APP_BV_03_C		N/A	Missing in PTS
+				PTS issue #12388
+TC_APP_BV_04_C		N/A	Missing in PTS
+TC_APP_BV_05_C		N/A	Missing in PTS
+TC_APP_BV_06_C		N/A	Missing in PTS
+-------------------------------------------------------------------------------
-- 
1.8.5.3

