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
Subject: [PATCH v4 05/10] Bluetooth: btrtl: add support for the RTL8723BS and RTL8723DS chips
Date: Thu,  2 Aug 2018 16:57:16 +0200
Message-Id: <20180802145721.31390-6-hdegoede@redhat.com>
In-Reply-To: <20180802145721.31390-1-hdegoede@redhat.com>
References: <20180802145721.31390-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

The Realtek RTL8723BS and RTL8723DS chipsets are SDIO wifi chips. They
also contain a Bluetooth module which is connected via UART to the host.

Realtek's userspace initialization tool (rtk_hciattach) differentiates
these two via the HCI version and revision returned by the
HCI_OP_READ_LOCAL_VERSION command.
Additionally we apply these checks only the for UART devices. Everything
else is assumed to be a "RTL8723B" which was originally supported by the
driver (communicating via USB).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jeremy Cline <jeremy@jcline.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2 (Hans de Goede)
-Fix some minor style issues / checkpatch warnings
---
 drivers/bluetooth/btrtl.c | 51 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 75d6acb3ee82..fa9fd60e93aa 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -38,6 +38,8 @@
 
 #define IC_MATCH_FL_LMPSUBV	(1 << 0)
 #define IC_MATCH_FL_HCIREV	(1 << 1)
+#define IC_MATCH_FL_HCIVER	(1 << 2)
+#define IC_MATCH_FL_HCIBUS	(1 << 3)
 #define IC_INFO(lmps, hcir) \
 	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV, \
 	.lmp_subver = (lmps), \
@@ -47,6 +49,8 @@ struct id_table {
 	__u16 match_flags;
 	__u16 lmp_subver;
 	__u16 hci_rev;
+	__u8 hci_ver;
+	__u8 hci_bus;
 	bool config_needed;
 	bool has_rom_version;
 	char *fw_name;
@@ -75,6 +79,18 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
 	  .cfg_name = NULL },
 
+	/* 8723BS */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
+			 IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8723B,
+	  .hci_rev = 0xb,
+	  .hci_ver = 6,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723bs_config.bin" },
+
 	/* 8723B */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb),
 	  .config_needed = false,
@@ -89,6 +105,18 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723d_config.bin" },
 
+	/* 8723DS */
+	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
+			 IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS,
+	  .lmp_subver = RTL_ROM_LMP_8723B,
+	  .hci_rev = 0xd,
+	  .hci_ver = 8,
+	  .hci_bus = HCI_UART,
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8723ds_config.bin" },
+
 	/* 8821A */
 	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa),
 	  .config_needed = false,
@@ -118,7 +146,8 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8822b_config.bin" },
 	};
 
-static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev)
+static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev,
+					     u8 hci_ver, u8 hci_bus)
 {
 	int i;
 
@@ -129,6 +158,12 @@ static const struct id_table *btrtl_match_ic(u16 lmp_subver, u16 hci_rev)
 		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIREV) &&
 		    (ic_id_table[i].hci_rev != hci_rev))
 			continue;
+		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIVER) &&
+		    (ic_id_table[i].hci_ver != hci_ver))
+			continue;
+		if ((ic_id_table[i].match_flags & IC_MATCH_FL_HCIBUS) &&
+		    (ic_id_table[i].hci_bus != hci_bus))
+			continue;
 
 		break;
 	}
@@ -478,6 +513,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
 	u16 hci_rev, lmp_subver;
+	u8 hci_ver;
 	int ret;
 
 	btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
@@ -497,14 +533,17 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev)
 		     resp->hci_ver, resp->hci_rev,
 		     resp->lmp_ver, resp->lmp_subver);
 
+	hci_ver = resp->hci_ver;
 	hci_rev = le16_to_cpu(resp->hci_rev);
 	lmp_subver = le16_to_cpu(resp->lmp_subver);
 	kfree_skb(skb);
 
-	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev);
+	btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
+					    hdev->bus);
+
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_err(hdev, "unknown IC info, lmp subver %04x, hci rev %04x\n",
-			    lmp_subver, hci_rev);
+		rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
+			    lmp_subver, hci_rev, hci_ver);
 		ret = -EINVAL;
 		goto err_free;
 	}
@@ -703,6 +742,10 @@ MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
-- 
2.18.0
