Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: PTS test results for HID
Date: Tue, 28 Jan 2014 15:37:42 +0200
Message-Id: <1390916262-8022-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hid.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/pts-hid.txt b/android/pts-hid.txt
index 7e9f986..5208d92 100644
--- a/android/pts-hid.txt
+++ b/android/pts-hid.txt
@@ -1,7 +1,7 @@
 PTS test results for DID
 
-PTS version: 4.9
-Tested: 14.11.2013
+PTS version: 5.0
+Tested: 28.01.2014
 
 Results:
 PASS	test passed
@@ -13,7 +13,8 @@ N/A	test is disabled due to PICS setup
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_HOS_HCE_BV_01_I	PASS
-TC_HOS_HCE_BV_02_I	PASS
+TC_HOS_HCE_BV_02_I	PASS	IUT must be connectable
+					(i.e. btmgmt connectable on)
 TC_HOS_HCE_BV_03_I	PASS
 TC_HOS_HCE_BV_04_I	PASS
 TC_HOS_HCR_BV_01_I	PASS
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

