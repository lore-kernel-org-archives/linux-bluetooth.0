Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android/pts: Update SM PTS test results
Date: Tue, 27 May 2014 17:17:46 +0200
Message-Id: <1401203866-8851-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401203866-8851-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401203866-8851-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rerun TC_JW_* test cases
---
 android/pts-sm.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/android/pts-sm.txt b/android/pts-sm.txt
index 0792de8..8f750bb 100644
--- a/android/pts-sm.txt
+++ b/android/pts-sm.txt
@@ -18,11 +18,12 @@ TC_PROT_BV_01_C		PASS
 TC_PROT_BV_02_C		FAIL	JIRA: BZ-24
 				btmgmt advertising on
 TC_JW_BV_01_C		FAIL	JIRA: BZ-25
-TC_JW_BV_02_C		INC	JIRA: BZ-26
+TC_JW_BV_02_C		PASS
 TC_JW_BV_05_C		INC
 TC_JW_BI_01_C		PASS
-TC_JW_BI_02_C		INC
-TC_JW_BI_03_C		INC
+TC_JW_BI_02_C		PASS
+TC_JW_BI_03_C		PASS	btmgmt:
+				btmgmt set-io-cap 3
 TC_JW_BI_04_C		FAIL
 TC_PKE_BV_01_C		FAIL
 TC_PKE_BV_02_C		INC
-- 
1.8.4

