Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: hci_core: return cmd status in __hci_cmd_sync()
Date: Thu,  7 May 2015 16:24:55 +0200
Message-Id: <1431008699-6419-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle command complete event and extract error/status.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c        |  27 +++++-----
 drivers/bluetooth/btintel.c      |  14 +++---
 drivers/bluetooth/btmrvl_main.c  |   2 +-
 drivers/bluetooth/btusb.c        | 104 +++++++++++++++++++++------------------
 drivers/bluetooth/hci_ath.c      |   3 +-
 drivers/bluetooth/hci_ldisc.c    |   2 +-
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_core.c         |  17 +++++--
 8 files changed, 95 insertions(+), 76 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 4bba866..5635d6d 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -38,9 +38,10 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
 	struct sk_buff *skb;
+	u8 status;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Reading device address failed (%d)",
@@ -54,14 +55,15 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 		return -EIO;
 	}
 
-	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (bda->status) {
+	if (status) {
 		BT_ERR("%s: BCM: Device address result failed (%02x)",
-		       hdev->name, bda->status);
+		       hdev->name, status);
 		kfree_skb(skb);
-		return -bt_to_errno(bda->status);
+		return -bt_to_errno(status);
 	}
 
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+
 	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
 	 * with no configured address.
 	 */
@@ -82,7 +84,7 @@ int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	struct sk_buff *skb;
 	int err;
 
-	skb = __hci_cmd_sync(hdev, 0xfc01, 6, bdaddr, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc01, 6, bdaddr, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Change address command failed (%d)",
@@ -112,7 +114,7 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
 	}
 
 	/* Start Download */
