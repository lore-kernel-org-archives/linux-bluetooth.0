Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH] Cleanup: read_local_features callback is no longer used
Date: Thu, 16 Jun 2011 20:28:23 -0300
Message-Id: <1308266903-8700-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes read_local_features callback from struct
btd_adapter_ops and its hciops/mgmtops implementations.
---
 plugins/hciops.c  |   12 ------------
 plugins/mgmtops.c |   15 ---------------
 src/adapter.h     |    1 -
 3 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 6ce0e27..147f7ea 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3216,17 +3216,6 @@ static int hciops_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-static int hciops_read_local_features(int index, uint8_t *features)
-{
-	struct dev_info *dev = &devs[index];
-
-	DBG("hci%d", index);
-
-	memcpy(features, dev->features, 8);
-
-	return  0;
-}
-
 static int hciops_disconnect(int index, bdaddr_t *bdaddr)
 {
 	DBG("hci%d", index);
@@ -3668,7 +3657,6 @@ static struct btd_adapter_ops hci_ops = {
 	.block_device = hciops_block_device,
 	.unblock_device = hciops_unblock_device,
 	.get_conn_list = hciops_get_conn_list,
-	.read_local_features = hciops_read_local_features,
 	.disconnect = hciops_disconnect,
 	.remove_bonding = hciops_remove_bonding,
 	.pincode_reply = hciops_pincode_reply,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index d6226c4..3cdb97e 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1763,20 +1763,6 @@ static int mgmt_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-static int mgmt_read_local_features(int index, uint8_t *features)
-{
-	struct controller_info *info = &controllers[index];
-
-	DBG("index %d", index);
-
-	if (!info->valid)
-		return -ENODEV;
-
-	memcpy(features, info->features, 8);
-
-	return 0;
-}
-
 static int mgmt_disconnect(int index, bdaddr_t *bdaddr)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_disconnect)];
@@ -2062,7 +2048,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.block_device = mgmt_block_device,
 	.unblock_device = mgmt_unblock_device,
 	.get_conn_list = mgmt_get_conn_list,
-	.read_local_features = mgmt_read_local_features,
 	.disconnect = mgmt_disconnect,
 	.remove_bonding = mgmt_remove_bonding,
 	.pincode_reply = mgmt_pincode_reply,
diff --git a/src/adapter.h b/src/adapter.h
index 3526849..610331f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -186,7 +186,6 @@ struct btd_adapter_ops {
 	int (*block_device) (int index, bdaddr_t *bdaddr);
 	int (*unblock_device) (int index, bdaddr_t *bdaddr);
 	int (*get_conn_list) (int index, GSList **conns);
-	int (*read_local_features) (int index, uint8_t *features);
 	int (*disconnect) (int index, bdaddr_t *bdaddr);
 	int (*remove_bonding) (int index, bdaddr_t *bdaddr);
 	int (*pincode_reply) (int index, bdaddr_t *bdaddr, const char *pin,
-- 
1.7.4.1

