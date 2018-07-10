Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v3 5/9] Bluetooth: btrtl: Add support for a config filename postfix
Date: Tue, 10 Jul 2018 10:11:13 +0200
Message-Id: <20180710081117.25078-6-hdegoede@redhat.com>
In-Reply-To: <20180710081117.25078-1-hdegoede@redhat.com>
References: <20180710081117.25078-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The contents of the rtl_bt/rtlXXXX_config.bin file may be board specific
allow the caller of btrtl_initialize to specify a postfix identifying
the board, which if specified will make btrtl_initialize look for
rtl_bt/rtlXXXX_config-<postfix>.bin instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btrtl.c | 32 ++++++++++++++++++++------------
 drivers/bluetooth/btrtl.h |  6 ++++--
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 8dacca64fe41..67ff5b7c2116 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -89,21 +89,21 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723bs_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8723bs_config" },
 
 	/* 8723B */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723b_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8723b_config" },
 
 	/* 8723D */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723d_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8723d_config" },
 
 	/* 8723DS */
 	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
@@ -115,35 +115,35 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723ds_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8723ds_config" },
 
 	/* 8821A */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8821a_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8821a_config" },
 
 	/* 8821C */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8821c_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
 	/* 8761A */
 	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_8761A, 0x0,
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8761a_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
 	/* 8822B */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8822b_config.bin" },
+	  .cfg_name = "rtl_bt/rtl8822b_config" },
 	};
 
 static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
@@ -510,11 +510,13 @@ void btrtl_free(struct btrtl_device_info *btrtl_dev)
 }
 EXPORT_SYMBOL_GPL(btrtl_free);
 
-struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
+struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
+					   const char *postfix)
 {
 	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
+	char cfg_name[40];
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver;
 	int ret;
@@ -568,8 +570,14 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 	}
 
 	if (btrtl_dev->ic_info->cfg_name) {
-		btrtl_dev->cfg_len = rtl_load_file(hdev,
-						   btrtl_dev->ic_info->cfg_name,
+		if (postfix) {
+			snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
+				 btrtl_dev->ic_info->cfg_name, postfix);
+		} else {
+			snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
+				 btrtl_dev->ic_info->cfg_name);
+		}
+		btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
 						   &btrtl_dev->cfg_data);
 		if (btrtl_dev->ic_info->config_needed &&
 		    btrtl_dev->cfg_len <= 0) {
@@ -620,7 +628,7 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	struct btrtl_device_info *btrtl_dev;
 	int ret;
 
-	btrtl_dev = btrtl_initialize(hdev);
+	btrtl_dev = btrtl_initialize(hdev, NULL);
 	if (IS_ERR(btrtl_dev))
 		return PTR_ERR(btrtl_dev);
 
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index 2e7856fa5ac7..1e82ee256d02 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -54,7 +54,8 @@ struct rtl_vendor_config {
 
 #if IS_ENABLED(CONFIG_BT_RTL)
 
-struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev);
+struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
+					   const char *postfix);
 void btrtl_free(struct btrtl_device_info *btrtl_dev);
 int btrtl_download_firmware(struct hci_dev *hdev,
 			    struct btrtl_device_info *btrtl_dev);
@@ -66,7 +67,8 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 
 #else
 
-static inline struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
+static inline struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
+							 const char *postfix)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.17.1
