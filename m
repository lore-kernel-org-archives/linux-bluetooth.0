Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 4/5] android/pts: PICS and PIXIT setting for AVDTP
Date: Wed,  3 Sep 2014 15:13:46 +0200
Message-Id: <1409750027-20992-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
References: <1409750027-20992-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastian.chlad@tieto.com>

---
 android/pics-avdtp.txt  | 68 ++++++++++++++++++++++++-------------------------
 android/pixit-avdtp.txt |  2 +-
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/android/pics-avdtp.txt b/android/pics-avdtp.txt
index be96321..4909367 100644
--- a/android/pics-avdtp.txt
+++ b/android/pics-avdtp.txt
@@ -14,7 +14,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_AVDTP_0_1	False		AVDTP 1.0 (C.1)
 TSPC_AVDTP_0_2	False		AVDTP 1.2 (C.1)
-TSPC_AVDTP_0_3	False		AVDTP 1.3 (C.1)
+TSPC_AVDTP_0_3	True (*)	AVDTP 1.3 (C.1)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to select only one of the protocol versions.
 -------------------------------------------------------------------------------
@@ -24,10 +24,10 @@ C.1: It is mandatory to select only one of the protocol versions.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_1_1	False		Source (C.1)
-TSPC_AVDTP_1_2	False		Sink (C.1)
-TSPC_AVDTP_1_3	False		Initiator (C.2)
-TSPC_AVDTP_1_4	False		Aceptor (C.2)
+TSPC_AVDTP_1_1	True (*)	Source (C.1)
+TSPC_AVDTP_1_2	True (*)	Sink (C.1)
+TSPC_AVDTP_1_3	True (*)	Initiator (C.2)
+TSPC_AVDTP_1_4	True (*)	Aceptor (C.2)
 -------------------------------------------------------------------------------
 C.1: It is mandatory to support at least one of the defined roles.
 C.2: It is within the scope of profiles using the AVDTP specification to
