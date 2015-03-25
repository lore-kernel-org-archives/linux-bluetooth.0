Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/7] lib: Add macros for advertising instance flags
Date: Tue, 24 Mar 2015 20:05:48 -0700
Message-Id: <1427252754-27889-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macro definitions for possible advertising instance
flags that can be passed to the "Add Advertising" mgmt command.
---
 lib/mgmt.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 01d948b..eb13c42 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -498,6 +498,14 @@ struct mgmt_rp_add_advertising {
 	uint8_t instance;
 } __packed;
 
+#define MGMT_ADV_FLAG_CONNECTABLE	(1 << 0)
+#define MGMT_ADV_FLAG_DISCOV		(1 << 1)
+#define MGMT_ADV_FLAG_LIMITED_DISCOV	(1 << 2)
+#define MGMT_ADV_FLAG_MANAGED_FLAGS	(1 << 3)
+#define MGMT_ADV_FLAG_TX_POWER		(1 << 4)
+#define MGMT_ADV_FLAG_APPEARANCE	(1 << 5)
+#define MGMT_ADV_FLAG_LOCAL_NAME	(1 << 6)
+
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
 	uint8_t instance;
-- 
2.2.0.rc0.207.ga3a616c

