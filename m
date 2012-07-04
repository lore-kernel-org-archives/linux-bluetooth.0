Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 08/28] adapter_ops: remove disable_cod_cache
Date: Wed,  4 Jul 2012 10:17:27 +0200
Message-Id: <1341389867-30749-9-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

mgmt handles the cache automatically.
---
 plugins/mgmtops.c |    9 ---------
 src/adapter.c     |    2 --
 src/adapter.h     |    1 -
 3 files changed, 12 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index f734edc..7c77be8 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -2183,14 +2183,6 @@ static int mgmt_set_did(int index, uint16_t vendor, uint16_t product,
 	return 0;
 }
 
-static int mgmt_disable_cod_cache(int index)
-{
-	DBG("index %d", index);
-
-	/* The cache control is handled automatically for mgmt */
-	return 0;
-}
-
 static int mgmt_restore_powered(int index)
 {
 	DBG("index %d", index);
@@ -2484,7 +2476,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_did = mgmt_set_did,
 	.add_uuid = mgmt_add_uuid,
 	.remove_uuid = mgmt_remove_uuid,
-	.disable_cod_cache = mgmt_disable_cod_cache,
 	.restore_powered = mgmt_restore_powered,
 	.load_keys = mgmt_load_link_keys,
 	.set_io_capability = mgmt_set_io_capability,
diff --git a/src/adapter.c b/src/adapter.c
index b485c88..a043366 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2188,8 +2188,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 
 	call_adapter_powered_callbacks(adapter, TRUE);
 
-	adapter_ops->disable_cod_cache(adapter->dev_id);
-
 	info("Adapter %s has been enabled", adapter->path);
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 77d79c1..4c39a7b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -204,7 +204,6 @@ struct btd_adapter_ops {
 					uint16_t version, uint16_t source);
 	int (*add_uuid) (int index, uuid_t *uuid, uint8_t svc_hint);
 	int (*remove_uuid) (int index, uuid_t *uuid);
-	int (*disable_cod_cache) (int index);
 	int (*restore_powered) (int index);
 	int (*load_keys) (int index, GSList *keys, gboolean debug_keys);
 	int (*set_io_capability) (int index, uint8_t io_capability);
-- 
1.7.10.2

