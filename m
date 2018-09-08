Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Alex Lu <alex_lu@realsil.com.cn>,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] Bluetooth: btrtl: Add support for RTL8822C with USB interface
Date: Sat,  8 Sep 2018 12:05:59 -0500
Message-Id: <20180908170559.11070-1-Larry.Finger@lwfinger.net>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alex Lu <alex_lu@realsil.com.cn>

This device is included in the RTL8822CU combination wifi and BT part,
as well as the BT part of the RTL8822CE.
The necessary firmware has been submitted to the linux-firmware
project.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/bluetooth/btrtl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 7f9ea8e4c1b2..0d6a7d9ce18d 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -138,6 +138,13 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
+	/* 8822C with USB interface */
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8822cu_config" },
+
 	/* 8822B */
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb),
 	  .config_needed = true,
@@ -228,6 +235,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 		{ RTL_ROM_LMP_8822B, 8 },
 		{ RTL_ROM_LMP_8723B, 9 },	/* 8723D */
 		{ RTL_ROM_LMP_8821A, 10 },	/* 8821C */
+		{ RTL_ROM_LMP_8822B, 13 },	/* 8822C */
 	};
 
 	min_size = sizeof(struct rtl_epatch_header) + sizeof(extension_sig) + 3;
-- 
2.18.0
