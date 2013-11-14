Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android: Add PTS PICS for HID
Date: Thu, 14 Nov 2013 14:26:27 +0100
Message-Id: <1384435587-12427-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1384435587-12427-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PTS PICS for HID, targeting Android 4.4.

---
 android/pics-hid.txt | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 android/pics-hid.txt

diff --git a/android/pics-hid.txt b/android/pics-hid.txt
new file mode 100644
index 0000000..36c49bf
--- /dev/null
+++ b/android/pics-hid.txt
@@ -0,0 +1,105 @@
+HID PICS for the PTS tool.
+
+* - different than PTS defaults
+
++------------------+------------+
+|  Parameter Name  |  Selected  |
++------------------+------------+
+| TSPC_HID_1_1     |   True*    |
+| TSPC_HID_1_2     |   False    |
+| TSPC_HID_1_3     |   False    |
+| TSPC_HID_2_1     |   True     |
+| TSPC_HID_2_2     |   True     |
+| TSPC_HID_2_3     |   True     |
+| TSPC_HID_2_4     |   True     |
+| TSPC_HID_2_5     |   True     |
+| TSPC_HID_2_6     |   True     |
+| TSPC_HID_2_7     |   True     |
+| TSPC_HID_2_8     |   True     |
+| TSPC_HID_2_9     |   True     |
+| TSPC_HID_2_10    |   False    |
+| TSPC_HID_2_11    |   False    |
+| TSPC_HID_2_12    |   False    |
+| TSPC_HID_2_13    |   False    |
+| TSPC_HID_2_14    |   False    |
+| TSPC_HID_2_15    |   False    |
+| TSPC_HID_3_1     |   False    |
+| TSPC_HID_3_2     |   True*    |
+| TSPC_HID_3_3     |   True*    |
+| TSPC_HID_3_4     |   False    |
+| TSPC_HID_4_1     |   False    |
+| TSPC_HID_4_2     |   False    |
+| TSPC_HID_4_3     |   True*    |
+| TSPC_HID_4_4     |   False    |
+| TSPC_HID_5_1     |   False    |
+| TSPC_HID_5_2     |   False    |
+| TSPC_HID_5_3     |   False    |
+| TSPC_HID_5_4     |   False    |
+| TSPC_HID_5_5     |   False*   |
+| TSPC_HID_5_6     |   False*   |
+| TSPC_HID_6_1     |   False    |
+| TSPC_HID_6_2     |   False    |
+| TSPC_HID_6_3     |   False    |
+| TSPC_HID_6_4     |   False    |
+| TSPC_HID_6_5     |   False    |
+| TSPC_HID_6_6     |   False    |
+| TSPC_HID_6_7     |   False    |
+| TSPC_HID_6_8     |   True     |
+| TSPC_HID_6_9     |   True     |
+| TSPC_HID_6_10    |   True     |
+| TSPC_HID_6_11    |   False    |
+| TSPC_HID_6_12    |   True     |
+| TSPC_HID_6_13    |   False    |
+| TSPC_HID_7_1     |   True     |
+| TSPC_HID_7_2     |   False*   |
+| TSPC_HID_8_1     |   False    |
+| TSPC_HID_8_2     |   False    |
+| TSPC_HID_8_3     |   False    |
+| TSPC_HID_8_4     |   False    |
+| TSPC_HID_9_1     |   False    |
+| TSPC_HID_9_2     |   False*   |
+| TSPC_HID_9_3     |   False    |
+| TSPC_HID_9_4     |   False*   |
+| TSPC_HID_9_5     |   False    |
+| TSPC_HID_9_6     |   False    |
+| TSPC_HID_9_7     |   False    |
+| TSPC_HID_9_8     |   False    |
+| TSPC_HID_9_9     |   False    |
+| TSPC_HID_9_10    |   False    |
+| TSPC_HID_9_11    |   False    |
+| TSPC_HID_9_12    |   False    |
+| TSPC_HID_9_13    |   False    |
+| TSPC_HID_9_14    |   False    |
+| TSPC_HID_9_15    |   False    |
+| TSPC_HID_9_16    |   False    |
+| TSPC_HID_10_1    |   False    |
+| TSPC_HID_10_2    |   False    |
+| TSPC_HID_10_3    |   False    |
+| TSPC_HID_10_4    |   False    |
+| TSPC_HID_11_1    |   False    |
+| TSPC_HID_11_2    |   False    |
+| TSPC_HID_11_3    |   False    |
+| TSPC_HID_11_4    |   False    |
+| TSPC_HID_12_1    |   False    |
+| TSPC_HID_12_2    |   False    |
+| TSPC_HID_12_3    |   False    |
+| TSPC_HID_12_4    |   False    |
+| TSPC_HID_12_5    |   False    |
+| TSPC_HID_12_6    |   False    |
+| TSPC_HID_13_1    |   False    |
+| TSPC_HID_13_2    |   False    |
+| TSPC_HID_13_3    |   False    |
+| TSPC_HID_13_4    |   False    |
+| TSPC_HID_13_5    |   False    |
+| TSPC_HID_13_6    |   False    |
+| TSPC_HID_13_7    |   False    |
+| TSPC_HID_13_8    |   False    |
+| TSPC_HID_13_9    |   False    |
+| TSPC_HID_13_10   |   False    |
+| TSPC_HID_13_11   |   False    |
+| TSPC_HID_13_12   |   False    |
+| TSPC_HID_13_13   |   False    |
+| TSPC_HID_14_1    |   False    |
+| TSPC_HID_14_2    |   False*   |
+| TSPC_ALL         |   False    |
++------------------+------------+
-- 
1.8.4.1

