Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Remove EnableLE option from the user-space
Date: Fri, 19 Aug 2011 17:30:40 -0300
Message-Id: <1313785841-24047-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Deprecated configure option after adding "enable_le" parameter in the
bluetooth module. Write LE Host Supported Command is now sent by the
kernel if "enable_le" is enabled and the controller supports LE.
---
 plugins/hciops.c    |   24 +-----------------------
 plugins/mgmtops.c   |    7 -------
 src/adapter.c       |    3 ---
 src/adapter.h       |    1 -
 src/attrib-server.c |    3 ---
 src/hcid.h          |    1 -
 src/main.c          |    7 -------
 src/main.conf       |    7 +------
 8 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecc0e86..0f8f79d 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -208,7 +208,7 @@ static inline gboolean is_le_capable(int index)
 {
 	struct dev_info *dev = &devs[index];
 
-	return (main_opts.le && dev->features[4] & LMP_LE &&
+	return (dev->features[4] & LMP_LE &&
 			dev->extfeatures[0] & LMP_HOST_LE) ? TRUE : FALSE;
 }
 
@@ -3307,27 +3307,6 @@ static int hciops_passkey_reply(int index, bdaddr_t *bdaddr, uint32_t passkey)
 	return err;
 }
 
-static int hciops_enable_le(int index)
-{
-	struct dev_info *dev = &devs[index];
-	write_le_host_supported_cp cp;
-
-	DBG("hci%d", index);
-
-	if (!(dev->features[4] & LMP_LE))
-		return -ENOTSUP;
-
-	cp.le = 0x01;
-	cp.simul = (dev->features[6] & LMP_LE_BREDR) ? 0x01 : 0x00;
-
-	if (hci_send_cmd(dev->sk, OGF_HOST_CTL,
-				OCF_WRITE_LE_HOST_SUPPORTED,
-				WRITE_LE_HOST_SUPPORTED_CP_SIZE, &cp) < 0)
-		return -errno;
-
-	return 0;
-}
-
 static uint8_t generate_service_class(int index)
 {
 	struct dev_info *dev = &devs[index];
@@ -3658,7 +3637,6 @@ static struct btd_adapter_ops hci_ops = {
 	.pincode_reply = hciops_pincode_reply,
 	.confirm_reply = hciops_confirm_reply,
 	.passkey_reply = hciops_passkey_reply,
-	.enable_le = hciops_enable_le,
 	.encrypt_link = hciops_encrypt_link,
 	.set_did = hciops_set_did,
 	.add_uuid = hciops_add_uuid,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cdb97e..0f0cfd5 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1820,12 +1820,6 @@ static int mgmt_passkey_reply(int index, bdaddr_t *bdaddr, uint32_t passkey)
 	return -ENOSYS;
 }
 
-static int mgmt_enable_le(int index)
-{
-	DBG("index %d", index);
-	return -ENOSYS;
-}
-
 static int mgmt_encrypt_link(int index, bdaddr_t *dst, bt_hci_result_t cb,
 							gpointer user_data)
 {
@@ -2053,7 +2047,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.pincode_reply = mgmt_pincode_reply,
 	.confirm_reply = mgmt_confirm_reply,
 	.passkey_reply = mgmt_passkey_reply,
-	.enable_le = mgmt_enable_le,
 	.encrypt_link = mgmt_encrypt_link,
 	.set_did = mgmt_set_did,
 	.add_uuid = mgmt_add_uuid,
diff --git a/src/adapter.c b/src/adapter.c
index 4c88a0e..eb37580 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2274,9 +2274,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->mode = MODE_CONNECTABLE;
 	adapter->off_timer = 0;
 
-	if (main_opts.le)
-		adapter_ops->enable_le(adapter->dev_id);
-
 	adapter_ops->set_name(adapter->dev_id, adapter->name);
 
 	if (read_local_class(&adapter->bdaddr, cls) < 0) {
diff --git a/src/adapter.h b/src/adapter.h
index 687275a..f1f546c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -203,7 +203,6 @@ struct btd_adapter_ops {
 							size_t pin_len);
 	int (*confirm_reply) (int index, bdaddr_t *bdaddr, gboolean success);
 	int (*passkey_reply) (int index, bdaddr_t *bdaddr, uint32_t passkey);
-	int (*enable_le) (int index);
 	int (*encrypt_link) (int index, bdaddr_t *bdaddr, bt_hci_result_t cb,
 							gpointer user_data);
 	int (*set_did) (int index, uint16_t vendor, uint16_t product,
diff --git a/src/attrib-server.c b/src/attrib-server.c
index c02d575..0bda1e3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1094,9 +1094,6 @@ int attrib_server_init(void)
 	if (!register_core_services())
 		goto failed;
 
-	if (!main_opts.le)
-		return 0;
-
 	/* LE socket */
 	le_io = bt_io_listen(BT_IO_L2CAP, NULL, confirm_event,
 					&le_io, NULL, &gerr,
diff --git a/src/hcid.h b/src/hcid.h
index ea038e9..ef25c79 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -38,7 +38,6 @@ struct main_opts {
 	gboolean	name_resolv;
 	gboolean	debug_keys;
 	gboolean	attrib_server;
-	gboolean	le;
 
 	uint8_t		mode;
 	uint8_t		discov_interval;
diff --git a/src/main.c b/src/main.c
index b161a98..7fecc5a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -217,13 +217,6 @@ static void parse_config(GKeyFile *config)
 	else
 		main_opts.attrib_server = boolean;
 
-	boolean = g_key_file_get_boolean(config, "General",
-						"EnableLE", &err);
-	if (err)
-		g_clear_error(&err);
-	else
-		main_opts.le = boolean;
-
 	main_opts.link_mode = HCI_LM_ACCEPT;
 
 	main_opts.link_policy = HCI_LP_RSWITCH | HCI_LP_SNIFF |
diff --git a/src/main.conf b/src/main.conf
index 8cd132f..a9e2060 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -56,11 +56,6 @@ NameResolving = true
 # that they were created for.
 DebugKeys = false
 
-# Enable Low Energy support if the dongle supports. Default is false.
-# Enable/Disable interleave discovery and attribute server over LE.
-EnableLE = false
-
 # Enable the GATT Attribute Server. Default is false, because it is only
-# useful for testing. Attribute server is not enabled over LE if EnableLE
-# is false.
+# useful for testing.
 AttributeServer = false
-- 
1.7.6

