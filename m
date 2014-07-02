Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Android/pts: Update HOGP tests results
Date: Wed,  2 Jul 2014 12:34:58 +0200
Message-Id: <1404297298-28417-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404297298-28417-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404297298-28417-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hogp.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/android/pts-hogp.txt b/android/pts-hogp.txt
index 965ed33..9ab7872 100644
--- a/android/pts-hogp.txt
+++ b/android/pts-hogp.txt
@@ -78,7 +78,17 @@ TC_HGWF_BH_BV_09_I	N/A
 TC_HGWF_BH_BV_10_I	N/A
 TC_HGWF_BH_BV_11_I	N/A
 TC_HGCF_RH_BV_01_I	PASS
-TC_HGCF_RH_BV_02_I	INC
+TC_HGCF_RH_BV_02_I	PASS	haltest: hidhost connect <addr>
+				gattc search_service 1
+				gattc get_characteristic 1 {1812,2,1}
+				gattc get_descriptor 1 {1812,2,1} {2a4d,5}
+				gattc write_descriptor 1 {1812,2,1} {2a4d,5}
+					{2902,0} 2 0x0000 0
+				gattc get_characteristic 1 {1812,5,1}
+				gattc get_descriptor 1 {1812,5,1} {2a4d,4}
+				gattc write_descriptor 1 {1812,5,1}
+					{2a4d,4} {2902,0} 2 0x0000 0
+				hidhost disconnect <addr>
 TC_HGCF_BH_BV_03_I	N/A
 TC_HGCF_BH_BV_04_I	N/A
 TC_HGCF_BH_BV_05_I	N/A
-- 
1.9.3

