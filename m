Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/pts: Rerun TC_GAW_CL* testes using gatttool
Date: Thu, 22 May 2014 23:26:26 +0200
Message-Id: <1400793986-31558-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 210 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 175 insertions(+), 35 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 86b2555..67912c9 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -171,45 +171,185 @@ TC_GAR_SR_BI_32_C	INC
 TC_GAR_SR_BI_33_C	INC
 TC_GAR_SR_BI_34_C	INC
 TC_GAR_SR_BI_35_C	INC
-TC_GAW_CL_BV_01_C	INC
+TC_GAW_CL_BV_01_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-cmd uuid value
+				disconnect
 TC_GAW_CL_BV_02_C	INC
-TC_GAW_CL_BV_03_C	INC
-TC_GAW_CL_BI_02_C	INC
-TC_GAW_CL_BI_03_C	INC
-TC_GAW_CL_BI_04_C	INC
-TC_GAW_CL_BI_05_C	INC
-TC_GAW_CL_BI_06_C	INC
-TC_GAW_CL_BV_05_C	INC
-TC_GAW_CL_BI_07_C	INC
-TC_GAW_CL_BI_08_C	INC
+TC_GAW_CL_BV_03_C	PASS 	 gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_02_C	PASS	 gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_03_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_04_C	PASS 	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_05_C	PASS	 gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_06_C	PASS	 gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BV_05_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_07_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_08_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
 TC_GAW_CL_BI_09_C	INC
-TC_GAW_CL_BI_11_C	INC
-TC_GAW_CL_BI_12_C	INC
-TC_GAW_CL_BI_13_C	INC
-TC_GAW_CL_BV_06_C	INC
-TC_GAW_CL_BI_14_C	INC
-TC_GAW_CL_BI_15_C	INC
-TC_GAW_CL_BI_17_C	INC
-TC_GAW_CL_BI_18_C	INC
-TC_GAW_CL_BI_19_C	INC
-TC_GAW_CL_BV_08_C	INC
-TC_GAW_CL_BI_20_C	INC
-TC_GAW_CL_BI_21_C	INC
-TC_GAW_CL_BI_22_C	INC
-TC_GAW_CL_BI_23_C	INC
-TC_GAW_CL_BI_24_C	INC
-TC_GAW_CL_BV_09_C	INC
-TC_GAW_CL_BI_25_C	INC
-TC_GAW_CL_BI_26_C	INC
+TC_GAW_CL_BI_11_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_12_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_13_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BV_06_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_14_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_15_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_17_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_18_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_19_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BV_08_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_20_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_21_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_22_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_23_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_24_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BV_09_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_25_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_26_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
 TC_GAW_CL_BI_27_C	INC
-TC_GAW_CL_BI_29_C	INC
-TC_GAW_CL_BI_30_C	INC
-TC_GAW_CL_BI_31_C	INC
+TC_GAW_CL_BI_29_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_30_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_31_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
 TC_GAW_CL_BI_32_C	INC
-TC_GAW_CL_BI_33_C	INC
-TC_GAW_CL_BI_34_C	INC
-TC_GAW_CL_BI_35_C	INC
-TC_GAW_CL_BI_36_C	INC
+TC_GAW_CL_BI_33_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_34_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
+TC_GAW_CL_BI_35_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid value
+				disconnect
+TC_GAW_CL_BI_36_C	PASS	gatttool:
+				./gatttool -I -b pts_addr
+				connect
+				char-write-req uuid long_value
+				disconnect
 TC_GAW_SR_BV_01_C	INC
 TC_GAW_SR_BV_02_C	INC
 TC_GAW_SR_BI_01_C	INC
-- 
1.8.4