-	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc2e, 0, NULL, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Download Minidrv command failed (%d)",
@@ -148,7 +150,7 @@ int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
 		opcode = le16_to_cpu(cmd->opcode);
 
 		skb = __hci_cmd_sync(hdev, opcode, cmd->plen, cmd_param,
-				     HCI_INIT_TIMEOUT);
+				     HCI_INIT_TIMEOUT, NULL);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			BT_ERR("%s: BCM: Patch command %04x failed (%d)",
@@ -171,7 +173,8 @@ static int btbcm_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT,
+			     NULL);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Reset failed (%d)", hdev->name, err);
@@ -187,7 +190,7 @@ static struct sk_buff *btbcm_read_local_version(struct hci_dev *hdev)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: BCM: Reading local version info failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -207,7 +210,7 @@ static struct sk_buff *btbcm_read_verbose_config(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc79, 0, NULL, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: BCM: Read verbose config info failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -227,7 +230,7 @@ static struct sk_buff *btbcm_read_usb_product(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 
-	skb = __hci_cmd_sync(hdev, 0xfc5a, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc5a, 0, NULL, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: BCM: Read USB product info failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 2d43d42..1a17dd3 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -36,9 +36,10 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
 {
 	struct hci_rp_read_bd_addr *bda;
 	struct sk_buff *skb;
+	u8 status;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
 		BT_ERR("%s: Reading Intel device address failed (%d)",
@@ -52,14 +53,15 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
 		return -EIO;
 	}
 
-	bda = (struct hci_rp_read_bd_addr *)skb->data;
-	if (bda->status) {
+	if (status) {
 		BT_ERR("%s: Intel device address result failed (%02x)",
-		       hdev->name, bda->status);
+		       hdev->name, status);
 		kfree_skb(skb);
-		return -bt_to_errno(bda->status);
+		return -bt_to_errno(status);
 	}
 
+	bda = (struct hci_rp_read_bd_addr *)skb->data;
+
 	/* For some Intel based controllers, the default Bluetooth device
 	 * address 00:03:19:9E:8B:00 can be found. These controllers are
 	 * fully operational, but have the danger of duplicate addresses
@@ -82,7 +84,7 @@ int btintel_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	struct sk_buff *skb;
 	int err;
 
-	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc31, 6, bdaddr, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		BT_ERR("%s: Changing Intel device address failed (%d)",
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index de05deb..f9005f3 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -593,7 +593,7 @@ static int btmrvl_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	memcpy(buf + 2, bdaddr, sizeof(bdaddr_t));
 
 	skb = __hci_cmd_sync(hdev, BT_CMD_SET_BDADDR, sizeof(buf), buf,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: changing btmrvl device address failed (%ld)",
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d21f3b4..77c1f8c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1300,7 +1300,7 @@ static struct sk_buff *btusb_read_local_version(struct hci_dev *hdev)
 	struct sk_buff *skb;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: HCI_OP_READ_LOCAL_VERSION failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -1324,7 +1324,7 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
-	skb = __hci_cmd_sync(hdev, 0xfc3b, 1, &val, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc3b, 1, &val, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb))
 		BT_ERR("BCM92035 command failed (%ld)", -PTR_ERR(skb));
 	else
@@ -1403,10 +1403,10 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 {
 	struct rtl_rom_version_evt *rom_version;
 	struct sk_buff *skb;
-	int ret;
+	u8 status;
 
 	/* Read RTL ROM version command */
-	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc6d, 0, NULL, HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Read ROM version failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -1421,14 +1421,13 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 
 	rom_version = (struct rtl_rom_version_evt *)skb->data;
 	BT_INFO("%s: rom_version status=%x version=%x",
-		hdev->name, rom_version->status, rom_version->version);
+		hdev->name, status, rom_version->version);
 
-	ret = rom_version->status;
-	if (ret == 0)
+	if (status == 0)
 		*version = rom_version->version;
 
 	kfree_skb(skb);
-	return ret;
+	return status;
 }
 
 static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
@@ -1587,8 +1586,8 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 		return -ENOMEM;
 
 	for (i = 0; i < frag_num; i++) {
-		struct rtl_download_response *dl_resp;
 		struct sk_buff *skb;
+		u8 status;
 
 		BT_DBG("download fw (%d/%d)", i, frag_num);
 
@@ -1601,7 +1600,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 
 		/* Send download command */
 		skb = __hci_cmd_sync(hdev, 0xfc20, frag_len + 1, dl_cmd,
-				     HCI_INIT_TIMEOUT);
+				     HCI_INIT_TIMEOUT, &status);
 		if (IS_ERR(skb)) {
 			BT_ERR("%s: download fw command failed (%ld)",
 			       hdev->name, PTR_ERR(skb));
@@ -1609,7 +1608,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			goto out;
 		}
 
-		if (skb->len != sizeof(*dl_resp)) {
+		if (skb->len != sizeof(struct rtl_download_response)) {
 			BT_ERR("%s: download fw event length mismatch",
 			       hdev->name);
 			kfree_skb(skb);
@@ -1617,10 +1616,9 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 			goto out;
 		}
 
-		dl_resp = (struct rtl_download_response *)skb->data;
-		if (dl_resp->status != 0) {
+		if (status != 0) {
 			kfree_skb(skb);
-			ret = bt_to_errno(dl_resp->status);
+			ret = bt_to_errno(status);
 			goto out;
 		}
 
@@ -1900,6 +1898,7 @@ static int btusb_setup_intel_patching(struct hci_dev *hdev,
 static int btusb_setup_intel(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
+	u8 status;
 	const struct firmware *fw;
 	const u8 *fw_ptr;
 	int disable_patch;
@@ -1920,7 +1919,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * number of completed commands and allow normal command processing
 	 * from now on.
 	 */
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT,
+			     NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s sending initial HCI reset command failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -1934,7 +1934,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * The returned information are hardware variant and revision plus
 	 * firmware variant, revision and build number.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s reading Intel fw version command failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -1947,14 +1947,15 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		return -EIO;
 	}
 
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
+	if (status) {
 		BT_ERR("%s Intel fw version event failed (%02x)", hdev->name,
-		       ver->status);
+		       status);
 		kfree_skb(skb);
-		return -bt_to_errno(ver->status);
+		return -bt_to_errno(status);
 	}
 
+	ver = (struct intel_version *)skb->data;
+
 	BT_INFO("%s: read Intel version: %02x%02x%02x%02x%02x%02x%02x%02x%02x",
 		hdev->name, ver->hw_platform, ver->hw_variant,
 		ver->hw_revision, ver->fw_variant,  ver->fw_revision,
@@ -1993,7 +1994,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * Only while this mode is enabled, the driver can download the
 	 * firmware patch data and configuration parameters.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_enable, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc11, 2, mfg_enable, HCI_INIT_TIMEOUT,
+			     &status);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s entering Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2001,14 +2003,12 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 		return PTR_ERR(skb);
 	}
 
-	if (skb->data[0]) {
-		u8 evt_status = skb->data[0];
-
+	if (status) {
 		BT_ERR("%s enable Intel manufacturer mode event failed (%02x)",
-		       hdev->name, evt_status);
+		       hdev->name, status);
 		kfree_skb(skb);
 		release_firmware(fw);
-		return -bt_to_errno(evt_status);
+		return -bt_to_errno(status);
 	}
 	kfree_skb(skb);
 
@@ -2052,7 +2052,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	 * with reset and activate the downloaded firmware patches.
 	 */
 	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_activate),
-			     mfg_reset_activate, HCI_INIT_TIMEOUT);
+			     mfg_reset_activate, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2069,7 +2069,7 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 exit_mfg_disable:
 	/* Disable the manufacturer mode without reset */
 	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_disable), mfg_disable,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2089,7 +2089,7 @@ exit_mfg_deactivate:
 	 * deactivate the downloaded firmware patches.
 	 */
 	skb = __hci_cmd_sync(hdev, 0xfc11, sizeof(mfg_reset_deactivate),
-			     mfg_reset_deactivate, HCI_INIT_TIMEOUT);
+			     mfg_reset_deactivate, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s exiting Intel manufacturer mode failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2284,7 +2284,7 @@ static int btusb_intel_secure_send(struct hci_dev *hdev, u8 fragment_type,
 		memcpy(cmd_param + 1, param, fragment_len);
 
 		skb = __hci_cmd_sync(hdev, 0xfc09, fragment_len + 1,
-				     cmd_param, HCI_INIT_TIMEOUT);
+				     cmd_param, HCI_INIT_TIMEOUT, NULL);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
 
