Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Alex Lu <alex_lu@realsil.com.cn>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/2] Bluetooth: btrtl: Add RTL8723D and RTL8821C devices
Date: Sun, 11 Feb 2018 12:24:33 -0600
Message-Id: <20180211182433.591-3-Larry.Finger@lwfinger.net>
In-Reply-To: <20180211182433.591-1-Larry.Finger@lwfinger.net>
References: <20180211182433.591-1-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alex Lu <alex_lu@realsil.com.cn>

The Bluetooth parts of RTL8723D and RTL8723B share the same lmp
subversion, thus we need to check both lmp subversion and hci revision
to distinguish the two. The same situation is true for RTL8821A and
RTL8821C. Accordingly, the selection code is revised.

To improve maintainability, a new id_table struct is defined, and an
array of such structs is constructed. Adding a new device can thus be
as simple as adding another value to the table.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btrtl.c | 118 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 85 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 6e2ad748abba..7d1ec76b25a8 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -35,6 +35,60 @@
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
 
+#define IC_MATCH_FL_LMPSUBV	(1 << 0)
+#define IC_MATCH_FL_HCIREV	(1 << 1)
+#define IC_INFO(lmps, hcir) \
+	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV, \
+	.lmp_subver = (lmps), \
+	.hci_rev = (hcir)
+
+struct id_table {
+	__u16 match_flags;
+	__u16 lmp_subver;
+	__u16 hci_rev;
+	bool config_needed;
+	char *fw_name;
+	char *cfg_name;
+};
+
+static const struct id_table ic_id_table[] = {
+	/* 8723B */
+	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb),
+	  .config_needed = false,
+	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723b_config.bin" },
+
+	/* 8723D */
+	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd),
+	  .config_needed = true,
+	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723d_config.bin" },
+
+	/* 8821A */
+	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa),
+	  .config_needed = false,
+	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8821a_config.bin" },
+
+	/* 8821C */
+	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc),
+	  .config_needed = false,
+	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8821c_config.bin" },
+
+	/* 8761A */
+	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_8761A, 0x0,
+	  .config_needed = false,
+	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8761a_config.bin" },
+
+	/* 8822B */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb),
+	  .config_needed = true,
+	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822b_config.bin" },
+	};
+
 static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 {
 	struct rtl_rom_version_evt *rom_version;
@@ -64,9 +118,9 @@ static int rtl_read_rom_version(struct hci_dev *hdev, u8 *version)
 	return 0;
 }
 
-static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
-				   const struct firmware *fw,
-				   unsigned char **_buf)
+static int rtlbt_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
+				const struct firmware *fw,
+				unsigned char **_buf)
 {
 	const u8 extension_sig[] = { 0x51, 0x04, 0xfd, 0x77 };
 	struct rtl_epatch_header *epatch_info;
@@ -88,6 +142,8 @@ static int rtl8723b_parse_firmware(struct hci_dev *hdev, u16 lmp_subver,
 		{ RTL_ROM_LMP_8821A, 2 },
 		{ RTL_ROM_LMP_8761A, 3 },
 		{ RTL_ROM_LMP_8822B, 8 },
+		{ RTL_ROM_LMP_8723B, 9 }, /* 8723D */
+		{ RTL_ROM_LMP_8821A, 10 }, /* 8821C */
 	};
 
 	ret = rtl_read_rom_version(hdev, &rom_version);
@@ -320,8 +376,8 @@ static int btrtl_setup_rtl8723a(struct hci_dev *hdev)
 	return ret;
 }
 
-static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
-				const char *fw_name)
+static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 hci_rev,
+				u16 lmp_subver)
 {
 	unsigned char *fw_data = NULL;
 	const struct firmware *fw;
@@ -330,39 +386,40 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
 	u8 *cfg_buff = NULL;
 	u8 *tbuff;
 	char *cfg_name = NULL;
-	bool config_needed = false;
+	char *fw_name = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ic_id_table); i++) {
+		if ((ic_id_table[i].match_flags & IC_MATCH_FL_LMPSUBV) &&
+		    (ic_id_table[i].lmp_subver != lmp_subver))
+			continue;
+		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIREV) &&
+		    (ic_id_table[i].hci_rev != hci_rev))
+			continue;
 
-	switch (lmp_subver) {
-	case RTL_ROM_LMP_8723B:
-		cfg_name = "rtl_bt/rtl8723b_config.bin";
-		break;
-	case RTL_ROM_LMP_8821A:
-		cfg_name = "rtl_bt/rtl8821a_config.bin";
-		break;
-	case RTL_ROM_LMP_8761A:
-		cfg_name = "rtl_bt/rtl8761a_config.bin";
-		break;
-	case RTL_ROM_LMP_8822B:
-		cfg_name = "rtl_bt/rtl8822b_config.bin";
-		config_needed = true;
-		break;
-	default:
-		BT_ERR("%s: rtl: no config according to lmp_subver %04x",
-		       hdev->name, lmp_subver);
 		break;
 	}
 
+	if (i >= ARRAY_SIZE(ic_id_table)) {
+		BT_ERR("%s: unknown IC info, lmp subver %04x, hci rev %04x",
+		       hdev->name, lmp_subver, hci_rev);
+		return -EINVAL;
+	}
+
+	cfg_name = ic_id_table[i].cfg_name;
+
 	if (cfg_name) {
 		cfg_sz = rtl_load_config(hdev, cfg_name, &cfg_buff);
 		if (cfg_sz < 0) {
 			cfg_sz = 0;
-			if (config_needed)
+			if (ic_id_table[i].config_needed)
 				BT_ERR("Necessary config file %s not found\n",
 				       cfg_name);
 		}
 	} else
 		cfg_sz = 0;
 
+	fw_name = ic_id_table[i].fw_name;
 	bt_dev_info(hdev, "rtl: loading %s", fw_name);
 	ret = request_firmware(&fw, fw_name, &hdev->dev);
 	if (ret < 0) {
@@ -370,7 +427,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
 		goto err_req_fw;
 	}
 
-	ret = rtl8723b_parse_firmware(hdev, lmp_subver, fw, &fw_data);
+	ret = rtlbt_parse_firmware(hdev, lmp_subver, fw, &fw_data);
 	if (ret < 0)
 		goto out;
 
@@ -430,6 +487,7 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
 	u16 lmp_subver;
+	u16 hci_rev;
 
 	skb = btrtl_read_local_version(hdev);
 	if (IS_ERR(skb))
@@ -442,6 +500,7 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 		    resp->lmp_ver, resp->lmp_subver);
 
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
+	hci_rev = le16_to_cpu(resp->hci_rev);
 	kfree_skb(skb);
 
 	/* Match a set of subver values that correspond to stock firmware,
@@ -455,17 +514,10 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	case RTL_ROM_LMP_3499:
 		return btrtl_setup_rtl8723a(hdev);
 	case RTL_ROM_LMP_8723B:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8723b_fw.bin");
 	case RTL_ROM_LMP_8821A:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8821a_fw.bin");
 	case RTL_ROM_LMP_8761A:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8761a_fw.bin");
 	case RTL_ROM_LMP_8822B:
-		return btrtl_setup_rtl8723b(hdev, lmp_subver,
-					    "rtl_bt/rtl8822b_fw.bin");
+		return btrtl_setup_rtl8723b(hdev, hci_rev, lmp_subver);
 	default:
 		bt_dev_info(hdev, "rtl: assuming no firmware upload needed");
 		return 0;
-- 
2.16.1
