Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 20/20] Bluetooth: hci_core: increase max adv inst
Date: Thu, 18 Jun 2015 03:16:53 +0200
Message-Id: <1434590213-26599-21-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that all preconditions are present for actual multi-advertising, the
number of allowed advertising instances can be larger than one. This
patch increases the number of allowed advertising instances to 5.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a6cec6d..3bd618d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -169,7 +169,7 @@ struct adv_info {
 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
 };
 
-#define HCI_MAX_ADV_INSTANCES		1
+#define HCI_MAX_ADV_INSTANCES		5
 #define HCI_DEFAULT_ADV_DURATION	2
 
 #define HCI_MAX_SHORT_NAME_LENGTH	10
-- 
1.9.1

