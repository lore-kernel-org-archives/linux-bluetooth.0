Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 4/4] Remove read_local_version() from struct btd_adapter_ops
Date: Tue, 19 Apr 2011 16:34:03 -0400
Message-Id: <1303245243-12116-5-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
References: <1303245243-12116-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This callback is used only for getting HCI version/manufacturer
information, and is not being called anywhere in BlueZ anymore.
---
 plugins/hciops.c  |   12 ------------
 plugins/mgmtops.c |   18 ------------------
 src/adapter.h     |    1 -
 3 files changed, 0 insertions(+), 31 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 7d2eca3..2b9be3f 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3231,17 +3231,6 @@ static int hciops_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-static int hciops_read_local_version(int index, struct hci_version *ver)
-{
-	struct dev_info *dev = &devs[index];
-
-	DBG("hci%d", index);
-
-	memcpy(ver, &dev->ver, sizeof(*ver));
-
-	return 0;
-}
-
 static int hciops_read_local_features(int index, uint8_t *features)
 {
 	struct dev_info *dev = &devs[index];
@@ -3696,7 +3685,6 @@ static struct btd_adapter_ops hci_ops = {
 	.block_device = hciops_block_device,
 	.unblock_device = hciops_unblock_device,
 	.get_conn_list = hciops_get_conn_list,
-	.read_local_version = hciops_read_local_version,
 	.read_local_features = hciops_read_local_features,
 	.disconnect = hciops_disconnect,
 	.remove_bonding = hciops_remove_bonding,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 042afc5..bb53e82 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1706,23 +1706,6 @@ static int mgmt_get_conn_list(int index, GSList **conns)
 	return 0;
 }
 
-static int mgmt_read_local_version(int index, struct hci_version *ver)
-{
-	struct controller_info *info = &controllers[index];
-
-	DBG("index %d", index);
-
-	if (!info->valid)
-		return -ENODEV;
-
-	memset(ver, 0, sizeof(*ver));
-	ver->manufacturer = info->manufacturer;
-	ver->hci_ver = info->hci_ver;
-	ver->hci_rev = info->hci_rev;
-
-	return 0;
-}
-
 static int mgmt_read_local_features(int index, uint8_t *features)
 {
 	struct controller_info *info = &controllers[index];
@@ -2024,7 +2007,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.block_device = mgmt_block_device,
 	.unblock_device = mgmt_unblock_device,
 	.get_conn_list = mgmt_get_conn_list,
-	.read_local_version = mgmt_read_local_version,
 	.read_local_features = mgmt_read_local_features,
 	.disconnect = mgmt_disconnect,
 	.remove_bonding = mgmt_remove_bonding,
diff --git a/src/adapter.h b/src/adapter.h
index 4d8824e..ee3cae9 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -209,7 +209,6 @@ struct btd_adapter_ops {
 	int (*block_device) (int index, bdaddr_t *bdaddr);
 	int (*unblock_device) (int index, bdaddr_t *bdaddr);
 	int (*get_conn_list) (int index, GSList **conns);
-	int (*read_local_version) (int index, struct hci_version *ver);
 	int (*read_local_features) (int index, uint8_t *features);
 	int (*disconnect) (int index, bdaddr_t *bdaddr);
 	int (*remove_bonding) (int index, bdaddr_t *bdaddr);
-- 
1.7.0.4

