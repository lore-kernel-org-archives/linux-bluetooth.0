Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF9AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 08:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B579233EA
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 08:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbhAHIA7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 03:00:59 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:47103 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbhAHIA7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 03:00:59 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1087xlwJ7020174, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs03.realtek.com.tw[172.21.6.96])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1087xlwJ7020174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 8 Jan 2021 15:59:47 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 8 Jan 2021 15:59:46 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::d4dd:5c6:e3c2:8a2f]) by
 RTEXMBS03.realtek.com.tw ([fe80::d4dd:5c6:e3c2:8a2f%2]) with mapi id
 15.01.2106.006; Fri, 8 Jan 2021 15:59:46 +0800
From:   Max Chou <max.chou@realtek.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Hilda Wu <hildawu@realtek.com>, KidmanLee <kidman@realtek.com>,
        "abhishekpandit@chromium.org" <abhishekpandit@chromium.org>
Subject: RE: [PATCH] Bluetooth: btusb: Add a Kconfig option to disable USB wakeup by default
Thread-Topic: [PATCH] Bluetooth: btusb: Add a Kconfig option to disable USB
 wakeup by default
Thread-Index: AQHW3nio3fON8c/V1E6p96jd8CAkbaodakyw
Date:   Fri, 8 Jan 2021 07:59:46 +0000
Message-ID: <dbef7b41f00a406293c57f561082b9df@realtek.com>
References: <20201230065441.1179-1-max.chou@realtek.com>
In-Reply-To: <20201230065441.1179-1-max.chou@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.163]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

// add Abhishek to CC list



BRs,
Max

-----Original Message-----
From: Max Chou <max.chou@realtek.com> 
Sent: Wednesday, December 30, 2020 2:55 PM
To: marcel@holtmann.org; johan.hedberg@gmail.com; luiz.dentz@gmail.com; matthias.bgg@gmail.com
Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-mediatek@lists.infradead.org; alex_lu@realsil.com.cn; Hilda Wu <hildawu@realtek.com>; KidmanLee <kidman@realtek.com>; Max Chou <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Add a Kconfig option to disable USB wakeup by default

From: Max Chou <max.chou@realtek.com>

For the original commit of 9e45524a011107a73bc2cdde8370c61e82e93a4d,
wakeup is always disabled for Realtek Bluetooth devices.
However, there's the capability for Realtek Bluetooth devices to apply USB wakeup. Otherwise, there's the better power consumption without USB wakeup during suspending.
In this commit, divide the original commit into two parts.
1. Redefine the feature that Realtek devices should be enabled wakeup on auto-suspend as BTUSB_WAKEUP_AUTOSUSPEND.
2. Add a Kconfig option to switch disable_wakeup for Bluetooth USB devices by default as CONFIG_BT_HCIBTUSB_DISABLEWAKEUP.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/Kconfig | 11 +++++++++++  drivers/bluetooth/btusb.c | 41 ++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig index 4e73a531b377..7af10897a248 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -41,6 +41,17 @@ config BT_HCIBTUSB_AUTOSUSPEND
 	  This can be overridden by passing btusb.enable_autosuspend=[y|n]
 	  on the kernel commandline.
 
+config BT_HCIBTUSB_DISABLEWAKEUP
+	bool "Disable USB wakeup for Bluetooth USB devices by default"
+	depends on BT_HCIBTUSB
+	default n
+	help
+	  Say Y here to disable USB wakeup for Bluetooth USB devices by
+	  default.
+
+	  This can be overridden by passing btusb.disable_wakeup=[y|n]
+	  on the kernel commandline.
+
 config BT_HCIBTUSB_BCM
 	bool "Broadcom protocol support"
 	depends on BT_HCIBTUSB
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index b630a1d54c02..5f55111849b5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -30,6 +30,7 @@
 static bool disable_scofix;
 static bool force_scofix;
 static bool enable_autosuspend = IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOSUSPEND);
+static bool disable_wakeup = 
+IS_ENABLED(CONFIG_BT_HCIBTUSB_DISABLEWAKEUP);
 
 static bool reset = true;
 
@@ -505,7 +506,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_OOB_WAKE_ENABLED	11
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
-#define BTUSB_WAKEUP_DISABLE	14
+#define BTUSB_WAKEUP_AUTOSUSPEND	14
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1330,7 +1331,7 @@ static int btusb_open(struct hci_dev *hdev)
 	 * For Realtek chips, global suspend without
 	 * SET_FEATURE (DEVICE_REMOTE_WAKEUP) can save more power in device.
 	 */
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+	if (disable_wakeup)
 		device_wakeup_disable(&data->udev->dev);
 
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags)) @@ -1399,7 +1400,7 @@ static int btusb_close(struct hci_dev *hdev)
 	data->intf->needs_remote_wakeup = 0;
 
 	/* Enable remote wake up for auto-suspend */
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
 		data->intf->needs_remote_wakeup = 1;
 
 	usb_autopm_put_interface(data->intf);
@@ -4257,7 +4258,7 @@ static bool btusb_prevent_wake(struct hci_dev *hdev)  {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+	if (disable_wakeup)
 		return true;
 
 	return !device_may_wakeup(&data->udev->dev);
@@ -4557,11 +4558,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
-		/* Realtek devices lose their updated firmware over global
-		 * suspend that means host doesn't send SET_FEATURE
-		 * (DEVICE_REMOTE_WAKEUP)
-		 */
-		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		/* Realtek devices need to set USB remote wakeup on auto-suspend */
+		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
 	}
 
 	if (!reset)
@@ -4731,17 +4729,29 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 		enable_irq(data->oob_wake_irq);
 	}
 
-	/* For global suspend, Realtek devices lose the loaded fw
-	 * in them. But for autosuspend, firmware should remain.
+	/* For suspend(S3), Realtek devices lose the loaded fw
+	 * if USB wakeup is disabled.
+	 * It can meet better power consumption.
+	 * Otherwise, the fw is alive if USB wakeup is enabled.
+	 * It's able to wake Host up by the paired devices.
+	 * Note that disable_wakeup should be false,
+	 * and device_may_wakeup() should return true.
+	 *
+	 * For autosuspend, firmware should remain.
 	 * Actually, it depends on whether the usb host sends
 	 * set feature (enable wakeup) or not.
 	 */
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
+	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags)) {
 		if (PMSG_IS_AUTO(message) &&
 		    device_can_wakeup(&data->udev->dev))
 			data->udev->do_remote_wakeup = 1;
-		else if (!PMSG_IS_AUTO(message))
-			data->udev->reset_resume = 1;
+		else if (!PMSG_IS_AUTO(message)) {
+			if (disable_wakeup ||
+			    !device_may_wakeup(&data->udev->dev)) {
+				data->udev->do_remote_wakeup = 0;
+				data->udev->reset_resume = 1;
+			}
+		}
 	}
 
 	return 0;
@@ -4865,6 +4875,9 @@ MODULE_PARM_DESC(force_scofix, "Force fixup of wrong SCO buffers size");  module_param(enable_autosuspend, bool, 0644);  MODULE_PARM_DESC(enable_autosuspend, "Enable USB autosuspend by default");
 
+module_param(disable_wakeup, bool, 0644); 
+MODULE_PARM_DESC(disable_wakeup, "Disable USB wakeup by default");
+
 module_param(reset, bool, 0644);
 MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
 
--
2.17.1

