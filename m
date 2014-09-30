Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/12] android/pts: Update PTS settings and results for DIS
Date: Tue, 30 Sep 2014 13:06:26 +0200
Message-Id: <1412075187-5518-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-dis.txt  | 4 ++--
 android/pixit-dis.txt | 2 +-
 android/pts-dis.txt   | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/pics-dis.txt b/android/pics-dis.txt
index 1fd24d8..0a1ab3f 100644
--- a/android/pics-dis.txt
+++ b/android/pics-dis.txt
@@ -29,11 +29,11 @@ TSPC_DIS_2_4	True		Serial Number String Characteristic (O)
 TSPC_DIS_2_5	True		Hardware Revision String Characteristic (O)
 TSPC_DIS_2_6	True		Firmware Revision String Characteristic (O)
 TSPC_DIS_2_7	True		Software Revision String Characteristic (O)
-TSPC_DIS_2_8	False (*)	System ID Characteristic (O)
+TSPC_DIS_2_8	True		System ID Characteristic (O)
 TSPC_DIS_2_9	False (*)	IEEE 11073-20601 Regulatory Certification
 				Data List Characteristic (O)
 TSPC_DIS_2_10	True		SDP Interoperability (C.1)
-TSPC_DIS_2_11	False (*)	PnP ID (O)
+TSPC_DIS_2_11	True		PnP ID (O)
 -------------------------------------------------------------------------------
 C.1: Mandatory if 1/1 (BR/EDR) is supported, otherwise excluded.
 -------------------------------------------------------------------------------
diff --git a/android/pixit-dis.txt b/android/pixit-dis.txt
index 0847d76..c29ec36 100644
--- a/android/pixit-dis.txt
+++ b/android/pixit-dis.txt
@@ -19,7 +19,7 @@ TSPX_delete_link_key					FALSE
 TSPX_pin_code						0000
 TSPX_use_dynamic_pin					FALSE
 TSPX_delete_ltk						FALSE
-TSPX_security_enabled					FALSE
+TSPX_security_enabled					TRUE
 TSPX_iut_setup_att_over_br_edr				FALSE
 TSPX_tester_appearance					0000
 -------------------------------------------------------------------------------
diff --git a/android/pts-dis.txt b/android/pts-dis.txt
index 8f2bae6..8489430 100644
--- a/android/pts-dis.txt
+++ b/android/pts-dis.txt
@@ -21,17 +21,17 @@ TC_DEC_BV_03_C		PASS
 TC_DEC_BV_04_C		PASS
 TC_DEC_BV_05_C		PASS
 TC_DEC_BV_06_C		PASS
-TC_DEC_BV_07_C		N/A
+TC_DEC_BV_07_C		PASS
 TC_DEC_BV_08_C		N/A
-TC_DEC_BV_09_C		N/A
+TC_DEC_BV_09_C		PASS
 TC_CR_BV_01_C		PASS
 TC_CR_BV_02_C		PASS
 TC_CR_BV_03_C		PASS
 TC_CR_BV_04_C		PASS
 TC_CR_BV_05_C		PASS
 TC_CR_BV_06_C		PASS
-TC_CR_BV_07_C		N/A
+TC_CR_BV_07_C		PASS
 TC_CR_BV_08_C		N/A
-TC_CR_BV_09_C		N/A
+TC_CR_BV_09_C		PASS
 TC_SDP_BV_01_C		PASS
 -------------------------------------------------------------------------------
-- 
1.9.1

