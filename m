Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android: Add PTS PICS for GAP
Date: Thu, 14 Nov 2013 14:26:26 +0100
Message-Id: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS PICS for GAP, targeting Android 4.4.

---
 android/pics-gap.txt | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)
 create mode 100644 android/pics-gap.txt

diff --git a/android/pics-gap.txt b/android/pics-gap.txt
new file mode 100644
index 0000000..bcb64cb
--- /dev/null
+++ b/android/pics-gap.txt
@@ -0,0 +1,201 @@
+GAP PICS for the PTS tool.
+
+* - different than PTS defaults
+
++------------------+------------+
+|  Parameter Name  |  Selected  |
++------------------+------------+
+| TSPC_GAP_0_1     |   False    |
+| TSPC_GAP_0_2     |   False    |
+| TSPC_GAP_0_3     |   True*    |
+| TSPC_GAP_0A_1    |   False    |
+| TSPC_GAP_1_1     |   True*    |
+| TSPC_GAP_1_2     |   False    |
+| TSPC_GAP_1_3     |   True*    |
+| TSPC_GAP_1_4     |   True*    |
+| TSPC_GAP_1_5     |   True     |
+| TSPC_GAP_1_6     |   False    |
+| TSPC_GAP_1_7     |   True*    |
+| TSPC_GAP_2_1     |   True*    |
+| TSPC_GAP_2_2     |   True*    |
+| TSPC_GAP_2_3     |   True*    |
+| TSPC_GAP_2_4     |   False    |
+| TSPC_GAP_2_5     |   True*    |
+| TSPC_GAP_2_6     |   False    |
+| TSPC_GAP_2_7     |   True*    |
+| TSPC_GAP_2_8     |   True*    |
+| TSPC_GAP_2_9     |   True*    |
+| TSPC_GAP_2_10    |   False    |
+| TSPC_GAP_3_1     |   True*    |
+| TSPC_GAP_3_2     |   False    |
+| TSPC_GAP_3_3     |   True*    |
+| TSPC_GAP_3_4     |   True*    |
+| TSPC_GAP_3_5     |   True*    |
+| TSPC_GAP_3_6     |   True*    |
+| TSPC_GAP_4_1     |   True     |
+| TSPC_GAP_4_2     |   True     |
+| TSPC_GAP_4_3     |   True*    |
+| TSPC_GAP_4_4     |   True     |
+| TSPC_GAP_4_5     |   True*    |
+| TSPC_GAP_4_6     |   True*    |
+| TSPC_GAP_5_1     |   False*   |
+| TSPC_GAP_5_2     |   False    |
+| TSPC_GAP_5_3     |   False*   |
+| TSPC_GAP_5_4     |   True*    |
+| TSPC_GAP_6_1     |   False*   |
+| TSPC_GAP_6_2     |   False    |
+| TSPC_GAP_7_1     |   False*   |
+| TSPC_GAP_7_2     |   False*   |
+| TSPC_GAP_8_1     |   False*   |
+| TSPC_GAP_8_2     |   False    |
+| TSPC_GAP_8A_1    |   False    |
+| TSPC_GAP_8A_2    |   False    |
+| TSPC_GAP_8A_3    |   False*   |
+| TSPC_GAP_8A_4    |   False    |
+| TSPC_GAP_8A_5    |   False    |
+| TSPC_GAP_8A_6    |   False    |
+| TSPC_GAP_8A_7    |   False    |
+| TSPC_GAP_8A_8    |   False    |
+| TSPC_GAP_8A_9    |   False    |
+| TSPC_GAP_8A_10   |   False    |
+| TSPC_GAP_9_1     |   False*   |
+| TSPC_GAP_10_1    |   False*   |
+| TSPC_GAP_11_1    |   False    |
+| TSPC_GAP_11_2    |   False    |
+| TSPC_GAP_12_1    |   True     |
+| TSPC_GAP_12_2    |   False    |
+| TSPC_GAP_13_1    |   True     |
+| TSPC_GAP_13_2    |   True     |
+| TSPC_GAP_14_1    |   True     |
+| TSPC_GAP_14_2    |   False    |
+| TSPC_GAP_15_1    |   True     |
+| TSPC_GAP_16_1    |   True     |
+| TSPC_GAP_17_1    |   False    |
+| TSPC_GAP_17_2    |   False    |
+| TSPC_GAP_17_3    |   False    |
+| TSPC_GAP_17_4    |   False    |
+| TSPC_GAP_18_1    |   False    |
+| TSPC_GAP_18_2    |   False    |
+| TSPC_GAP_19_1    |   False    |
+| TSPC_GAP_19_2    |   False    |
+| TSPC_GAP_19_3    |   False    |
+| TSPC_GAP_20_1    |   False    |
+| TSPC_GAP_20_2    |   False    |
+| TSPC_GAP_20_3    |   False    |
+| TSPC_GAP_20_4    |   False    |
+| TSPC_GAP_20A_1   |   False    |
+| TSPC_GAP_20A_2   |   False    |
+| TSPC_GAP_20A_3   |   False    |
+| TSPC_GAP_20A_4   |   False    |
+| TSPC_GAP_20A_5   |   False    |
+| TSPC_GAP_20A_6   |   False    |
+| TSPC_GAP_20A_7   |   False    |
+| TSPC_GAP_20A_8   |   False    |
+| TSPC_GAP_20A_9   |   False    |
+| TSPC_GAP_20A_10  |   False    |
+| TSPC_GAP_21_1    |   False*   |
+| TSPC_GAP_21_2    |   False*   |
+| TSPC_GAP_21_3    |   False    |
+| TSPC_GAP_21_4    |   False*   |
+| TSPC_GAP_21_5    |   False*   |
+| TSPC_GAP_21_6    |   False*   |
+| TSPC_GAP_22_1    |   False    |
+| TSPC_GAP_22_2    |   False    |
+| TSPC_GAP_22_3    |   False    |
+| TSPC_GAP_22_4    |   False    |
+| TSPC_GAP_23_1    |   False    |
+| TSPC_GAP_23_2    |   False    |
+| TSPC_GAP_23_3    |   False    |
+| TSPC_GAP_23_4    |   False    |
+| TSPC_GAP_23_5    |   False    |
+| TSPC_GAP_24_1    |   False    |
+| TSPC_GAP_24_2    |   False    |
+| TSPC_GAP_24_3    |   False    |
+| TSPC_GAP_24_4    |   False    |
+| TSPC_GAP_25_1    |   False    |
+| TSPC_GAP_25_2    |   False    |
+| TSPC_GAP_25_3    |   False    |
+| TSPC_GAP_25_4    |   False    |
+| TSPC_GAP_25_5    |   False    |
+| TSPC_GAP_25_6    |   False    |
+| TSPC_GAP_25_7    |   False    |
+| TSPC_GAP_25_8    |   False    |
+| TSPC_GAP_26_1    |   False    |
+| TSPC_GAP_26_2    |   False    |
+| TSPC_GAP_26_3    |   False    |
+| TSPC_GAP_27_1    |   False*   |
+| TSPC_GAP_27_2    |   False*   |
+| TSPC_GAP_27_3    |   False    |
+| TSPC_GAP_27_4    |   False    |
+| TSPC_GAP_27_5    |   False    |
+| TSPC_GAP_27_6    |   False    |
+| TSPC_GAP_27_7    |   False    |
+| TSPC_GAP_27_8    |   False    |
+| TSPC_GAP_28_1    |   True*    |
+| TSPC_GAP_28_2    |   True*    |
+| TSPC_GAP_29_1    |   True*    |
+| TSPC_GAP_29_2    |   True*    |
+| TSPC_GAP_29_3    |   True*    |
+| TSPC_GAP_29_4    |   True*    |
+| TSPC_GAP_30_1    |   True*    |
+| TSPC_GAP_30_2    |   True*    |
+| TSPC_GAP_31_1    |   True*    |
+| TSPC_GAP_31_2    |   True*    |
+| TSPC_GAP_31_3    |   True*    |
+| TSPC_GAP_31_4    |   True*    |
+| TSPC_GAP_31_5    |   True*    |
+| TSPC_GAP_31_6    |   True*    |
+| TSPC_GAP_32_1    |   False    |
+| TSPC_GAP_32_2    |   True*    |
+| TSPC_GAP_32_3    |   True*    |
+| TSPC_GAP_33_1    |   True*    |
+| TSPC_GAP_33_2    |   True*    |
+| TSPC_GAP_33_3    |   True*    |
+| TSPC_GAP_33_4    |   True*    |
+| TSPC_GAP_33_5    |   True*    |
+| TSPC_GAP_33_6    |   True*    |
+| TSPC_GAP_34_1    |   False    |
+| TSPC_GAP_34_2    |   True*    |
+| TSPC_GAP_34_3    |   True*    |
+| TSPC_GAP_35_1    |   True*    |
+| TSPC_GAP_35_2    |   True*    |
+| TSPC_GAP_35_3    |   True*    |
+| TSPC_GAP_35_4    |   True*    |
+| TSPC_GAP_35_5    |   True*    |
+| TSPC_GAP_35_6    |   True*    |
+| TSPC_GAP_35_7    |   False    |
+| TSPC_GAP_35_8    |   False    |
+| TSPC_GAP_36_1    |   False    |
+| TSPC_GAP_36_2    |   False    |
+| TSPC_GAP_36_3    |   False    |
+| TSPC_GAP_36_4    |   False    |
+| TSPC_GAP_37_1    |   True*    |
+| TSPC_GAP_37_2    |   True*    |
+| TSPC_GAP_38_1    |   False    |
+| TSPC_GAP_38_2    |   True*    |
+| TSPC_GAP_38_3    |   False    |
+| TSPC_GAP_38_4    |   True*    |
+| TSPC_GAP_39_1    |   True*    |
+| TSPC_GAP_39_2    |   True*    |
+| TSPC_GAP_39_3    |   True*    |
+| TSPC_GAP_39_4    |   True     |
+| TSPC_GAP_39_5    |   False    |
+| TSPC_GAP_39_6    |   True*    |
+| TSPC_GAP_40_1    |   True*    |
+| TSPC_GAP_40_2    |   False    |
+| TSPC_GAP_40_3    |   True*    |
+| TSPC_GAP_40_4    |   True*    |
+| TSPC_GAP_40_5    |   True*    |
+| TSPC_GAP_41_1    |   True     |
+| TSPC_GAP_42_1    |   False    |
+| TSPC_GAP_42_2    |   False    |
+| TSPC_GAP_42_3    |   False    |
+| TSPC_GAP_42_4    |   False*   |
+| TSPC_GAP_42_5    |   False    |
+| TSPC_GAP_42_6    |   False    |
+| TSPC_GAP_43_1    |   False*   |
+| TSPC_SM_1_1      |   False    |
+| TSPC_SM_1_2      |   False    |
+| TSPC_SM_2_4      |   False    |
+| TSPC_ALL         |   False    |
++------------------+------------+
-- 
1.8.4.1

