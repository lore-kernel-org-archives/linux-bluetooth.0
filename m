Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/7] android/bluetooth: Add helper for finding device with android address
Date: Mon, 23 Jun 2014 16:28:28 +0200
Message-Id: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 67 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index fc5d529..d42fe8c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -477,6 +477,24 @@ static struct device *get_device(const bdaddr_t *bdaddr, uint8_t type)
 	return dev;
 }
 
+static struct device *find_device_android(const uint8_t *addr)
+{
+	bdaddr_t bdaddr;
+
+	android2bdaddr(addr, &bdaddr);
+
+	return find_device(&bdaddr);
+}
+
+static struct device *get_device_android(const uint8_t *addr)
+{
+	bdaddr_t bdaddr;
+
+	android2bdaddr(addr, &bdaddr);
+
+	return get_device(&bdaddr, BDADDR_BREDR);
+}
+
 static  void send_adapter_property(uint8_t type, uint16_t len, const void *val)
 {
 	uint8_t buf[BASELEN_PROP_CHANGED + len];
@@ -3865,13 +3883,11 @@ static void handle_create_bond_cmd(const void *buf, uint16_t len)
 	uint8_t status;
 	struct mgmt_cp_pair_device cp;
 
-	cp.io_cap = DEFAULT_IO_CAPABILITY;
-	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
-
-	/* type is used only as fallback when device is not in cache */
-	dev = get_device(&cp.addr.bdaddr, BDADDR_BREDR);
+	dev = get_device_android(cmd->bdaddr);
 
+	cp.io_cap = DEFAULT_IO_CAPABILITY;
 	cp.addr.type = select_device_bearer(dev);
+	bacpy(&cp.addr.bdaddr, &dev->bdaddr);
 
 	if (device_is_paired(dev, cp.addr.type)) {
 		status = HAL_STATUS_FAILED;
@@ -3901,15 +3917,14 @@ static void handle_cancel_bond_cmd(const void *buf, uint16_t len)
 	struct device *dev;
 	uint8_t status;
 
-	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
-
-	dev = find_device(&cp.bdaddr);
+	dev = find_device_android(cmd->bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
 	cp.type = select_device_bearer(dev);
+	bacpy(&cp.bdaddr, &dev->bdaddr);
 
 	if (mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE,
 					adapter.index, sizeof(cp), &cp,
@@ -3951,15 +3966,15 @@ static void handle_remove_bond_cmd(const void *buf, uint16_t len)
 	struct device *dev;
 	uint8_t status;
 
-	cp.disconnect = 1;
-	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
-
-	dev = find_device(&cp.addr.bdaddr);
+	dev = find_device_android(cmd->bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
 
+	cp.disconnect = 1;
+	bacpy(&cp.addr.bdaddr, &dev->bdaddr);
+
 	if (dev->le_paired) {
 		cp.addr.type = dev->bdaddr_type;
 
@@ -4098,24 +4113,27 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 static void handle_ssp_reply_cmd(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_ssp_reply *cmd = buf;
-	bdaddr_t bdaddr;
+	struct device *dev;
 	uint8_t status;
 	char addr[18];
 
 	/* TODO should parameters sanity be verified here? */
 
-	android2bdaddr(cmd->bdaddr, &bdaddr);
-	ba2str(&bdaddr, addr);
+	dev = find_device_android(cmd->bdaddr);
+	if (!dev)
+		return;
+
+	ba2str(&dev->bdaddr, addr);
 
 	DBG("%s variant %u accept %u", addr, cmd->ssp_variant, cmd->accept);
 
 	switch (cmd->ssp_variant) {
 	case HAL_SSP_VARIANT_CONFIRM:
 	case HAL_SSP_VARIANT_CONSENT:
-		status = user_confirm_reply(&bdaddr, cmd->accept);
+		status = user_confirm_reply(&dev->bdaddr, cmd->accept);
 		break;
 	case HAL_SSP_VARIANT_ENTRY:
-		status = user_passkey_reply(&bdaddr, cmd->accept,
+		status = user_passkey_reply(&dev->bdaddr, cmd->accept,
 								cmd->passkey);
 		break;
 	case HAL_SSP_VARIANT_NOTIF:
@@ -4355,11 +4373,8 @@ static void handle_get_remote_device_props_cmd(const void *buf, uint16_t len)
 	const struct hal_cmd_get_remote_device_props *cmd = buf;
 	struct device *dev;
 	uint8_t status;
-	bdaddr_t addr;
-
-	android2bdaddr(cmd->bdaddr, &addr);
 
-	dev = find_device(&addr);
+	dev = find_device_android(cmd->bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_INVALID;
 		goto failed;
@@ -4379,11 +4394,8 @@ static void handle_get_remote_device_prop_cmd(const void *buf, uint16_t len)
 	const struct hal_cmd_get_remote_device_prop *cmd = buf;
 	struct device *dev;
 	uint8_t status;
-	bdaddr_t addr;
-
-	android2bdaddr(cmd->bdaddr, &addr);
 
-	dev = find_device(&addr);
+	dev = find_device_android(cmd->bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_INVALID;
 		goto failed;
@@ -4461,7 +4473,6 @@ static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
 	const struct hal_cmd_set_remote_device_prop *cmd = buf;
 	struct device *dev;
 	uint8_t status;
-	bdaddr_t addr;
 
 	if (len != sizeof(*cmd) + cmd->len) {
 		error("Invalid set remote device prop cmd (0x%x), terminating",
@@ -4470,9 +4481,7 @@ static void handle_set_remote_device_prop_cmd(const void *buf, uint16_t len)
 		return;
 	}
 
-	android2bdaddr(cmd->bdaddr, &addr);
-
-	dev = find_device(&addr);
+	dev = find_device_android(cmd->bdaddr);
 	if (!dev) {
 		status = HAL_STATUS_INVALID;
 		goto failed;
-- 
1.9.3

