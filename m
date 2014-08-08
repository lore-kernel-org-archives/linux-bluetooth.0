Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/pts: Update A2DP test results
Date: Fri,  8 Aug 2014 22:00:38 +0200
Message-Id: <1407528038-4159-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Updated test result for TC_SRC_REL_BV_01_I
---
 android/pts-a2dp.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index 7b9119c..beb78a3 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -16,8 +16,7 @@ Test Name		Result	Notes
 -------------------------------------------------------------------------------
 TC_SRC_CC_BV_09_I	PASS	Start streaming
 TC_SRC_CC_BV_10_I	N/A
-TC_SRC_REL_BV_01_I	INC	JIRA: BA-2
-				Connect to PTS from IUT. When requested
+TC_SRC_REL_BV_01_I	PASS	Connect to PTS from IUT. When requested
 				disconnect from IUT
 TC_SRC_REL_BV_02_I	PASS
 TC_SRC_SET_BV_01_I	PASS	Connect to PTS (open a2dp)
-- 
1.8.4

