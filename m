Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: Re-run GAP test suit
Date: Mon,  5 May 2014 11:17:33 +0200
Message-Id: <1399281453-24838-3-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gap.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-gap.txt b/android/pts-gap.txt
index 8be9a5a..cd5709a 100644
--- a/android/pts-gap.txt
+++ b/android/pts-gap.txt
@@ -1,7 +1,7 @@
 PTS test results for GAP
 
 PTS version: 5.1
-Tested: 11-April-2014
+Tested: 29-April-2014
 Android version: 4.4.2
 
 Results:
@@ -161,8 +161,8 @@ TC_DM_NCON_BV_01_C	N/A
 TC_DM_CON_BV_01_C	N/A
 TC_DM_NBON_BV_01_C	N/A
 TC_DM_BON_BV_01_C	INC
-TC_DM_GIN_BV_01_C	INC
-TC_DM_LIN_BV_01_C	INC
+TC_DM_GIN_BV_01_C	PASS
+TC_DM_LIN_BV_01_C	PASS
 TC_DM_NAD_BV_01_C	PASS	Start discovery from IUT
 TC_DM_NAD_BV_02_C	PASS
 TC_DM_LEP_BV_01_C	N/A
-- 
1.8.5.3

