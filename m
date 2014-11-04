Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-test HDP profile on PTS 5.3
Date: Tue,  4 Nov 2014 12:41:17 +0100
Message-Id: <1415101277-20038-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS issue 12340 which incorrectly enabled TC_SRC_DE_BV_01_I
is solved in PTS 5.3.
---
 android/pts-hdp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index ee8b5c8..0a3ff08 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -1,7 +1,7 @@
 PTS test results for HDP
 
 PTS version: 5.3
-Tested: 30-September-2014
+Tested: 04-November-2014
 Android version: 4.4.4
 
 Results:
@@ -140,7 +140,7 @@ TC_SRC_HCT_BV_07_C	PASS	haltest:
 				bluez-hdp health-device-profile 1
 				BTHL_MDEP_ROLE_SOURCE 4100
 				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
-TC_SRC_DE_BV_01_I	INC	PTS issue #12340
+TC_SRC_DE_BV_01_I	N/A
 TC_SRC_DE_BV_02_I	PASS	haltest:
 				hl register_application bluez-android Bluez
 				bluez-hdp health-device-profile 1
-- 
1.8.5.3

