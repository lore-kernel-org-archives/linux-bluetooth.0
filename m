Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add missing mgmt_confirm_name command definition
Date: Mon, 19 Dec 2011 14:29:08 +0200
Message-Id: <1324297748-8546-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1324297748-8546-1-git-send-email-johan.hedberg@gmail.com>
References: <1324297748-8546-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary structs for the Confirm Name command. This
ensures that the protocol definitions are up to date with the latest
mgmt specification. The actual implementation of the command will follow
in a later patch-set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f4786a8..be65d34 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -268,6 +268,16 @@ struct mgmt_cp_start_discovery {
 
 #define MGMT_OP_STOP_DISCOVERY		0x0022
 
+#define MGMT_OP_CONFIRM_NAME		0x0023
+struct mgmt_cp_confirm_name {
+	bdaddr_t bdaddr;
+	__u8 name_known;
+} __packed;
+struct mgmt_rp_confirm_name {
+	bdaddr_t bdaddr;
+	__u8 status;
+} __packed;
+
 #define MGMT_OP_BLOCK_DEVICE		0x0024
 struct mgmt_cp_block_device {
 	bdaddr_t bdaddr;
-- 
1.7.7.3

