Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Correct PICS for A2DP
Date: Tue, 29 Apr 2014 13:34:00 +0200
Message-Id: <1398771240-6738-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-a2dp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
index 5162e62..81debcd 100644
--- a/android/pics-a2dp.txt
+++ b/android/pics-a2dp.txt
@@ -38,7 +38,7 @@ TSPC_A2DP_2_11	False		SRC: SBC Configurations in 16 KHz sampling (O)
 TSPC_A2DP_2_12	False		SRC: SBC Configurations in 32 KHz sampling (O)
 TSPC_A2DP_2_13	True		SRC: SBC Configurations in 44.1 KHz sampling
 					(C.1)
-TSPC_A2DP_2_14	False		SRC: SBC Configurations in 48 KHz sampling
+TSPC_A2DP_2_14	False (*)	SRC: SBC Configurations in 48 KHz sampling
 					(C.1)
 -------------------------------------------------------------------------------
 C.1: At least one of the values shall be supported.
@@ -80,7 +80,7 @@ TSPC_A2DP_4_14	False (*)	SNK: SBC Configurations in 48 KHz sampling (M)
 -------------------------------------------------------------------------------
 Parameter Name	Selected	Description
 -------------------------------------------------------------------------------
-TSPC_A2DP_5_1	False		SNK: SBC decoder Codec (M)
+TSPC_A2DP_5_1	False (*)	SNK: SBC decoder Codec (M)
 TSPC_A2DP_5_2	False		SNK: Additional decoder Coded (O)
 TSPC_ALL	False		Enable all test cases when set to False.
 -------------------------------------------------------------------------------
-- 
1.8.5.3

