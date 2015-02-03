Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Updated PBAP PICS and PIXITs for PTS 6.0
Date: Tue,  3 Feb 2015 12:21:24 +0100
Message-Id: <1422962484-30702-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Tested against Android 5.0
---
 android/pics-pbap.txt  | 55 ++++++++++++++++++++++++++++++++++++++++----------
 android/pixit-pbap.txt |  2 +-
 android/pts-pbap.txt   |  4 ++--
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
index cb4126c..afd100b 100644
--- a/android/pics-pbap.txt
+++ b/android/pics-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -8,26 +8,37 @@ PTS version: 5.3
 M - mandatory
 O - optional
 
-		Major Profile Version (X.Y)
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_PBAP_1_1	False		Role: PCE (C.1)
+TSPC_PBAP_1_2	True (*)	Role: PSE (C.1)
+-------------------------------------------------------------------------------
+C1: It is mandatory to support at least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+		Client Major Profile Version (X.Y)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PBAP_0_1	False		Role: PBAP 1.0 (C.1)
-TSPC_PBAP_0_2	True (*)	Role: PBAP 1.1 (C.1)
-TSPC_PBAP_0_3	False		Role: PBAP 1.2 (C.1)
+TSPC_PBAP_2a_1	False		PBAP 1.0 (C.1)
+TSPC_PBAP_2a_2	False		PBAP 1.1 (C.1)
+TSPC_PBAP_2a_3	False		PBAP 1.2 (C.1)
 -------------------------------------------------------------------------------
 C.1: Mandatory to support one and only one major profile version.
 -------------------------------------------------------------------------------
 
 
-		Roles
+		Client Minor Profile Version (X.Y)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PBAP_1_1	False		Role: PCE (C.1)
-TSPC_PBAP_1_2	True (*)	Role: PSE (C.1)
+TSPC_PBAP_2b_1	False		PBAP 1.1.1 (C.1)
 -------------------------------------------------------------------------------
-C1: It is mandatory to support at least one of the defined roles.
+C.1: Optional if 2a/2 (PBAP 1.1) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
 
 
@@ -169,7 +180,29 @@ TSPC_PBAP_8_8	False (*)	PCE: Forbidden (M)
 -------------------------------------------------------------------------------
 
 
-		Supported features ( PSE )
+		Server Major Profile Version (X.Y)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_PBAP_9a_1	False		PBAP 1.0 (C.1)
+TSPC_PBAP_9a_2	True (*)	PBAP 1.1 (C.1)
+TSPC_PBAP_9a_3	False		PBAP 1.2 (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support one and only one major profile version.
+-------------------------------------------------------------------------------
+
+
+		Server Minor Profile Version (X.Y.Z)
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_PBAP_9b_1	False		PBAP 1.1.1 (C.1)
+-------------------------------------------------------------------------------
+C.1: Optional if 9a/2 (PBAP 1.1) is supported, otherwise Excluded.
+-------------------------------------------------------------------------------
+
+
+		Supported features (PSE)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
@@ -430,7 +463,7 @@ C.1: Optional to support if TSPC_PBAP_25_4 (OBEX SRM) is supported,
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_PBAP_26_1	False (*)	PSE: GOEP v2.0 or later (M)
+TSPC_PBAP_26_1	False		PSE: GOEP v2.0 or later (M)
 TSPC_PBAP_26_2	False (*)	PSE: GOEP v2 Backwards Compatibility (M)
 TSPC_PBAP_26_3	False		PSE: OBEX over L2CAP (M)
 TSPC_PBAP_26_4	False		PSE: OBEX SRM (M)
diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
index f7a93c6..034456a 100644
--- a/android/pixit-pbap.txt
+++ b/android/pixit-pbap.txt
@@ -1,6 +1,6 @@
 PBAP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index 8194bd7..8931690 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -1,7 +1,7 @@
 PTS test results for PBAP
 
-PTS version: 5.3
-Tested: 17-November-2014
+PTS version: 6.0
+Tested: 30-January-2015
 Android version: 5.0
 
 Results:
-- 
1.9.3

