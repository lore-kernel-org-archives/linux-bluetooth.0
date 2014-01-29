Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH 1/2] android/pts: PTS test results for AVCTP
Date: Wed, 29 Jan 2014 15:27:04 +0200
Message-Id: <1391002025-15997-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-avctp.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
index c057a10..a57ecee 100644
--- a/android/pts-avctp.txt
+++ b/android/pts-avctp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVCTP
 
 PTS version: 5.0
-Tested: --not yet tested--
+Tested: 29.01.2014
 
 Results:
 PASS	test passed
@@ -29,13 +29,13 @@ TC_CT_FRA_BV_04_C	N/A
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_TG_CCM_BV_01_C	INC
-TC_TG_CCM_BV_02_C	INC
-TC_TG_CCM_BV_03_C	INC
-TC_TG_CCM_BV_04_C	INC
-TC_TG_NFR_BV_02_C	INC
-TC_TG_NFR_BV_03_C	INC
-TC_TG_NFR_BI_01_C	INC
-TC_TG_FRA_BV_02_C	INC
+TC_TG_CCM_BV_01_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
+TC_TG_CCM_BV_02_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
+TC_TG_CCM_BV_03_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
+TC_TG_CCM_BV_04_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
+TC_TG_NFR_BV_02_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
+TC_TG_NFR_BV_03_C	PASS	avtest --device hci0 --avctp --send x <bdaddr>
+TC_TG_NFR_BI_01_C	PASS
+TC_TG_FRA_BV_02_C	FAIL
 TC_TG_FRA_BV_03_C	INC
 -------------------------------------------------------------------------------
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

