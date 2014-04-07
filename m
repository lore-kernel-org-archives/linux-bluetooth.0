Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: PTS tests results for AVCTP
Date: Mon,  7 Apr 2014 16:45:56 +0200
Message-Id: <1396881956-26016-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1396881956-26016-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396881956-26016-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Re-test against PTS 5.1 as well as adding test for CT role.
---
 android/pts-avctp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-avctp.txt b/android/pts-avctp.txt
index 64fd5fc..d8e7230 100644
--- a/android/pts-avctp.txt
+++ b/android/pts-avctp.txt
@@ -1,7 +1,7 @@
 PTS test results for AVCTP
 
-PTS version: 5.0
-Tested: 18-Mar-2014
+PTS version: 5.1
+Tested: 07-April-2014
 Android version: 4.4.2
 
 Results:
@@ -20,7 +20,7 @@ TC_CT_CCM_BV_03_C	N/A
 TC_CT_CCM_BV_04_C	N/A
 TC_CT_CCM_BI_01_C	N/A
 TC_CT_NFR_BV_01_C	N/A
-TC_CT_NFR_BV_04_C	N/A
+TC_CT_NFR_BV_04_C	PASS	haltest: rc set_volume 5
 TC_CT_FRA_BV_01_C	N/A
 TC_CT_FRA_BV_04_C	N/A
 -------------------------------------------------------------------------------
-- 
1.8.5.3

