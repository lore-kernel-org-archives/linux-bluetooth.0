Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix constant for public address configuration
Date: Fri,  4 Jul 2014 13:23:38 +0200
Message-Id: <1404473018-18975-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The public address configuration option is value 0x02 since the generic
external configuration is value 0x01. So adjust this accordingly and
also add the value 0x01 to the list.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0579eb3952e3..3984678ffab1 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -472,7 +472,8 @@ struct mgmt_rp_read_unconf_index_list {
 	__le16	index[0];
 } __packed;
 
-#define MGMT_OPTION_PUBLIC_ADDRESS	0x00000001
+#define MGMT_OPTION_EXTERNAL_CONFIG	0x00000001
+#define MGMT_OPTION_PUBLIC_ADDRESS	0x00000002
 
 #define MGMT_OP_READ_CONFIG_INFO	0x0037
 #define MGMT_READ_CONFIG_INFO_SIZE	0
-- 
1.9.3

