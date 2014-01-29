Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: Add android version to PTS test
Date: Wed, 29 Jan 2014 13:15:39 +0200
Message-Id: <1390994139-14743-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trivial patch helping tracking pts tests results' status
---
 android/pts-a2dp.txt  | 1 +
 android/pts-avrcp.txt | 1 +
 android/pts-did.txt   | 1 +
 android/pts-gap.txt   | 1 +
 android/pts-hid.txt   | 1 +
 android/pts-l2cap.txt | 1 +
 android/pts-opp.txt   | 1 +
 android/pts-pbap.txt  | 1 +
 8 files changed, 8 insertions(+)

diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index 67f9183..22fe166 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -2,6 +2,7 @@ PTS test results for A2DP
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
diff --git a/android/pts-avrcp.txt b/android/pts-avrcp.txt
index 6ad97f7..934197b 100644
--- a/android/pts-avrcp.txt
+++ b/android/pts-avrcp.txt
@@ -2,6 +2,7 @@ PTS test results for AVRCP
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
diff --git a/android/pts-did.txt b/android/pts-did.txt
index d764f09..5c03974 100644
--- a/android/pts-did.txt
+++ b/android/pts-did.txt
@@ -2,6 +2,7 @@ PTS test results for DID
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 1c0feec..b424543 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -2,6 +2,7 @@ PTS test results for GAP
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index 5208d92..9d135e2 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -2,6 +2,7 @@ PTS test results for DID
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
diff --git a/android/pts-l2cap.txt b/android/pts-l2cap.txt
index 3e46309..b0a195f 100644
--- a/android/pts-l2cap.txt
+++ b/android/pts-l2cap.txt
@@ -2,6 +2,7 @@ PTS test results for L2CAP
 
 PTS version: 5.0
 Tested: 29.01.2014
+Android version: 4.4
 
 Results:
 PASS   test passed
diff --git a/android/pts-opp.txt b/android/pts-opp.txt
index 3c4ab47..9222288 100644
--- a/android/pts-opp.txt
+++ b/android/pts-opp.txt
@@ -2,6 +2,7 @@ PTS test results for OPP
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
diff --git a/android/pts-pbap.txt b/android/pts-pbap.txt
index 4312921..c74370a 100644
--- a/android/pts-pbap.txt
+++ b/android/pts-pbap.txt
@@ -2,6 +2,7 @@ PTS test results for PBAP
 
 PTS version: 5.0
 Tested: 28.01.2014
+Android version: 4.4
 
 Results:
 PASS	test passed
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

