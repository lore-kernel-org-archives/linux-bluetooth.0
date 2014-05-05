Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 1/2] android/pts: Run GATT PTS tests
Date: Mon,  5 May 2014 11:17:32 +0200
Message-Id: <1399281453-24838-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399281453-24838-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 android/pts-gatt.txt

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
new file mode 100644
index 0000000..aeac11d
--- /dev/null
+++ b/android/pts-gatt.txt
@@ -0,0 +1,122 @@
+PTS test results for GAP
+
+PTS version: 5.1
+Tested: 19-April-2014
+Android version: 4.4.2
+
+Results:
+PASS	test passed
+FAIL	test failed
+INC	test is inconclusive
+N/A	test is disabled due to PICS setup
+
+-------------------------------------------------------------------------------
+Test Name		Result	Notes
+-------------------------------------------------------------------------------
+TC_GAC_CL_BV_01_C	PASS	Send exchanged MTU
+TC_GAC_SR_BV_01_C	PASS	IUT should accept incoming GATT con request
+TC_GAD_CL_BV_01_C	PASS	Send discover all primary services command to
+				PTS
+TC_GAD_CL_BV_02_C	PASS	Send discover primary services (UUID=1800)
+				command to PTS
+TC_GAD_CL_BV_03_C	PASS	Send discover all include service to PTS
+TC_GAD_CL_BV_04_C	PASS	Discover all characteristics of service (UUID=
+				180A)
+TC_GAD_CL_BV_05_C	PASS	Send discover characteristics by UUID
+TC_GAD_CL_BV_06_C	PASS	Send discover characteristics descriptor
+TC_GAD_CL_BV_07_C	PASS
+TC_GAD_CL_BV_08_C	PASS
+TC_GAD_SR_BV_01_C	INC
+TC_GAD_SR_BV_02_C	INC
+TC_GAD_SR_BV_03_C	INC
+TC_GAD_SR_BV_04_C	INC
+TC_GAD_SR_BV_05_C	INC
+TC_GAD_SR_BV_06_C	INC
+TC_GAD_SR_BV_07_C	INC
+TC_GAD_SR_BV_08_C	INC
+TC_GAR_CL_BV_01_C	PASS
+TC_GAR_CL_BI_01_C	PASS
+TC_GAR_CL_BI_02_C	PASS
+TC_GAR_CL_BI_03_C	PASS
+TC_GAR_CL_BI_04_C	PASS
+TC_GAR_CL_BI_05_C	PASS
+TC_GAR_CL_BV_03_C	PASS
+TC_GAR_CL_BI_06_C	PASS
+TC_GAR_CL_BI_07_C	PASS
+TC_GAR_CL_BI_09_C	PASS
+TC_GAR_CL_BI_10_C	PASS
+TC_GAR_CL_BI_11_C	PASS
+TC_GAR_CL_BV_04_C	PASS
+TC_GAR_CL_BI_12_C	PASS
+TC_GAR_CL_BI_13_C	PASS
+TC_GAR_CL_BI_14_C	PASS
+TC_GAR_CL_BI_15_C	INC
+TC_GAR_CL_BI_16_C	INC
+TC_GAR_CL_BI_17_C	INC
+TC_GAR_CL_BV_05_C	INC
+TC_GAR_CL_BI_18_C	INC
+TC_GAR_CL_BI_19_C	INC
+TC_GAR_CL_BI_20_C	INC
+TC_GAR_CL_BI_21_C	INC
+TC_GAR_CL_BI_22_C	INC
+TC_GAR_CL_BV_06_C	INC
+TC_GAR_CL_BI_23_C	INC
+TC_GAR_CL_BI_24_C	INC
+TC_GAR_CL_BI_25_C	INC
+TC_GAR_CL_BI_26_C	INC
+TC_GAR_CL_BI_27_C	INC
+TC_GAR_CL_BV_07_C	INC
+TC_GAR_CL_BI_28_C	INC
+TC_GAR_CL_BI_29_C	INC
+TC_GAR_CL_BI_30_C	INC
+TC_GAR_CL_BI_31_C	INC
+TC_GAR_CL_BI_32_C	INC
+TC_GAR_CL_BI_33_C	PASS
+TC_GAR_CL_BI_34_C	INC
+TC_GAR_CL_BI_35_C	PASS
+TC_GAR_SR_BV_01_C	INC
+TC_GAR_SR_BI_01_C	INC
+TC_GAR_SR_BI_02_C	INC
+TC_GAR_SR_BI_03_C	INC
+TC_GAR_SR_BI_04_C	INC
+TC_GAR_SR_BI_05_C	INC
+TC_GAR_SR_BV_03_C	INC
+TC_GAR_SR_BI_06_C	INC
+TC_GAR_SR_BI_07_C	INC
+TC_GAR_SR_BI_08_C	INC
+TC_GAR_SR_BI_09_C	INC
+TC_GAR_SR_BI_10_C	INC
+TC_GAR_SR_BI_11_C	INC
+TC_GAR_SR_BV_04_C	INC
+TC_GAR_SR_BI_12_C	INC
+TC_GAR_SR_BI_13_C	INC
+TC_GAR_SR_BI_14_C	INC
+TC_GAR_SR_BI_15_C	INC
+TC_GAR_SR_BI_16_C	INC
+TC_GAR_SR_BI_17_C	INC
+TC_GAR_SR_BV_05_C	INC
+TC_GAR_SR_BI_18_C	INC
+TC_GAR_SR_BI_19_C	INC
+TC_GAR_SR_BI_20_C	INC
+TC_GAR_SR_BI_21_C	INC
+TC_GAR_SR_BI_22_C	INC
+TC_GAR_SR_BV_06_C	INC
+TC_GAR_SR_BI_23_C	INC
+TC_GAR_SR_BI_24_C	INC
+TC_GAR_SR_BI_25_C	INC
+TC_GAR_SR_BI_26_C	INC
+TC_GAR_SR_BI_27_C	INC
+TC_GAR_SR_BV_07_C	INC
+TC_GAR_SR_BV_08_C	INC
+TC_GAR_SR_BI_28_C	INC
+TC_GAR_SR_BI_29_C	INC
+TC_GAR_SR_BI_30_C	INC
+TC_GAR_SR_BI_31_C	INC
+TC_GAR_SR_BI_32_C	INC
+TC_GAR_SR_BI_33_C	INC
+TC_GAR_SR_BI_34_C	INC
+TC_GAR_SR_BI_35_C	INC
+
+
+
+-------------------------------------------------------------------------------
-- 
1.8.5.3

