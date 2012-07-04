Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 07/28] adapter: remove btd_adapter_encrypt_link()
Date: Wed,  4 Jul 2012 10:17:26 +0200
Message-Id: <1341389867-30749-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
References: <1341389867-30749-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

After the removal of hciops this function is not necessary anymore, we now
use setsockopt to accomplish the encryption of the link.
---
 input/device.c    |   38 ++++++++++----------------------------
 plugins/mgmtops.c |   12 ------------
 src/adapter.c     |    6 ------
 src/adapter.h     |    5 -----
 4 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/input/device.c b/input/device.c
index 09a9a39..c08ba18 100644
--- a/input/device.c
+++ b/input/device.c
@@ -653,22 +653,18 @@ static int hidp_add_connection(const struct input_device *idev,
 
 	/* Encryption is mandatory for keyboards */
 	if (req->subclass & 0x40) {
-		struct btd_adapter *adapter = device_get_adapter(idev->device);
-
-		err = btd_adapter_encrypt_link(adapter, (bdaddr_t *) &idev->dst,
-						encrypt_completed, req);
-		if (err == 0) {
-			/* Waiting async encryption */
-			return 0;
-		}
-
-		if (err == -ENOSYS)
-			goto nosys;
-
-		if (err != -EALREADY) {
-			error("encrypt_link: %s (%d)", strerror(-err), -err);
+		if (!bt_io_set(iconn->intr_io, BT_IO_L2CAP, &gerr,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_INVALID)) {
+			error("btio: %s", gerr->message);
+			g_error_free(gerr);
+			err = -EFAULT;
 			goto cleanup;
 		}
+
+		iconn->req = req;
+		iconn->sec_watch = g_io_add_watch(iconn->intr_io, G_IO_OUT,
+							encrypt_notify, iconn);
 	}
 
 	err = ioctl_connadd(req);
@@ -678,20 +674,6 @@ cleanup:
 	g_free(req);
 
 	return err;
-
-nosys:
-	if (!bt_io_set(iconn->intr_io, BT_IO_L2CAP, &gerr,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID)) {
-		error("btio: %s", gerr->message);
-		g_error_free(gerr);
-		goto cleanup;
-	}
-
-	iconn->req = req;
-	iconn->sec_watch = g_io_add_watch(iconn->intr_io, G_IO_OUT,
-							encrypt_notify, iconn);
-	return 0;
 }
 
 static int is_connected(struct input_conn *iconn)
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 16a97c9..f734edc 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -2157,17 +2157,6 @@ static int mgmt_unpair_device(int index, bdaddr_t *bdaddr, uint8_t bdaddr_type)
 	return 0;
 }
 
-static int mgmt_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
-							gpointer user_data)
-{
-	char addr[18];
-
-	ba2str(dst, addr);
-	DBG("index %d addr %s", index, addr);
-
-	return -ENOSYS;
-}
-
 static int mgmt_set_did(int index, uint16_t vendor, uint16_t product,
 					uint16_t version, uint16_t source)
 {
@@ -2492,7 +2481,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.pincode_reply = mgmt_pincode_reply,
 	.confirm_reply = mgmt_confirm_reply,
 	.passkey_reply = mgmt_passkey_reply,
-	.encrypt_link = mgmt_encrypt_link,
 	.set_did = mgmt_set_did,
 	.add_uuid = mgmt_add_uuid,
 	.remove_uuid = mgmt_remove_uuid,
diff --git a/src/adapter.c b/src/adapter.c
index 9315922..b485c88 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3478,12 +3478,6 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 								passkey);
 }
 
-int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-					bt_hci_result_t cb, gpointer user_data)
-{
-	return adapter_ops->encrypt_link(adapter->dev_id, bdaddr, cb, user_data);
-}
-
 int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 					uint16_t product, uint16_t version,
 					uint16_t source)
diff --git a/src/adapter.h b/src/adapter.h
index b7ea62b..77d79c1 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -200,8 +200,6 @@ struct btd_adapter_ops {
 							gboolean success);
 	int (*passkey_reply) (int index, bdaddr_t *bdaddr, uint8_t bdaddr_type,
 							uint32_t passkey);
-	int (*encrypt_link) (int index, bdaddr_t *bdaddr, bt_hci_result_t cb,
-							gpointer user_data);
 	int (*set_did) (int index, uint16_t vendor, uint16_t product,
 					uint16_t version, uint16_t source);
 	int (*add_uuid) (int index, uuid_t *uuid, uint8_t svc_hint);
@@ -261,9 +259,6 @@ int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, uint32_t passkey);
 
-int btd_adapter_encrypt_link(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				bt_hci_result_t cb, gpointer user_data);
-
 int btd_adapter_set_did(struct btd_adapter *adapter, uint16_t vendor,
 					uint16_t product, uint16_t version,
 					uint16_t source);
-- 
1.7.10.2

