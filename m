Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Fix mgmt_(block,unblock)_device opcodes
Date: Mon, 19 Dec 2011 14:29:07 +0200
Message-Id: <1324297748-8546-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1324297748-8546-1-git-send-email-johan.hedberg@gmail.com>
References: <1324297748-8546-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the opcodes of the Block/Unblock device commands to
match with what user-space expects and to confirm with the latest mgmt
specification. The reason the values were wrong was a missing Confirm
Name command definition (which will be added by a subsequent patch).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 9f7a956..f4786a8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -268,12 +268,12 @@ struct mgmt_cp_start_discovery {
 
 #define MGMT_OP_STOP_DISCOVERY		0x0022
 
-#define MGMT_OP_BLOCK_DEVICE		0x0023
+#define MGMT_OP_BLOCK_DEVICE		0x0024
 struct mgmt_cp_block_device {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_OP_UNBLOCK_DEVICE		0x0024
+#define MGMT_OP_UNBLOCK_DEVICE		0x0025
 struct mgmt_cp_unblock_device {
 	bdaddr_t bdaddr;
 } __packed;
-- 
1.7.7.3