@@ -2324,6 +2324,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 					  0x00, 0x08, 0x04, 0x00 };
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct sk_buff *skb;
+	u8 status;
 	struct intel_version *ver;
 	struct intel_boot_params *params;
 	const struct firmware *fw;
@@ -2341,7 +2342,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	 * is in bootloader mode or if it already has operational firmware
 	 * loaded.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc05, 0, NULL, HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Reading Intel version information failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2354,15 +2355,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return -EILSEQ;
 	}
 
-	ver = (struct intel_version *)skb->data;
-	if (ver->status) {
+	if (status) {
 		BT_ERR("%s: Intel version command failure (%02x)",
-		       hdev->name, ver->status);
-		err = -bt_to_errno(ver->status);
+		       hdev->name, status);
+		err = -bt_to_errno(status);
 		kfree_skb(skb);
 		return err;
 	}
 
+	ver = (struct intel_version *)skb->data;
+
 	/* The hardware platform number has a fixed value of 0x37 and
 	 * for now only accept this single value.
 	 */
@@ -2422,7 +2424,7 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Read the secure boot parameters to identify the operating
 	 * details of the bootloader.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc0d, 0, NULL, HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Reading Intel boot parameters failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2435,15 +2437,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		return -EILSEQ;
 	}
 
-	params = (struct intel_boot_params *)skb->data;
-	if (params->status) {
+	if (status) {
 		BT_ERR("%s: Intel boot parameters command failure (%02x)",
-		       hdev->name, params->status);
-		err = -bt_to_errno(params->status);
+		       hdev->name, status);
+		err = -bt_to_errno(status);
 		kfree_skb(skb);
 		return err;
 	}
 
+	params = (struct intel_boot_params *)skb->data;
+
 	BT_INFO("%s: Device revision is %u", hdev->name,
 		le16_to_cpu(params->dev_revid));
 
@@ -2607,7 +2610,7 @@ done:
 	set_bit(BTUSB_BOOTING, &data->flags);
 
 	skb = __hci_cmd_sync(hdev, 0xfc01, sizeof(reset_param), reset_param,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
@@ -2650,11 +2653,12 @@ done:
 static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
 {
 	struct sk_buff *skb;
-	u8 type = 0x00;
+	u8 status, type = 0x00;
 
 	BT_ERR("%s: Hardware error 0x%2.2x", hdev->name, code);
 
-	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT,
+			     NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Reset after hardware error failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2662,7 +2666,7 @@ static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
 	}
 	kfree_skb(skb);
 
-	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc22, 1, &type, HCI_INIT_TIMEOUT, &status);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Retrieving Intel exception info failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
@@ -2675,9 +2679,9 @@ static void btusb_hw_error_intel(struct hci_dev *hdev, u8 code)
 		return;
 	}
 
