Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>,
	Ilya Faenson <ifaenson@broadcom.com>
Subject: [PATCH v3 4/5] Support the BCM4354 Bluetooth UART device
Date: Wed, 17 Jun 2015 11:42:46 -0400
Message-ID: <1434555767-18234-5-git-send-email-ifaenson@broadcom.com>
In-Reply-To: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
References: <1434555767-18234-1-git-send-email-ifaenson@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Support the BCM4354 chip and introduce vendor specific command
parameter definitions.

Signed-off-by: Ilya Faenson <ifaenson@broadcom.com>
---
 drivers/bluetooth/btbcm.c |  2 ++
 drivers/bluetooth/btbcm.h | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 8e2f6b6..1e1a432 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -243,6 +243,7 @@ static const struct {
 } bcm_uart_subver_table[] = {
 	{ 0x410e, "BCM43341B0"	},	/* 002.001.014 */
 	{ 0x4406, "BCM4324B3"	},	/* 002.004.006 */
+	{ 0x610c, "BCM4354"	},	/* 003.001.012 */
 	{ }
 };
 
@@ -279,6 +280,7 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 
 	switch ((rev & 0xf000) >> 12) {
 	case 0:
+	case 1:
 	case 3:
 		for (i = 0; bcm_uart_subver_table[i].name; i++) {
 			if (subver == bcm_uart_subver_table[i].subver) {
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 02f5f96..d9e6b41 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -33,6 +33,37 @@ struct bcm_write_uart_clock_setting {
 	__u8 type;
 } __packed;
 
+struct bcm_set_sleep_mode {
+	__u8 sleep_mode;
+	__u8 idle_host;
+	__u8 idle_dev;
+	__u8 bt_wake_active;
+	__u8 host_wake_active;
+	__u8 allow_host_sleep;
+	__u8 combine_modes;
+	__u8 tristate_control;
+	__u8 usb_auto_sleep;
+	__u8 usb_resume_timeout;
+	__u8 pulsed_host_wake;
+	__u8 break_to_host;
+} __packed;
+
+struct bcm_set_pcm_int_params {
+	__u8 routing;
+	__u8 rate;
+	__u8 frame_sync;
+	__u8 sync_mode;
+	__u8 clock_mode;
+} __packed;
+
+struct bcm_set_pcm_format_params {
+	__u8 lsb_first;
+	__u8 fill_value;
+	__u8 fill_method;
+	__u8 fill_num;
+	__u8 right_justify;
+} __packed;
+
 #if IS_ENABLED(CONFIG_BT_BCM)
 
 int btbcm_check_bdaddr(struct hci_dev *hdev);
-- 
1.9.1
