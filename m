Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/pts: Update of RFCOMM test results
Date: Wed, 25 Feb 2015 11:19:24 +0100
Message-Id: <1424859564-15834-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

TC_RFC_BV_21_C and TC_RFC_BV_22_C tested with fixed Ets provided
in #13011
---
 android/pts-rfcomm.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/pts-rfcomm.txt b/android/pts-rfcomm.txt
index 653b53a..e9b3f26 100644
--- a/android/pts-rfcomm.txt
+++ b/android/pts-rfcomm.txt
@@ -32,7 +32,9 @@ TC_RFC_BV_14_C		N/A
 TC_RFC_BV_15_C		PASS	rctest -r -P 1
 TC_RFC_BV_17_C		PASS	rctest -d -P 1
 TC_RFC_BV_19_C		PASS
-TC_RFC_BV_21_C		INC	PTS issue #13011
-TC_RFC_BV_22_C		INC	PTS issue #13011
+TC_RFC_BV_21_C		PASS	PTS issue #13011
+				rctest -w -N 10 -P 1
+TC_RFC_BV_22_C		PASS	PTS issue #13011
+				rctest -w -N 10 -P 1
 TC_RFC_BV_25_C		PASS	rctest -r -P 1
 -------------------------------------------------------------------------------
-- 
1.9.1

