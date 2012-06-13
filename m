Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 10/21] adapter: make restore powered work again
Date: Wed, 13 Jun 2012 17:43:32 -0300
Message-Id: <1339620223-6639-11-git-send-email-gustavo@padovan.org>
In-Reply-To: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

differently from hciops mgmtops had no support to restore the powered of a
adapter. We now do this directly inside adapter_remove()
---
 plugins/mgmtops.c |    7 -------
 src/adapter.c     |    5 ++++-
 src/adapter.h     |    1 -
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 7c77be8..c060ada 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -2183,12 +2183,6 @@ static int mgmt_set_did(int index, uint16_t vendor, uint16_t product,
 	return 0;
 }
 
-static int mgmt_restore_powered(int index)
-{
-	DBG("index %d", index);
-	return -ENOSYS;
-}
-
 static int mgmt_load_link_keys(int index, GSList *keys, gboolean debug_keys)
 {
 	char *buf;
@@ -2476,7 +2470,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_did = mgmt_set_did,
 	.add_uuid = mgmt_add_uuid,
 	.remove_uuid = mgmt_remove_uuid,
-	.restore_powered = mgmt_restore_powered,
 	.load_keys = mgmt_load_link_keys,
 	.set_io_capability = mgmt_set_io_capability,
 	.create_bonding = mgmt_create_bonding,
diff --git a/src/adapter.c b/src/adapter.c
index a82029a..af6c003 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -109,6 +109,7 @@ struct service_auth {
 struct btd_adapter {
 	uint16_t dev_id;
 	gboolean up;
+	gboolean already_up;
 	char *path;			/* adapter object path */
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
@@ -2389,6 +2390,7 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 {
 	adapter->up = up;
+	adapter->already_up = up;
 
 	adapter->allow_name_changes = TRUE;
 
@@ -2469,7 +2471,8 @@ void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->pin_callbacks);
 
 	/* Return adapter to down state if it was not up on init */
-	adapter_ops->restore_powered(adapter->dev_id);
+	if (!adapter->already_up && adapter->up)
+		adapter_ops->set_powered(adapter->dev_id, FALSE);
 }
 
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter)
diff --git a/src/adapter.h b/src/adapter.h
index 4c39a7b..73cd770 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -204,7 +204,6 @@ struct btd_adapter_ops {
 					uint16_t version, uint16_t source);
 	int (*add_uuid) (int index, uuid_t *uuid, uint8_t svc_hint);
 	int (*remove_uuid) (int index, uuid_t *uuid);
-	int (*restore_powered) (int index);
 	int (*load_keys) (int index, GSList *keys, gboolean debug_keys);
 	int (*set_io_capability) (int index, uint8_t io_capability);
 	int (*create_bonding) (int index, bdaddr_t *bdaddr,
-- 
1.7.10.2

