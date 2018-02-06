Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tedd Ho Jeong An <tedd.an@intel.com>
Subject: [PATCH BlueZ 2/2] tester: Enable LE Generate DHKey Complete event
Date: Tue,  6 Feb 2018 13:03:57 -0800
Message-Id: <1517951037-2970-2-git-send-email-tedd.an@linux.intel.com>
In-Reply-To: <1517951037-2970-1-git-send-email-tedd.an@linux.intel.com>
References: <1517951037-2970-1-git-send-email-tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho Jeong An <tedd.an@intel.com>

This patch adds LE Generate DHKey Complete event for
LE Event Mask list for 'LE Generate DHKey'.
---
 tools/hci-tester.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 1e9ce4e..7873e7a 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -550,6 +550,7 @@ static void setup_le_generate_dhkey(const void *test_data)
 
 	memset(lsem.mask, 0, 8);
 	lsem.mask[0] |= 0x80;	/* LE Read Local P-256 Public Key Complete */
+	lsem.mask[1] |= 0x01;	/* LE Generate DHKey Complete */
 
 	bt_hci_send(user->hci_ut, BT_HCI_CMD_LE_SET_EVENT_MASK,
 					&lsem, sizeof(lsem), NULL, NULL, NULL);
-- 
2.7.4

