Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Re-run all GATT PTS tests
Date: Tue, 20 May 2014 11:34:02 +0200
Message-Id: <1400578442-22047-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pts-gatt.txt | 294 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 229 insertions(+), 65 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 342db47..a98f400 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -1,7 +1,7 @@
-PTS test results for GAP
+PTS test results for GATT
 
 PTS version: 5.1
-Tested: 7-May-2014
+Tested: 19-May-2014
 Android version: 4.4.2
 
 Results:
@@ -13,76 +13,131 @@ N/A	test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_GAC_CL_BV_01_C	PASS	Send exchanged MTU
-TC_GAC_SR_BV_01_C	PASS	IUT should accept incoming GATT con request
-TC_GAD_CL_BV_01_C	PASS	Send discover all primary services command to
-				PTS
-TC_GAD_CL_BV_02_C	PASS	Send discover primary services (UUID=1800)
-				command to PTS
-TC_GAD_CL_BV_03_C	PASS	Send discover all include service to PTS
-TC_GAD_CL_BV_04_C	PASS	Discover all characteristics of service (UUID=
-				180A)
-TC_GAD_CL_BV_05_C	PASS	Send discover characteristics by UUID
-TC_GAD_CL_BV_06_C	PASS	Send discover characteristics descriptor
+TC_GAC_CL_BV_01_C	PASS	haltest:
+				gattc scan
+				gattc search_service
+				gattc get_characteristic
+				gattc write_characteristic: type 3
+TC_GAC_SR_BV_01_C	INC	JIRA: BZ-22
+TC_GAD_CL_BV_01_C	PASS	haltest:
+				gattc register_client
+				gattc scan
+				gattc connect
+				gattc search_service
+				gattc disconnect
+				gattc connect
+				gattc refresh - NOTE: refresh should be called
+				otherwise services are being read from the cache
+TC_GAD_CL_BV_02_C	PASS	haltest:
+				gattc register_client
+				gattc scan
+				gattc connect
+				gattc search_service with given uuid
+				gattc disconnect
+				gattc connect
+				gattc refresh
+TC_GAD_CL_BV_03_C	PASS	haltest:
+				when requested: gattc get_characteristic
+TC_GAD_CL_BV_04_C	PASS	haltest:
+				when requested: gattc get_characteristic
+TC_GAD_CL_BV_05_C	PASS	haltest:
+				when requested: gattc get_characteristic
+				handle: check from btmon logs
+TC_GAD_CL_BV_06_C	PASS	haltest:
+				when requested: gattc get_descriptor
 TC_GAD_CL_BV_07_C	PASS
 TC_GAD_CL_BV_08_C	PASS
