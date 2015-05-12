Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update DIS test results
Date: Tue, 12 May 2015 08:53:09 +0200
Message-Id: <1431413589-19137-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pics-dis.txt  | 6 +++---
 android/pixit-dis.txt | 2 +-
 android/pts-dis.txt   | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/pics-dis.txt b/android/pics-dis.txt
index ed207c8..83f25ce 100644
--- a/android/pics-dis.txt
+++ b/android/pics-dis.txt
@@ -1,6 +1,6 @@
 DIS PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 
@@ -14,7 +14,7 @@ Parameter Name	Selected	Description
 TSPC_DIS_1_1	True		Service supported over BR/EDR (C.1)
 TSPC_DIS_1_2	True		Service supported over LE (C.1)
 -------------------------------------------------------------------------------
-C.1: Mandatory to support at least one of 1/1 or 1/2.
+C.1: Mandatory to support at least one of TSPC_DIS_1_1 or TSPC_DIS_1_2.
 -------------------------------------------------------------------------------
 
 
@@ -35,7 +35,7 @@ TSPC_DIS_2_9	False (*)	IEEE 11073-20601 Regulatory Certification
 TSPC_DIS_2_10	True		SDP Interoperability (C.1)
 TSPC_DIS_2_11	True		PnP ID (O)
 -------------------------------------------------------------------------------
-C.1: Mandatory if 1/1 (BR/EDR) is supported, otherwise excluded.
+C.1: Mandatory if TSPC_DIS_1_1 (BR/EDR) is supported, otherwise excluded.
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pixit-dis.txt b/android/pixit-dis.txt
index 13fe78f..e53532e 100644
--- a/android/pixit-dis.txt
+++ b/android/pixit-dis.txt
@@ -1,6 +1,6 @@
 DIS PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-dis.txt b/android/pts-dis.txt
index 857a149..c7900fd 100644
--- a/android/pts-dis.txt
+++ b/android/pts-dis.txt
@@ -1,8 +1,8 @@
 PTS test results for DIS
 
-PTS version: 6.0
-Tested: 22-January-2015
-Android version: 5.0
+PTS version: 6.1
+Tested: 11-May-2015
+Android version: 5.1
 
 Results:
 PASS	test passed
-- 
1.9.1

