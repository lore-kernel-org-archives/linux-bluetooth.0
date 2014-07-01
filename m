Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/pts: Update HOGP tests result
Date: Tue,  1 Jul 2014 15:44:20 +0200
Message-Id: <1404222260-3936-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404222260-3936-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404222260-3936-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Test results for write report characteristic update.
---
 android/pts-hogp.txt | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 39b954c..6bb21c7 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -54,10 +54,18 @@ TC_HGRF_BH_BV_15_I	N/A
 TC_HGRF_BH_BV_16_I	N/A
 TC_HGRF_BH_BV_17_I	N/A
 TC_HGRF_HH_BV_18_I	N/A
-TC_HGWF_RH_BV_01_I	INC
-TC_HGWF_RH_BV_02_I	INC
-TC_HGWF_RH_BV_03_I	INC
-TC_HGWF_RH_BV_04_I	INC
+TC_HGWF_RH_BV_01_I	PASS	haltest: hidhost connect <addr>
+				hidhost send_data AB2301
+				hidhost disconnect <addr>
+TC_HGWF_RH_BV_02_I	PASS	haltest: hidhost connect <addr>
+				hidhost send_data CD6745
+				hidhost disconnect <addr>
+TC_HGWF_RH_BV_03_I	PASS	haltest: hidhost connect <addr>
+				hidhost send_data CD6745
+				hidhost disconnect <addr>
+TC_HGWF_RH_BV_04_I	PASS	haltest: hidhost connect <addr>
+				hidhost send_data EF0189
+				hidhost disconnect <addr>
 TC_HGWF_RH_BV_05_I	N/A
 TC_HGWF_RH_BV_06_I	N/A
 TC_HGWF_RH_BV_07_I	N/A
-- 
1.9.3