-TC_GAD_SR_BV_01_C	INC
-TC_GAD_SR_BV_02_C	INC
-TC_GAD_SR_BV_03_C	INC
-TC_GAD_SR_BV_04_C	INC
-TC_GAD_SR_BV_05_C	INC
-TC_GAD_SR_BV_06_C	INC
-TC_GAD_SR_BV_07_C	INC
-TC_GAD_SR_BV_08_C	INC
-TC_GAR_CL_BV_01_C	PASS
-TC_GAR_CL_BI_01_C	PASS
-TC_GAR_CL_BI_02_C	PASS
-TC_GAR_CL_BI_03_C	PASS
-TC_GAR_CL_BI_04_C	PASS
-TC_GAR_CL_BI_05_C	PASS
-TC_GAR_CL_BV_03_C	PASS
-TC_GAR_CL_BI_06_C	PASS
-TC_GAR_CL_BI_07_C	PASS
-TC_GAR_CL_BI_09_C	PASS
-TC_GAR_CL_BI_10_C	PASS
-TC_GAR_CL_BI_11_C	PASS
-TC_GAR_CL_BV_04_C	PASS
-TC_GAR_CL_BI_12_C	PASS
-TC_GAR_CL_BI_13_C	PASS
-TC_GAR_CL_BI_14_C	PASS
-TC_GAR_CL_BI_15_C	INC
-TC_GAR_CL_BI_16_C	INC
-TC_GAR_CL_BI_17_C	INC
-TC_GAR_CL_BV_05_C	INC
-TC_GAR_CL_BI_18_C	INC
-TC_GAR_CL_BI_19_C	INC
-TC_GAR_CL_BI_20_C	INC
-TC_GAR_CL_BI_21_C	INC
-TC_GAR_CL_BI_22_C	INC
-TC_GAR_CL_BV_06_C	INC
-TC_GAR_CL_BI_23_C	INC
-TC_GAR_CL_BI_24_C	INC
-TC_GAR_CL_BI_25_C	INC
-TC_GAR_CL_BI_26_C	INC
-TC_GAR_CL_BI_27_C	INC
-TC_GAR_CL_BV_07_C	INC
-TC_GAR_CL_BI_28_C	INC
-TC_GAR_CL_BI_29_C	INC
-TC_GAR_CL_BI_30_C	INC
-TC_GAR_CL_BI_31_C	INC
-TC_GAR_CL_BI_32_C	INC
-TC_GAR_CL_BI_33_C	PASS
-TC_GAR_CL_BI_34_C	INC
-TC_GAR_CL_BI_35_C	PASS
-TC_GAR_SR_BV_01_C	INC
-TC_GAR_SR_BI_01_C	INC
+				For the server tests:
+				haltest:
+				gattc register_client
+				gattc listen
+				gatts register_server
+				gatts add_service
+				gatts add_characteristic
+				gatts start_service
+				gatts add_service
+				gatts add_included_service
+				gatts start_service
+TC_GAD_SR_BV_01_C	PASS
+TC_GAD_SR_BV_02_C	PASS
+TC_GAD_SR_BV_03_C	PASS
+TC_GAD_SR_BV_04_C	PASS
+TC_GAD_SR_BV_05_C	PASS
+TC_GAD_SR_BV_06_C	PASS
+TC_GAD_SR_BV_07_C	N/A
+TC_GAD_SR_BV_08_C	N/A
+TC_GAR_CL_BV_01_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_01_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_02_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_03_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_04_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_05_C	INC	not implemented (encryption)
+TC_GAR_CL_BV_03_C	INC	JIRA: BZ-31
+TC_GAR_CL_BI_06_C	INC	JIRA: BZ-31
+TC_GAR_CL_BI_07_C	INC	JIRA: BZ-31
+TC_GAR_CL_BI_09_C	INC	JIRA: BZ-31
+TC_GAR_CL_BI_10_C	INC	JIRA: BZ-31
+TC_GAR_CL_BI_11_C	INC	not implemented (encryption)
+TC_GAR_CL_BV_04_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_12_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_13_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_14_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_15_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_16_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_CL_BI_17_C	INC	not implemented (encryption)
+TC_GAR_CL_BV_05_C	INC	JIRA: BZ-32
+TC_GAR_CL_BI_18_C	INC	JIRA: BZ-32
+TC_GAR_CL_BI_19_C	INC	JIRA: BZ-32
+TC_GAR_CL_BI_20_C	INC	JIRA: BZ-32
+TC_GAR_CL_BI_21_C	INC	JIRA: BZ-32
+TC_GAR_CL_BI_22_C	INC	JIRA: BZ-32
+TC_GAR_CL_BV_06_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_23_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_24_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_25_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_26_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_27_C	INC	not implemented (encryption)
+TC_GAR_CL_BV_07_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_28_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_29_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_30_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_31_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_32_C	PASS	haltest:
+				gattc read_descriptor
+TC_GAR_CL_BI_33_C	INC	not implemented (encryption)
+TC_GAR_CL_BI_34_C	INC	PTS issue - to be confirmed
+TC_GAR_CL_BI_35_C	PASS	haltest:
+				gattc read_characteristic
+TC_GAR_SR_BV_01_C	PASS
+TC_GAR_SR_BI_01_C	PASS
 TC_GAR_SR_BI_02_C	INC
 TC_GAR_SR_BI_03_C	INC
 TC_GAR_SR_BI_04_C	INC
 TC_GAR_SR_BI_05_C	INC
-TC_GAR_SR_BV_03_C	INC
+TC_GAR_SR_BV_03_C	PASS
 TC_GAR_SR_BI_06_C	INC
-TC_GAR_SR_BI_07_C	INC
+TC_GAR_SR_BI_07_C	PASS
 TC_GAR_SR_BI_08_C	INC
 TC_GAR_SR_BI_09_C	INC
 TC_GAR_SR_BI_10_C	INC
@@ -116,4 +171,113 @@ TC_GAR_SR_BI_32_C	INC
 TC_GAR_SR_BI_33_C	INC
 TC_GAR_SR_BI_34_C	INC
 TC_GAR_SR_BI_35_C	INC
