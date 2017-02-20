Return-Path: <larry.finger@gmail.com>
Sender: Larry Finger <larry.finger@gmail.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH] bluetooth: btrtl: Change message for missing config file
Date: Sun, 19 Feb 2017 20:04:57 -0600
Message-Id: <20170220020457.577-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The message concerning missing config files for 8723b, 8821a, and
8761a should have been issued with BT_INFO() rather than BT_ERR() as
this condition is not fatal. After looking at that code, I have
reworked the logic to log such messages only if the device needs such a
config file. At the moment, only the 8822b fits that description.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Acked-by: 陆朱伟 <alex_lu@realsil.com.cn>
---
 drivers/bluetooth/btrtl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index fc9b257..8279094 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -275,11 +275,8 @@ static int rtl_load_config(struct hci_dev *hdev, const char *name, u8 **buff)
 
 	BT_INFO("%s: rtl: loading %s", hdev->name, name);
 	ret = request_firmware(&fw, name, &hdev->dev);
-	if (ret < 0) {
-		BT_ERR("%s: Failed to load %s", hdev->name, name);
+	if (ret < 0)
 		return ret;
-	}
-
 	ret = fw->size;
 	*buff = kmemdup(fw->data, ret, GFP_KERNEL);
 
@@ -331,6 +328,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
 	u8 *cfg_buff = NULL;
 	u8 *tbuff;
 	char *cfg_name = NULL;
+	bool config_needed = false;
 
 	switch (lmp_subver) {
 	case RTL_ROM_LMP_8723B:
@@ -344,6 +342,7 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
 		break;
 	case RTL_ROM_LMP_8822B:
 		cfg_name = "rtl_bt/rtl8822b_config.bin";
+		config_needed = true;
 		break;
 	default:
 		BT_ERR("%s: rtl: no config according to lmp_subver %04x",
@@ -353,8 +352,12 @@ static int btrtl_setup_rtl8723b(struct hci_dev *hdev, u16 lmp_subver,
 
 	if (cfg_name) {
 		cfg_sz = rtl_load_config(hdev, cfg_name, &cfg_buff);
-		if (cfg_sz < 0)
+		if (cfg_sz < 0) {
 			cfg_sz = 0;
+			if (config_needed)
+				BT_ERR("Necessary config file %s not found\n",
+				       cfg_name);
+		}
 	} else
 		cfg_sz = 0;
 
-- 
2.10.2