-	if (skb->data[0] != 0x00) {
+	if (status) {
 		BT_ERR("%s: Exception info command failure (%02x)",
-		       hdev->name, skb->data[0]);
+		       hdev->name, status);
 		kfree_skb(skb);
 		return;
 	}
@@ -2696,7 +2700,7 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
 	 * down or BT radio is turned off, which takes 5 seconds to BT LED
 	 * goes off. This command turns off the BT LED immediately.
 	 */
-	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: turning off Intel device LED failed (%ld)",
@@ -2719,7 +2723,8 @@ static int btusb_set_bdaddr_marvell(struct hci_dev *hdev,
 	buf[1] = sizeof(bdaddr_t);
 	memcpy(buf + 2, bdaddr, sizeof(bdaddr_t));
 
-	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(buf), buf, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(buf), buf, HCI_INIT_TIMEOUT,
+			     NULL);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: changing Marvell device address failed (%ld)",
@@ -2744,7 +2749,8 @@ static int btusb_set_bdaddr_ath3012(struct hci_dev *hdev,
 	buf[3] = sizeof(bdaddr_t);
 	memcpy(buf + 4, bdaddr, sizeof(bdaddr_t));
 
-	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT,
+			     NULL);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		BT_ERR("%s: Change address command failed (%ld)",
diff --git a/drivers/bluetooth/hci_ath.c b/drivers/bluetooth/hci_ath.c
index ec8fa0e..19a8f92 100644
--- a/drivers/bluetooth/hci_ath.c
+++ b/drivers/bluetooth/hci_ath.c
@@ -156,7 +156,8 @@ static int ath_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	buf[3] = sizeof(bdaddr_t);
 	memcpy(buf + 4, bdaddr, sizeof(bdaddr_t));
 
-	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc0b, sizeof(buf), buf, HCI_INIT_TIMEOUT,
+			     NULL);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
 		BT_ERR("%s: Change address command failed (%d)",
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 5c9a73f..2b5d946 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -278,7 +278,7 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		return 0;
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
-			     HCI_INIT_TIMEOUT);
+			     HCI_INIT_TIMEOUT, NULL);
 	if (IS_ERR(skb)) {
 		BT_ERR("%s: Reading local version information failed (%ld)",
 		       hdev->name, PTR_ERR(skb));
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a056c2b..ea02e00 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1282,7 +1282,7 @@ int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
-			       const void *param, u32 timeout);
+			       const void *param, u32 timeout, u8 *status);
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 				  const void *param, u8 event, u32 timeout);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..45f5061 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -94,6 +94,7 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	char buf[32];
 	size_t buf_size = min(count, (sizeof(buf)-1));
 	bool enable;
+	u8 status;
 	int err;
 
 	if (!test_bit(HCI_UP, &hdev->flags))
@@ -112,16 +113,16 @@ static ssize_t dut_mode_write(struct file *file, const char __user *user_buf,
 	hci_req_lock(hdev);
 	if (enable)
 		skb = __hci_cmd_sync(hdev, HCI_OP_ENABLE_DUT_MODE, 0, NULL,
-				     HCI_CMD_TIMEOUT);
+				     HCI_CMD_TIMEOUT, &status);
 	else
 		skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL,
-				     HCI_CMD_TIMEOUT);
+				     HCI_CMD_TIMEOUT, &status);
 	hci_req_unlock(hdev);
 
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	err = -bt_to_errno(skb->data[0]);
+	err = -bt_to_errno(status);
 	kfree_skb(skb);
 
 	if (err < 0)
@@ -232,9 +233,15 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 EXPORT_SYMBOL(__hci_cmd_sync_ev);
 
 struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
-			       const void *param, u32 timeout)
+			       const void *param, u32 timeout, u8 *status)
 {
-	return __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
+	struct sk_buff *skb;
+
+	skb = __hci_cmd_sync_ev(hdev, opcode, plen, param, 0, timeout);
+	if (!IS_ERR(skb) && status)
+		*status = skb->data[0];
+
+	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync);
 
-- 
1.9.1

