Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 1/8] Bluetooth: Add macros for advertising instance flags
Date: Wed, 25 Mar 2015 18:53:39 -0700
Message-Id: <1427334826-14858-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macro definitions for possible advertising instance
flags that can be passed to the "Add Advertising" command.

Signed-off-by: Arman Uguray <armansito@chromium.org>
---
 include/net/bluetooth/mgmt.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 68abd4b..b831242 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -554,6 +554,14 @@ struct mgmt_rp_add_advertising {
 	__u8	instance;
 } __packed;
 
+#define MGMT_ADV_FLAG_CONNECTABLE	BIT(0)
+#define MGMT_ADV_FLAG_DISCOV		BIT(1)
+#define MGMT_ADV_FLAG_LIMITED_DISCOV	BIT(2)
+#define MGMT_ADV_FLAG_MANAGED_FLAGS	BIT(3)
+#define MGMT_ADV_FLAG_TX_POWER		BIT(4)
+#define MGMT_ADV_FLAG_APPEARANCE	BIT(5)
+#define MGMT_ADV_FLAG_LOCAL_NAME	BIT(6)
+
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
 	__u8	instance;
-- 
2.2.0.rc0.207.ga3a616c

