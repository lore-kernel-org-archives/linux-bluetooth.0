Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 4/5] android/pts: Update SM test results
Date: Mon, 11 May 2015 14:49:47 +0200
Message-Id: <1431348588-3974-4-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1431348588-3974-1-git-send-email-mariusz.skamra@tieto.com>
References: <1431348588-3974-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS 6.1 and Android 5.1
---
 android/pts-sm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index 9b9e120..1fad305 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -3,7 +3,7 @@ PTS test results for SM
 PTS version: 6.1
 Tested: 04-May-2015
 Android version: 5.1
-kernel version: 3.20
+kernel version: 4.1
 
 Results:
 PASS	test passed
@@ -66,11 +66,11 @@ TC_EKS_BV_02_C		PASS	btmgmt advertising on
 TC_EKS_BI_01_C		PASS	btmgmt pair -c 0x03 -t 0x01 <addr>
 TC_EKS_BI_02_C		PASS	btmgmt advertising on
 TC_SIGN_BV_01_C		INC	PTS issue #12305
-TC_SIGN_BV_03_C		INC	haltest:
+TC_SIGN_BV_03_C		PASS	haltest:
 				gattc register_client 1234
 				gattc listen 1 1
 				Note: IUT must be connectable and discoverable
-TC_SIGN_BI_01_C		INC	haltest:
+TC_SIGN_BI_01_C		PASS	haltest:
 				gattc register client 1234
 				gattc listen 1 1
 				Note: IUT must be connectable and discoverable
-- 
1.9.1

