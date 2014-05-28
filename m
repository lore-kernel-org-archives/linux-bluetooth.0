Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH 2/2] android/pts: Disable some PTS tests
Date: Wed, 28 May 2014 14:25:26 +0200
Message-Id: <1401279926-19312-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1401279926-19312-1-git-send-email-sebastian.chlad@tieto.com>
References: <1401279926-19312-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Both PICS 3/11 and 4/11 (Read Multiple Characteristic) are
disabled which disable some of the tests from GAR section for
server and client.
---
 android/pts-gatt.txt | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/pts-gatt.txt b/android/pts-gatt.txt
index 60968e2..61cdf76 100644
--- a/android/pts-gatt.txt
+++ b/android/pts-gatt.txt
@@ -97,12 +97,12 @@ TC_GAR_CL_BI_15_C	PASS	haltest:
 TC_GAR_CL_BI_16_C	PASS	haltest:
 				gattc read_characteristic
 TC_GAR_CL_BI_17_C	INC	not implemented (encryption)
-TC_GAR_CL_BV_05_C	INC	JIRA: BZ-32
-TC_GAR_CL_BI_18_C	INC	JIRA: BZ-32
-TC_GAR_CL_BI_19_C	INC	JIRA: BZ-32
-TC_GAR_CL_BI_20_C	INC	JIRA: BZ-32
-TC_GAR_CL_BI_21_C	INC	JIRA: BZ-32
-TC_GAR_CL_BI_22_C	INC	JIRA: BZ-32
+TC_GAR_CL_BV_05_C	N/A
+TC_GAR_CL_BI_18_C	N/A
+TC_GAR_CL_BI_19_C	N/A
+TC_GAR_CL_BI_20_C	N/A
+TC_GAR_CL_BI_21_C	N/A
+TC_GAR_CL_BI_22_C	N/A
 TC_GAR_CL_BV_06_C	PASS	haltest:
 				gattc read_descriptor
 TC_GAR_CL_BI_23_C	PASS	haltest:
@@ -224,12 +224,12 @@ TC_GAR_SR_BI_17_C	PASS	haltest:
 						 <properties> 2 <permissions> 1
 				gatts start_service
 				gatts send_response: <status> 12
-TC_GAR_SR_BV_05_C	INC
-TC_GAR_SR_BI_18_C	INC
-TC_GAR_SR_BI_19_C	INC
-TC_GAR_SR_BI_20_C	INC
-TC_GAR_SR_BI_21_C	INC
-TC_GAR_SR_BI_22_C	INC
+TC_GAR_SR_BV_05_C	N/A
+TC_GAR_SR_BI_18_C	N/A
+TC_GAR_SR_BI_19_C	N/A
+TC_GAR_SR_BI_20_C	N/A
+TC_GAR_SR_BI_21_C	N/A
+TC_GAR_SR_BI_22_C	N/A
 TC_GAR_SR_BV_06_C	PASS	haltest:
 				gatts add_service
 				gatts add_characteristic:
-- 
1.8.5.3

