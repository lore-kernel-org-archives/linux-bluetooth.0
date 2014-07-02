Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Subject: [PATCH 3/3] android/pts: Update HOGP tests result
Date: Wed,  2 Jul 2014 09:58:12 +0200
Message-Id: <1404287892-13170-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1404287892-13170-1-git-send-email-szymon.janc@tieto.com>
References: <1404287892-13170-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>

Test results for write report characteristic update.
---
 android/pts-hogp.txt | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 39b954c..965ed33 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -54,10 +54,22 @@ TC_HGRF_BH_BV_15_I	N/A
 TC_HGRF_BH_BV_16_I	N/A
 TC_HGRF_BH_BV_17_I	N/A
 TC_HGRF_HH_BV_18_I	N/A
-TC_HGWF_RH_BV_01_I	INC
-TC_HGWF_RH_BV_02_I	INC
-TC_HGWF_RH_BV_03_I	INC
-TC_HGWF_RH_BV_04_I	INC
+TC_HGWF_RH_BV_01_I	PASS	haltest: hidhost connect <addr>
+				hidhost set_report <addr> BTHH_INPUT_REPORT
+					AAB3F8A6CD
+				hidhost disconnect <addr>
+TC_HGWF_RH_BV_02_I	PASS	haltest: hidhost connect <addr>
+				hidhost set_report <addr> BTHH_OUTPUT_REPORT
+					EF907856341200
+				hidhost disconnect <addr>
+TC_HGWF_RH_BV_03_I	PASS	haltest: hidhost connect <addr>
+				hidhost set_report <addr> BTHH_OUTPUT_REPORT
+					EF907856341200
+				hidhost disconnect <addr>
+TC_HGWF_RH_BV_04_I	PASS	haltest: hidhost connect <addr>
+				hidhost set_report <addr> BTHH_FEATURE_REPORT
+					EA453F2D87
+				hidhost disconnect <addr>
 TC_HGWF_RH_BV_05_I	N/A
 TC_HGWF_RH_BV_06_I	N/A
 TC_HGWF_RH_BV_07_I	N/A
-- 
1.9.1

