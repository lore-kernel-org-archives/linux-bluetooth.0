Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 5/5] android/mcap: Update PTS results
Date: Wed, 25 Jun 2014 17:50:01 +0200
Message-Id: <1403711401-11247-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-mcap.txt | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/android/pts-mcap.txt b/android/pts-mcap.txt
index 9a77839..84aabab 100644
--- a/android/pts-mcap.txt
+++ b/android/pts-mcap.txt
@@ -10,20 +10,24 @@ FAIL	test failed
 INC	test is inconclusive
 N/A	test is disabled due to PICS setup
 
+<PTS addr>	PTS address
+<cpsm>		Control PSM as defined by TSPX_MCAP_l2cap_psm_control
+<dpsm>		Data PSM as defined by TSPX_MCAP_l2cap_psm_data
+
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_MCAP_CE_BV_01_C	INC
-TC_MCAP_CE_BV_02_C	INC
-TC_MCAP_CE_BV_03_C	INC
-TC_MCAP_CE_BV_04_C	INC
+TC_MCAP_CE_BV_01_C	PASS	mcaptest -C <cpsm> -D <dpsm> -dc <PTS addr>
+TC_MCAP_CE_BV_02_C	PASS	mcaptest -C <cpsm> -D <dpsm>
+TC_MCAP_CE_BV_03_C	PASS	mcaptest -C <cpsm> -D <dpsm> -c <PTS addr>
+TC_MCAP_CE_BV_04_C	PASS	mcaptest -C <cpsm> -D <dpsm> -d
 TC_MCAP_CM_ABT_BV_01_C	N/A
-TC_MCAP_CM_ABT_BV_02_C	INC
+TC_MCAP_CM_ABT_BV_02_C	PASS	mcaptest -C <cpsm> -D <dpsm> -d
 TC_MCAP_CM_ABT_BV_03_C	N/A
 TC_MCAP_CM_DEL_BV_01_C	N/A
-TC_MCAP_CM_DEL_BV_02_C	INC
+TC_MCAP_CM_DEL_BV_02_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_CM_DEL_BV_02_C	N/A
-TC_MCAP_CM_DEL_BV_04_C	INC
+TC_MCAP_CM_DEL_BV_04_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_CM_DIS_BV_01_C	INC
 TC_MCAP_CM_DIS_BV_02_C	INC
 TC_MCAP_CM_DIS_BV_03_C	INC
@@ -47,31 +51,31 @@ TC_MCAP_CS_R_BV_01_I	N/A
 TC_MCAP_CS_R_BV_02_I	N/A
 TC_MCAP_CS_R_BV_03_C	N/A
 TC_MCAP_CS_T_BV_04_C	N/A
-TC_MCAP_ERR_BI_01_C	INC
+TC_MCAP_ERR_BI_01_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_ERR_BI_02_C	INC
-TC_MCAP_ERR_BI_03_C	INC
+TC_MCAP_ERR_BI_03_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_ERR_BI_04_C	INC
-TC_MCAP_ERR_BI_05_C	INC
+TC_MCAP_ERR_BI_05_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_ERR_BI_06_C	INC
 TC_MCAP_ERR_BI_07_C	INC
 TC_MCAP_ERR_BI_08_C	INC
-TC_MCAP_ERR_BI_09_C	INC
-TC_MCAP_ERR_BI_10_C	INC
+TC_MCAP_ERR_BI_09_C	PASS	mcaptest -C <cpsm> -D <dpsm>
+TC_MCAP_ERR_BI_10_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_ERR_BI_11_C	INC
 TC_MCAP_ERR_BI_12_C	INC
-TC_MCAP_ERR_BI_13_C	INC
-TC_MCAP_ERR_BI_14_C	INC
+TC_MCAP_ERR_BI_13_C	PASS	mcaptest -C <cpsm> -D <dpsm>
+TC_MCAP_ERR_BI_14_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_ERR_BI_15_C	INC
 TC_MCAP_ERR_BI_16_C	INC
 TC_MCAP_ERR_BI_17_C	INC
 TC_MCAP_ERR_BI_18_C	INC
-TC_MCAP_ERR_BI_19_C	INC
+TC_MCAP_ERR_BI_19_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 TC_MCAP_ERR_BI_20_C	INC
-TC_MCAP_INV_BI_01_C	INC
+TC_MCAP_INV_BI_01_C	PASS	mcaptest -C <cpsm> -D <dpsm> -dc <PTS addr>
 TC_MCAP_INV_BI_02_C	INC
-TC_MCAP_INV_BI_03_C	INC
-TC_MCAP_INV_BI_04_C	INC
-TC_MCAP_INV_BI_05_C	INC
-TC_MCAP_INV_BI_06_C	INC
-TC_MCAP_INV_BI_07_C	INC
+TC_MCAP_INV_BI_03_C	PASS	mcaptest -C <cpsm> -D <dpsm> -dc <PTS addr>
+TC_MCAP_INV_BI_04_C	PASS	mcaptest -C <cpsm> -D <dpsm> -c <PTS addr>
+TC_MCAP_INV_BI_05_C	PASS	mcaptest -C <cpsm> -D <dpsm>
+TC_MCAP_INV_BI_06_C	PASS	mcaptest -C <cpsm> -D <dpsm>
+TC_MCAP_INV_BI_07_C	PASS	mcaptest -C <cpsm> -D <dpsm>
 -------------------------------------------------------------------------------
-- 
2.0.0

