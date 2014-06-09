Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-run PTS for A2DP
Date: Mon,  9 Jun 2014 11:38:22 +0200
Message-Id: <1402306702-32575-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS session for A2DP which includes new PICS settings with PICS:
'Additional encoder Codec' set to TRUE as there is aptX support
added.
---
 android/pics-a2dp.txt | 2 +-
 android/pts-a2dp.txt  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
index 81debcd..53b3c1c 100644
--- a/android/pics-a2dp.txt
+++ b/android/pics-a2dp.txt
@@ -50,7 +50,7 @@ C.1: At least one of the values shall be supported.
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
 TSPC_A2DP_3_1	True		SRC: SBC encoder Codec (M)
-TSPC_A2DP_3_2	False		SRC: Additional encoder Codec (O)
+TSPC_A2DP_3_2	True (*)	SRC: Additional encoder Codec (O)
 -------------------------------------------------------------------------------
 
 
diff --git a/android/pts-a2dp.txt b/android/pts-a2dp.txt
index 3670dd0..5780db1 100644
--- a/android/pts-a2dp.txt
+++ b/android/pts-a2dp.txt
@@ -1,7 +1,7 @@
 PTS test results for A2DP
 
 PTS version: 5.1
-Tested: 07-April-2014
+Tested: 06-June-2014
 Android version: 4.4.2
 
 Results:
-- 
1.8.5.3

