Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pics: Add PIXIT setup info to PICS files
Date: Thu, 28 Nov 2013 14:57:32 +0100
Message-Id: <1385647052-26572-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1385647052-26572-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1385647052-26572-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some profiles like DID, requires specific PIXIT setup to pass some tests
cases. Other profiles works well with defaults. Thus appropriate
information at the end of PICS file should be provided.

---
 android/pics-did.txt  | 11 +++++++++++
 android/pics-gap.txt  |  5 +++++
 android/pics-hid.txt  |  5 +++++
 android/pics-opp.txt  |  5 +++++
 android/pics-pan.txt  |  5 +++++
 android/pics-pbap.txt |  5 +++++
 6 files changed, 36 insertions(+)

diff --git a/android/pics-did.txt b/android/pics-did.txt
index 8f92bc1..e8c914a 100644
--- a/android/pics-did.txt
+++ b/android/pics-did.txt
@@ -29,3 +29,14 @@ TSPC_DID_1_5	True		Primary Record (M)
 TSPC_DID_1_6	True		Vendor ID Source (M)
 TSPC_ALL	False		Turns on all the test cases
 -------------------------------------------------------------------------------
+
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name			Value
+-------------------------------------------------------------------------------
+TSPX_ClientExecutableURL	False
+TSPX_ServiceDescription		False
+TSPX_DocumentationURL		False
+-------------------------------------------------------------------------------
+Other should be set according to Tester's test environment.
diff --git a/android/pics-gap.txt b/android/pics-gap.txt
index e8ab2ab..cd274e8 100644
--- a/android/pics-gap.txt
+++ b/android/pics-gap.txt
@@ -707,3 +707,8 @@ TSPC_SM_1_2	False		Slave Role (Responder)
 TSPC_SM_2_4	False		OOB supported (O)
 TSPC_ALL	False		Turns on all
 -------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+No special PIXIT settings required. All should be set according to Tester's
+test environment.
diff --git a/android/pics-hid.txt b/android/pics-hid.txt
index b0b7d52..ba50626 100644
--- a/android/pics-hid.txt
+++ b/android/pics-hid.txt
@@ -283,3 +283,8 @@ TSPC_ALL	False		Enables all test cases when set to true.
 -------------------------------------------------------------------------------
 M.1: Mandatory IF (TSPC_HID_1_2) is supported.
 -------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+No special PIXIT settings required. All should be set according to Tester's
+test environment.
diff --git a/android/pics-opp.txt b/android/pics-opp.txt
index c0f2ad6..11e61ff 100644
--- a/android/pics-opp.txt
+++ b/android/pics-opp.txt
@@ -182,3 +182,8 @@ TSPC_ALL	False		Turn on all test cases.
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_OPP_1_2 is supported, otherwise excluded.
 -------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+No special PIXIT settings required. All should be set according to Tester's
+test environment.
diff --git a/android/pics-pan.txt b/android/pics-pan.txt
index 7576d2d..406b6a9 100644
--- a/android/pics-pan.txt
+++ b/android/pics-pan.txt
@@ -144,3 +144,8 @@ C.1: PAN User devices must support at least One of items (TSPC_PAN_4_2) or
 C.2: Mandatory to support if (TSPC_PAN_4_2) is supported.
 C.3: Mandatory to support if (TSPC_PAN_4_8) is supported.
 -------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+No special PIXIT settings required. All should be set according to Tester's
+test environment.
diff --git a/android/pics-pbap.txt b/android/pics-pbap.txt
index 7b2d7d2..2af5fd8 100644
--- a/android/pics-pbap.txt
+++ b/android/pics-pbap.txt
@@ -439,3 +439,8 @@ TSPC_ALL	False (*)	Turns on all the test cases
 -------------------------------------------------------------------------------
 C.1: Optional if TSPC_PBAP_26_4 (OBEX SRM) is supported, otherwise Excluded.
 -------------------------------------------------------------------------------
+
+
+-------------------------------------------------------------------------------
+No special PIXIT settings required. All should be set according to Tester's
+test environment.
-- 
1.8.4.1

