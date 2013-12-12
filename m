Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] android/pts: Add PTS test results for HID
Date: Thu, 12 Dec 2013 14:35:40 +0100
Message-Id: <1386855340-22911-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386855340-22911-1-git-send-email-szymon.janc@tieto.com>
References: <1386855340-22911-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow for better tracking of current state of implementation.
---
 android/Makefile.am |  2 +-
 android/pts-hid.txt | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 android/pts-hid.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 7db0616..1dde8c1 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -110,4 +110,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pixit-did.txt android/pts-did.txt \
 		android/pixit-gap.txt android/pixit-hid.txt \
 		android/pixit-opp.txt android/pixit-pan.txt \
-		android/pixit-pbap.txt android/pts-gap.txt
+		android/pixit-pbap.txt android/pts-gap.txt android/pts-hid.txt
diff --git a/android/pts-hid.txt b/android/pts-hid.txt
new file mode 100644
index 0000000..7e9f986
--- /dev/null
+++ b/android/pts-hid.txt
@@ -0,0 +1,76 @@
+PTS test results for DID
+
+PTS version: 4.9
+Tested: 14.11.2013
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
+TC_HOS_HCE_BV_01_I	PASS
+TC_HOS_HCE_BV_02_I	PASS
+TC_HOS_HCE_BV_03_I	PASS
+TC_HOS_HCE_BV_04_I	PASS
+TC_HOS_HCR_BV_01_I	PASS
+TC_HOS_HCR_BV_02_I	PASS
+TC_HOS_HCR_BV_03_I	N/A
+TC_HOS_HCR_BV_04_I	N/A
+TC_HOS_HDT_BV_01_I	PASS	from shell execute:
+				haltest
+				bluetooth enable
+				hidhost connect <PTS bdaddr>
+				hidhost send_data <PTS bdaddr> ff00
+TC_HOS_HDT_BV_02_I	PASS
+TC_HOS_HDT_BV_03_I	N/A
+TC_HOS_HDT_BV_04_I	N/A
+TC_HOS_HID_BV_01_C	N/A
+TC_HOS_HID_BV_02_C	N/A
+TC_HOS_HID_BV_03_C	N/A
+TC_HOS_HID_BV_04_C	N/A
+TC_HOS_HID_BV_05_C	N/A
+TC_HOS_HID_BV_06_C	N/A
+TC_HOS_HID_BV_08_C	N/A
+TC_HOS_HID_BV_09_C	N/A
+TC_HOS_HID_BV_10_C	N/A
+TC_HOS_DAT_BV_01_C	PASS	from shell execute:
+				haltest
+				bluetooth enable
+				hidhost connect <PTS bdaddr>
+				hidhost send_data <PTS bdaddr> ff00
+TC_HOS_DAT_BV_02_C	N/A
+TC_HOS_DAT_BI_01_C	N/A
+TC_HOS_DAT_BI_02_C	N/A
+TC_DEV_HCE_BV_01_I	N/A
+TC_DEV_HCE_BV_02_I	N/A
+TC_DEV_HCE_BV_03_I	PASS
+TC_DEV_HCE_BV_04_I	PASS
+TC_DEV_HCE_BV_05_I	N/A
+TC_DEV_HCR_BV_01_I	N/A
+TC_DEV_HCR_BV_02_I	N/A
+TC_DEV_HCR_BV_03_I	N/A
+TC_DEV_HCR_BV_04_I	N/A
+TC_DEV_HDT_BV_01_I	N/A
+TC_DEV_HDT_BV_02_I	N/A
+TC_DEV_HDT_BV_03_I	N/A
+TC_DEV_HDT_BV_04_I	N/A
+TC_DEV_HID_BV_01_C	N/A
+TC_DEV_HID_BV_03_C	N/A
+TC_DEV_HID_BV_04_C	N/A
+TC_DEV_HID_BV_05_C	N/A
+TC_DEV_HID_BV_06_C	N/A
+TC_DEV_HID_BV_08_C	N/A
+TC_DEV_HID_BV_09_C	N/A
+TC_DEV_HID_BV_10_C	N/A
+TC_DEV_HID_BI_01_C	N/A
+TC_DEV_HID_BI_02_C	N/A
+TC_DEV_DAT_BV_01_C	N/A
+TC_DEV_SDD_BV_01_C	N/A
+TC_DEV_SDD_BV_02_C	N/A
+TC_DEV_SDD_BV_03_C	N/A
+TC_DEV_SDD_BV_04_I	N/A
+-------------------------------------------------------------------------------
-- 
1.8.3.2