+TC_GAW_CL_BV_01_C	INC
+TC_GAW_CL_BV_02_C	INC
+TC_GAW_CL_BV_03_C	INC
+TC_GAW_CL_BI_02_C	INC
+TC_GAW_CL_BI_03_C	INC
+TC_GAW_CL_BI_04_C	INC
+TC_GAW_CL_BI_05_C	INC
+TC_GAW_CL_BI_06_C	INC
+TC_GAW_CL_BV_05_C	INC
+TC_GAW_CL_BI_07_C	INC
+TC_GAW_CL_BI_08_C	INC
+TC_GAW_CL_BI_09_C	INC
+TC_GAW_CL_BI_11_C	INC
+TC_GAW_CL_BI_12_C	INC
+TC_GAW_CL_BI_13_C	INC
+TC_GAW_CL_BV_06_C	INC
+TC_GAW_CL_BI_14_C	INC
+TC_GAW_CL_BI_15_C	INC
+TC_GAW_CL_BI_17_C	INC
+TC_GAW_CL_BI_18_C	INC
+TC_GAW_CL_BI_19_C	INC
+TC_GAW_CL_BV_08_C	INC
+TC_GAW_CL_BI_20_C	INC
+TC_GAW_CL_BI_21_C	INC
+TC_GAW_CL_BI_22_C	INC
+TC_GAW_CL_BI_23_C	INC
+TC_GAW_CL_BI_24_C	INC
+TC_GAW_CL_BV_09_C	INC
+TC_GAW_CL_BI_25_C	INC
+TC_GAW_CL_BI_26_C	INC
+TC_GAW_CL_BI_27_C	INC
+TC_GAW_CL_BI_29_C	INC
+TC_GAW_CL_BI_30_C	INC
+TC_GAW_CL_BI_31_C	INC
+TC_GAW_CL_BI_32_C	INC
+TC_GAW_CL_BI_33_C	INC
+TC_GAW_CL_BI_34_C	INC
+TC_GAW_CL_BI_35_C	INC
+TC_GAW_CL_BI_36_C	INC
+TC_GAW_SR_BV_01_C	INC
+TC_GAW_SR_BV_02_C	INC
+TC_GAW_SR_BI_01_C	INC
+TC_GAW_SR_BV_03_C	INC
+TC_GAW_SR_BI_02_C	INC
+TC_GAW_SR_BI_03_C	INC
+TC_GAW_SR_BI_04_C	INC
+TC_GAW_SR_BI_05_C	INC
+TC_GAW_SR_BI_06_C	INC
+TC_GAW_SR_BV_05_C	INC
+TC_GAW_SR_BI_07_C	INC
+TC_GAW_SR_BI_08_C	INC
+TC_GAW_SR_BI_09_C	INC
+TC_GAW_SR_BI_11_C	INC
+TC_GAW_SR_BI_12_C	INC
+TC_GAW_SR_BI_13_C	INC
+TC_GAW_SR_BV_06_C	INC
+TC_GAW_SR_BV_10_C	INC
+TC_GAW_SR_BI_14_C	INC
+TC_GAW_SR_BI_15_C	INC
+TC_GAW_SR_BI_17_C	INC
+TC_GAW_SR_BI_18_C	INC
+TC_GAW_SR_BI_19_C	INC
+TC_GAW_SR_BV_07_C	INC
+TC_GAW_CL_BV_08_C	INC
+TC_GAW_SR_BI_20_C	INC
+TC_GAW_SR_BI_21_C	INC
+TC_GAW_SR_BI_22_C	INC
+TC_GAW_SR_BI_23_C	INC
+TC_GAW_SR_BI_24_C	INC
+TC_GAW_SR_BV_09_C	INC
+TC_GAW_SR_BI_25_C	INC
+TC_GAW_SR_BI_26_C	INC
+TC_GAW_SR_BI_27_C	INC
+TC_GAW_SR_BI_29_C	INC
+TC_GAW_SR_BI_30_C	INC
+TC_GAW_SR_BI_31_C	INC
+TC_GAW_SR_BI_32_C	INC
+TC_GAW_SR_BI_33_C	INC
+TC_GAW_SR_BI_34_C	INC
+TC_GAW_SR_BI_35_C	INC
+TC_GAN_CL_BV_01_C	INC
+TC_GAN_SR_BV_01_C	INC
+TC_GAI_CL_BV_01_C	INC
+TC_GAI_SR_BV_01_C	INC
+TC_GAS_CL_BV_01_C	INC
+TC_GAS_SR_BV_01_C	INC
+TC_GAT_CL_BV_01_C	INC
+TC_GAT_CL_BV_02_C	INC
+TC_GAT_SR_BV_01_C	INC
+TC_GPA_CL_BV_01_C	INC
+TC_GPA_CL_BV_02_C	INC
+TC_GPA_CL_BV_03_C	INC
+TC_GPA_CL_BV_04_C	INC
+TC_GPA_CL_BV_05_C	INC
+TC_GPA_CL_BV_06_C	INC
+TC_GPA_CL_BV_07_C	INC
+TC_GPA_CL_BV_08_C	INC
+TC_GPA_CL_BV_11_C	INC
+TC_GPA_CL_BV_12_C	INC
+TC_GPA_SR_BV_01_C	INC
+TC_GPA_SR_BV_02_C	INC
+TC_GPA_SR_BV_03_C	INC
+TC_GPA_SR_BV_04_C	INC
+TC_GPA_SR_BV_05_C	INC
+TC_GPA_SR_BV_06_C	INC
+TC_GPA_SR_BV_07_C	INC
+TC_GPA_SR_BV_08_C	INC
+TC_GPA_SR_BV_11_C	INC
+TC_GPA_SR_BV_12_C	INC
 -------------------------------------------------------------------------------
-- 
1.8.5.3

