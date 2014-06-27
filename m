Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update HDP test results
Date: Fri, 27 Jun 2014 10:59:54 +0300
Message-Id: <1403855994-29262-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Mark ECHO server tests passed.
---
 android/pts-hdp.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/android/pts-hdp.txt b/android/pts-hdp.txt
index 99aa2d6..459e2f1 100644
--- a/android/pts-hdp.txt
+++ b/android/pts-hdp.txt
@@ -105,7 +105,11 @@ TC_SRC_HCT_BV_05_C	N/A
 TC_SRC_HCT_BV_06_C	INC
 TC_SRC_HCT_BV_07_C	INC
 TC_SRC_DE_BV_01_I	INC
-TC_SRC_DE_BV_02_I	INC
+TC_SRC_DE_BV_02_I	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SOURCE 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SRC_DEP_BV_01_I	INC
 TC_SRC_DEP_BV_02_I	N/A
 TC_SNK_CON_BV_01_I	PASS	haltest:
@@ -195,7 +199,11 @@ TC_SNK_HCT_BV_05_C	N/A
 TC_SNK_HCT_BV_06_C	INC
 TC_SNK_HCT_BV_07_C	INC
 TC_SNK_DE_BV_01_I	N/A
-TC_SNK_DE_BV_02_I	INC
+TC_SNK_DE_BV_02_I	PASS	haltest:
+				hl register_application bluez-android Bluez
+				bluez-hdp health-device-profile 1
+				BTHL_MDEP_ROLE_SINK 4100
+				BTHL_CHANNEL_TYPE_RELIABLE pulse-oximeter
 TC_SNK_DEP_BV_03_I	INC
 TC_SNK_DEP_BV_04_I	INC
 -------------------------------------------------------------------------------
-- 
1.8.3.2

