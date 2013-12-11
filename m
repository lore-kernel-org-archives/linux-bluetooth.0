Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/8] android/pts: Add PTS test results for DID
Date: Wed, 11 Dec 2013 16:27:13 +0100
Message-Id: <1386775638-24941-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am |  2 +-
 android/pts-did.txt | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-did.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 0ffbdb0..b505c33 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -107,4 +107,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-gap.txt android/pics-hid.txt \
 		android/pics-pan.txt android/pics-did.txt \
 		android/pics-opp.txt android/pics-pbap.txt \
-		android/pixit-did.txt
+		android/pixit-did.txt android/pts-did.txt
diff --git a/android/pts-did.txt b/android/pts-did.txt
new file mode 100644
index 0000000..c44f56c
--- /dev/null
+++ b/android/pts-did.txt
@@ -0,0 +1,19 @@
+PTS test results for DID
+
+PTS version: 5.0
+Tested: 11.12.2013
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name	Result	Notes
+-------------------------------------------------------------------------------
+TC_SDI_BV_1_I	PASS	IUT must be discoverable
+TC_SDI_BV_2_I	PASS	IUT must be discoverable
+TC_SDI_BV_3_I	PASS	IUT must be discoverable
+TC_SDI_BV_4_I	PASS	IUT must be discoverable
+-------------------------------------------------------------------------------
-- 
1.8.3.2

