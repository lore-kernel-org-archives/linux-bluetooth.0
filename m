Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 3/4] android/pts: Bump PTS version for PBAP
Date: Thu, 10 Apr 2014 09:59:26 +0200
Message-Id: <1397116767-18192-3-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1397116767-18192-1-git-send-email-sebastian.chlad@tieto.com>
References: <1397116767-18192-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-pbap.txt  | 12 ++++++------
 android/pixit-pbap.txt |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
index e3c6091..f75a972 100644
--- a/android/pics-pbap.txt
+++ b/android/pics-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PICS for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -14,7 +14,7 @@ Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_PBAP_0_1	False		Role: PBAP 1.0 (C.1)
 TSPC_PBAP_0_2	True (*)	Role: PBAP 1.1 (C.1)
-TSPC_PBAP_0_3	False (*)	Role: PBAP 1.2 (C.1)
+TSPC_PBAP_0_3	False		Role: PBAP 1.2 (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support one and only one major profile version.
 -------------------------------------------------------------------------------
@@ -117,7 +117,7 @@ Parameter Name	Selected	Description
 TSPC_PBAP_6_1	False (*)	PCE: Connect (M)
 TSPC_PBAP_6_2	False (*)	PCE: Disconnect (M)
 TSPC_PBAP_6_3	False (*)	PCE: Get (M)
-TSPC_PBAP_6_4	False (*)	PCE: Abort (M)
+TSPC_PBAP_6_4	False		PCE: Abort (O)
 TSPC_PBAP_6_5	False (*)	PCE: SetPath (C.1)
 TSPC_PBAP_6_6	False		PCE: Support for OBEX authentication initiation
 					(C.2)
@@ -354,7 +354,7 @@ TSPC_PBAP_19_2	True		PSE: Initiate LMP-Authentication (M)
 TSPC_PBAP_19_3	False		PSE: Security mode 1 (C.2)
 TSPC_PBAP_19_4	False		PSE: Security mode 2 (C.1)
 TSPC_PBAP_19_5	False		PSE: Security mode 3 (C.1)
-TSPC_PBAP_19_6	False		PSE: Security mode 4 (C.1)
+TSPC_PBAP_19_6	True (*)	PSE: Security mode 4 (C.1)
 -------------------------------------------------------------------------------
 C.1: At least one of TSPC_PBAP_19_3, TSPC_PBAP_19_4, TSPC_PBAP_19_5 or
 	TSPC_PBAP_19_6 (security mode 2, 3, or 4) shall be supported.
@@ -414,7 +414,7 @@ C.3: Optional if TSPC_PBAP_10_2 is supported, otherwise excluded.
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PBAP_25_1	False (*)	PCE: GOEP v2.0 or later (M)
+TSPC_PBAP_25_1	False		PCE: GOEP v2.0 or later (M)
 TSPC_PBAP_25_2	False (*)	PCE: GOEP v2 Backwards Compatibility (M)
 TSPC_PBAP_25_3	False		PCE: OBEX over L2CAP (M)
 TSPC_PBAP_25_4	False		PCE: OBEX SRM (M)
@@ -436,7 +436,7 @@ TSPC_PBAP_26_3	False		PSE: OBEX over L2CAP (M)
 TSPC_PBAP_26_4	False		PSE: OBEX SRM (M)
 TSPC_PBAP_26_5	False (*)	PSE: Send OBEX SRMP header (C.1)
 TSPC_PBAP_26_6	False		PSE: Receive OBEX SRMP header (M)
-TSPC_ALL	False (*)	Turns on all the test cases
+TSPC_ALL	False		Turns on all the test cases
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_PBAP_26_4 (OBEX SRM) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
index 470f4c5..fc89e15 100644
--- a/android/pixit-pbap.txt
+++ b/android/pixit-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PIXIT for the PTS tool.
 
-PTS version: 5.0
+PTS version: 5.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
-- 
1.8.5.3

