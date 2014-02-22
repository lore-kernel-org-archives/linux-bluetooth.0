Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/15] Bluetooth: Add mgmt defines for privacy
Date: Sat, 22 Feb 2014 19:06:34 +0200
Message-Id: <1393088805-28658-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds basic mgmt defines for enabling privacy. This includes a
new setting flag as well as the Set Privacy command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2e46251e8aec..62d560624e3d 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -96,6 +96,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_ADVERTISING	0x00000400
 #define MGMT_SETTING_SECURE_CONN	0x00000800
 #define MGMT_SETTING_DEBUG_KEYS		0x00001000
+#define MGMT_SETTING_PRIVACY		0x00002000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -389,6 +390,13 @@ struct mgmt_cp_set_scan_params {
 
 #define MGMT_OP_SET_DEBUG_KEYS		0x002E
 
+#define MGMT_OP_SET_PRIVACY		0x002F
+struct mgmt_cp_set_privacy {
+	__u8 privacy;
+	__u8 irk[16];
+} __packed;
+#define MGMT_SET_PRIVACY_SIZE		17
+
 struct mgmt_irk_info {
 	struct mgmt_addr_info addr;
 	__u8 val[16];
-- 
1.8.5.3

