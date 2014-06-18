Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pts: PTS tests for HoG
Date: Wed, 18 Jun 2014 10:08:42 +0300
Message-Id: <1403075322-15168-2-git-send-email-sebastianx.chlad@intel.com>
In-Reply-To: <1403075322-15168-1-git-send-email-sebastianx.chlad@intel.com>
References: <1403075322-15168-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-hog.txt | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 android/pts-hog.txt

diff --git a/android/pts-hog.txt b/android/pts-hog.txt
new file mode 100644
index 0000000..9b962b4
--- /dev/null
+++ b/android/pts-hog.txt
@@ -0,0 +1,80 @@
+PTS test results for HoG
+
+PTS version: 5.1
+Tested: 17-June-2014
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
+TC_HGDS_HH_BV_01_I	PASS
+TC_HGDS_HH_BV_02_I	PASS
+TC_HGDS_HH_BV_03_I	PASS
+TC_HGDS_HD_BV_01_I	N/A
+TC_HGDS_HD_BV_02_I	N/A
+TC_HGDR_RH_BV_01_I	PASS
+TC_HGDC_RH_BV_01_I	PASS
+TC_HGDC_RH_BV_02_I	PASS
+TC_HGDC_RH_BV_03_I	PASS
+TC_HGDC_RH_BV_04_I	PASS
+TC_HGDC_RH_BV_05_I	PASS
+TC_HGDC_RH_BV_06_I	PASS
+TC_HGDC_RH_BV_07_I	PASS
+TC_HGDC_HH_BV_08_I	PASS
+TC_HGDC_HH_BV_14_I	PASS
+TC_HGDC_HH_BV_15_I	PASS
+TC_HGDC_HH_BV_16_I	PASS
+TC_HGDC_BH_BV_09_I	N/A
+TC_HGDC_BH_BV_10_I	N/A
+TC_HGDC_BH_BV_11_I	N/A
+TC_HGDC_BH_BV_12_I	N/A
+TC_HGDC_BH_BV_13_I	N/A
+TC_HGRF_RH_BV_01_I	INC
+TC_HGRF_RH_BV_02_I	INC
+TC_HGRF_RH_BV_03_I	INC
+TC_HGRF_RH_BV_04_I	INC
+TC_HGRF_RH_BV_05_I	INC
+TC_HGRF_RH_BV_19_I	INC
+TC_HGRF_RH_BV_06_I	INC
+TC_HGRF_RH_BV_07_I	INC
+TC_HGRF_RH_BV_08_I	INC
+TC_HGRF_RH_BV_09_I	INC
+TC_HGRF_HH_BV_10_I	INC
+TC_HGRF_HH_BV_11_I	INC
+TC_HGRF_HH_BV_12_I	INC
+TC_HGRF_BH_BV_13_I	N/A
+TC_HGRF_BH_BV_14_I	N/A
+TC_HGRF_BH_BV_15_I	N/A
+TC_HGRF_BH_BV_16_I	N/A
+TC_HGRF_BH_BV_17_I	N/A
+TC_HGRF_HH_BV_18_I	INC
+TC_HGWF_RH_BV_01_I	INC
+TC_HGWF_RH_BV_02_I	INC
+TC_HGWF_RH_BV_03_I	INC
+TC_HGWF_RH_BV_04_I	INC
+TC_HGWF_RH_BV_05_I	INC
+TC_HGWF_RH_BV_06_I	INC
+TC_HGWF_RH_BV_07_I	INC
+TC_HGWF_BH_BV_08_I	N/A
+TC_HGWF_BH_BV_09_I	N/A
+TC_HGWF_BH_BV_10_I	N/A
+TC_HGWF_BH_BV_11_I	N/A
+TC_HGCF_RH_BV_01_I	INC
+TC_HGCF_RH_BV_02_I	INC
+TC_HGCF_BH_BV_03_I	N/A
+TC_HGCF_BH_BV_04_I	N/A
+TC_HGCF_BH_BV_05_I	N/A
+TC_HGCF_BH_BV_06_I	N/A
+TC_HGNF_RH_BV_01_I	INC
+TC_HGNF_RH_BI_01_I	INC
+TC_HGNF_RH_BI_01_I	INC
+TC_HGNF_BH_BV_02_I	N/A
+TC_HGNF_BH_BV_03_I	N/A
+TC_HGNF_BH_BI_01_I	N/A
+-------------------------------------------------------------------------------
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