@@ -51,8 +51,8 @@ TSPC_AVDTP_2_4	True		Signal identifier (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_3_1	False		Establish signaling channel (O)
-TSPC_AVDTP_3_2	False		Disconnect signaling channel (O)
+TSPC_AVDTP_3_1	True (*)	Establish signaling channel (O)
+TSPC_AVDTP_3_2	True (*)	Disconnect signaling channel (O)
 -------------------------------------------------------------------------------
 
 
@@ -60,12 +60,12 @@ TSPC_AVDTP_3_2	False		Disconnect signaling channel (O)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_4_1	False		Stream discover command (O)
-TSPC_AVDTP_4_2	False		Stream get capabilities command (C.2)
-TSPC_AVDTP_4_3	False		Set configuration command (O)
-TSPC_AVDTP_4_4	False		Get configuration command (O)
+TSPC_AVDTP_4_1	True (*)	Stream discover command (O)
+TSPC_AVDTP_4_2	True (*)	Stream get capabilities command (C.2)
+TSPC_AVDTP_4_3	True (*)	Set configuration command (O)
+TSPC_AVDTP_4_4	True (*)	Get configuration command (O)
 TSPC_AVDTP_4_5	False		Reconfigure command (O)
-TSPC_AVDTP_4_6	False		Stream get all capabilities command (C.1)
+TSPC_AVDTP_4_6	True (*)	Stream get all capabilities command (C.1)
 -------------------------------------------------------------------------------
 C.1: It is optional to support if AVDTP 1.3 is supported, otherwise excluded.
 C.2: Mandatory to support if TSPC_AVDTP_4_6 is supported, otherwise Optional.
@@ -76,11 +76,11 @@ C.2: Mandatory to support if TSPC_AVDTP_4_6 is supported, otherwise Optional.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_5_1	False		Open stream command (O)
-TSPC_AVDTP_5_2	False		Start stream command (O)
-TSPC_AVDTP_5_3	False		Close stream command (O)
-TSPC_AVDTP_5_4	False		Suspend command (O)
-TSPC_AVDTP_5_5	False		Abort stream command (O)
+TSPC_AVDTP_5_1	True (*)	Open stream command (O)
+TSPC_AVDTP_5_2	True (*)	Start stream command (O)
+TSPC_AVDTP_5_3	True (*)	Close stream command (O)
+TSPC_AVDTP_5_4	True (*)	Suspend command (O)
+TSPC_AVDTP_5_5	True (*)	Abort stream command (O)
 -------------------------------------------------------------------------------
 
 
@@ -115,8 +115,8 @@ TSPC_AVDTP_8_4	True		Signal identifier (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_9_1	False		Establish signaling channel (O)
-TSPC_AVDTP_9_1	False		Disconnect signaling channel (O)
+TSPC_AVDTP_9_1	True (*)	Establish signaling channel (O)
+TSPC_AVDTP_9_1	True (*)	Disconnect signaling channel (O)
 -------------------------------------------------------------------------------
 
 
@@ -124,12 +124,12 @@ TSPC_AVDTP_9_1	False		Disconnect signaling channel (O)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_10_1	False		Stream discover response (O)
-TSPC_AVDTP_10_2	False		Stream get capabilities response (C.2)
-TSPC_AVDTP_10_3	False		Set configuration response (O)
-TSPC_AVDTP_10_4	False		Get configuration response (O)
-TSPC_AVDTP_10_5	False		Reconfigure response (O)
-TSPC_AVDTP_10_6	False		Stream get all capabilities response (C.1)
+TSPC_AVDTP_10_1	True (*)	Stream discover response (O)
+TSPC_AVDTP_10_2	True (*)	Stream get capabilities response (C.2)
+TSPC_AVDTP_10_3	True (*)	Set configuration response (O)
+TSPC_AVDTP_10_4	True (*)	Get configuration response (O)
+TSPC_AVDTP_10_5 False		Reconfigure response (O)
+TSPC_AVDTP_10_6	True (*)	Stream get all capabilities response (C.1)
 -------------------------------------------------------------------------------
 C.1: It is optional to support if AVDTP 1.3 is supported, otherwise excluded.
 C.2: It is Mandatory to support if TSPC_AVDTP_10_6 is supported, otherwise
@@ -141,12 +141,12 @@ C.2: It is Mandatory to support if TSPC_AVDTP_10_6 is supported, otherwise
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_AVDTP_11_1	False		Open stream response (O)
-TSPC_AVDTP_11_2	False		Start stream response (O)
-TSPC_AVDTP_11_3	False		Close stream response (O)
-TSPC_AVDTP_11_4	False		Suspend response (O)
-TSPC_AVDTP_11_5	False		Abort stream response (O)
-TSPC_AVDTP_11_6	False		General reject message (O)
+TSPC_AVDTP_11_1	True (*)	Open stream response (O)
+TSPC_AVDTP_11_2	True (*)	Start stream response (O)
+TSPC_AVDTP_11_3	True (*)	Close stream response (O)
+TSPC_AVDTP_11_4	True (*)	Suspend response (O)
+TSPC_AVDTP_11_5	True (*)	Abort stream response (O)
+TSPC_AVDTP_11_6	True (*)	General reject message (O)
 -------------------------------------------------------------------------------
 
 
@@ -175,7 +175,7 @@ TSPC_AVDTP_14_2	False		Reporting service support (O)
 TSPC_AVDTP_14_3	False		Recovery service support (O)
 TSPC_AVDTP_14_4	False		Multiplexing service support (O)
 TSPC_AVDTP_14_5	False		Robust header compression service support (O)
-TSPC_AVDTP_14_6	False		Delay Reporting (C.1)
+TSPC_AVDTP_14_6	True (*)	Delay Reporting (C.1)
 -------------------------------------------------------------------------------
 C.1: It is optional to support if AVDTP 1.3 is supported, else excluded.
 -------------------------------------------------------------------------------
@@ -190,7 +190,7 @@ TSPC_AVDTP_15_2	False		Reporting service support (O)
 TSPC_AVDTP_15_3	False		Recovery service support (O)
 TSPC_AVDTP_15_4	False		Multiplexing service support (O)
 TSPC_AVDTP_15_5	False		Robust header compression service support (O)
-TSPC_AVDTP_15_6	False		Delay Reporting (C.1)
+TSPC_AVDTP_15_6	True (*)	Delay Reporting (C.1)
 -------------------------------------------------------------------------------
 C.1: It is optional to support if AVDTP 1.3 is supported, else excluded.
 -------------------------------------------------------------------------------
@@ -202,7 +202,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_AVDTP_16_1	False		Reporting Capability Error (C.1)
 TSPC_AVDTP_16_2	False		Reject Corrupted Messages (C.2)
-TSPC_AVDTP_16_3	False		General Reject Response Includes Signal ID (C.3)
+TSPC_AVDTP_16_3	True (*)	General Reject Response Includes Signal ID (C.3)
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_AVDTP_0_2 or TSPC_AVDTP_0_3 supported, excluded
 	otherwise.
diff --git a/android/pixit-avdtp.txt b/android/pixit-avdtp.txt
index 504a126..922f373 100644
--- a/android/pixit-avdtp.txt
+++ b/android/pixit-avdtp.txt
@@ -20,7 +20,7 @@ TSPX_media_directory
 TSPX_bd_addr_iut		11223344556677 (*&)
 TSPX_delete_link_key		FALSE
 TSPX_pin_code			1234
-TSPX_security_enabled		FALSE
+TSPX_security_enabled		TRUE (*)
 TSPX_time_guard			300000
 TSPX_use_implicit_send		TRUE
 TSPX_auth_password		0000
-- 
1.9.1

