Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: Re-test HID against PTS 5.1
Date: Mon,  7 Apr 2014 17:28:43 +0200
Message-Id: <1396884523-29517-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1396884523-29517-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396884523-29517-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hid.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index 22ef800..a7990e1 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -1,7 +1,7 @@
 PTS test results for HID
 
-PTS version: 4.9
-Tested: 14-Nov-2013
+PTS version: 5.1
+Tested: 07-April-2014
 
 Results:
 PASS	test passed
@@ -20,12 +20,12 @@ TC_HOS_HCR_BV_01_I	PASS
 TC_HOS_HCR_BV_02_I	PASS
 TC_HOS_HCR_BV_03_I	N/A
 TC_HOS_HCR_BV_04_I	N/A
-TC_HOS_HDT_BV_01_I	PASS	from shell execute:
+TC_HOS_HDT_BV_01_I	PASS
+TC_HOS_HDT_BV_02_I	PASS	from shell execute:
 				haltest
 				bluetooth enable
 				hidhost connect <PTS bdaddr>
 				hidhost send_data <PTS bdaddr> ff00
-TC_HOS_HDT_BV_02_I	PASS
 TC_HOS_HDT_BV_03_I	N/A
 TC_HOS_HDT_BV_04_I	N/A
 TC_HOS_HID_BV_01_C	N/A
@@ -47,8 +47,8 @@ TC_HOS_DAT_BI_01_C	N/A
 TC_HOS_DAT_BI_02_C	N/A
 TC_DEV_HCE_BV_01_I	N/A
 TC_DEV_HCE_BV_02_I	N/A
-TC_DEV_HCE_BV_03_I	PASS
-TC_DEV_HCE_BV_04_I	PASS
+TC_DEV_HCE_BV_03_I	N/A
+TC_DEV_HCE_BV_04_I	N/A
 TC_DEV_HCE_BV_05_I	N/A
 TC_DEV_HCR_BV_01_I	N/A
 TC_DEV_HCR_BV_02_I	N/A
-- 
1.8.5.3

