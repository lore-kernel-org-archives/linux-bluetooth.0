Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7E2C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4524B60F93
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Aug 2021 13:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhHINCx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Aug 2021 09:02:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32986 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhHINCw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Aug 2021 09:02:52 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 179D1wGH2026755, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 179D1wGH2026755
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 9 Aug 2021 21:01:58 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 9 Aug 2021 21:01:57 +0800
Received: from localhost (172.21.132.185) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 9 Aug 2021
 21:01:56 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <matthias.bgg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <alex_lu@realsil.com.cn>, <hildawu@realtek.com>,
        <kidman@realtek.com>, <apusaka@chromium.org>,
        <abhishekpandit@chromium.org>, <josephsih@chromium.org>,
        <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Remove WAKEUP_DISABLE and add WAKEUP_AUTOSUSPEND  for Realtek devices
Date:   Mon, 9 Aug 2021 21:01:52 +0800
Message-ID: <20210809130152.12528-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.185]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2021 12:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvOSCkV6TIIDA3OjA0OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/09/2021 12:47:36
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165471 [Aug 09 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: max.chou@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/09/2021 12:50:00
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

For the commit of 9e45524a011107a73bc2cdde8370c61e82e93a4d, wakeup is
always disabled for Realtek devices. However, there's the capability
for Realtek devices to apply USB wake-up.

In this commit, remove WAKEUP_DISABLE feature for Realtek devices.
If users would switch wake-up, they should access
"/sys/bus/usb/.../power/wakeup"

In this commit, it also adds the feature as WAKEUP_AUTOSUSPEND
for Realtek devices because it should set do_remote_wakeup on autosuspend.

Signed-off-by: Max Chou <max.chou@realtek.com>
Tested-by: Hilda Wu <hildawu@realtek.com>
Reviewed-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
 drivers/bluetooth/btusb.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 488f110e17e2..73a835bf37f7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -527,7 +527,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_OOB_WAKE_ENABLED	11
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
-#define BTUSB_WAKEUP_DISABLE	14
+#define BTUSB_WAKEUP_AUTOSUSPEND	14
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1349,13 +1349,6 @@ static int btusb_open(struct hci_dev *hdev)
 
 	data->intf->needs_remote_wakeup = 1;
 
-	/* Disable device remote wakeup when host is suspended
-	 * For Realtek chips, global suspend without
-	 * SET_FEATURE (DEVICE_REMOTE_WAKEUP) can save more power in device.
-	 */
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
-		device_wakeup_disable(&data->udev->dev);
-
 	if (test_and_set_bit(BTUSB_INTR_RUNNING, &data->flags))
 		goto done;
 
@@ -1422,7 +1415,7 @@ static int btusb_close(struct hci_dev *hdev)
 	data->intf->needs_remote_wakeup = 0;
 
 	/* Enable remote wake up for auto-suspend */
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags))
+	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
 		data->intf->needs_remote_wakeup = 1;
 
 	usb_autopm_put_interface(data->intf);
@@ -3877,11 +3870,8 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
 
-		/* Realtek devices lose their updated firmware over global
-		 * suspend that means host doesn't send SET_FEATURE
-		 * (DEVICE_REMOTE_WAKEUP)
-		 */
-		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		/* Realtek devices need to set remote wakeup on auto-suspend */
+		set_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags);
 	}
 
 	if (!reset)
@@ -4056,12 +4046,15 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	 * Actually, it depends on whether the usb host sends
 	 * set feature (enable wakeup) or not.
 	 */
-	if (test_bit(BTUSB_WAKEUP_DISABLE, &data->flags)) {
+	if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags)) {
 		if (PMSG_IS_AUTO(message) &&
 		    device_can_wakeup(&data->udev->dev))
 			data->udev->do_remote_wakeup = 1;
-		else if (!PMSG_IS_AUTO(message))
+		else if (!PMSG_IS_AUTO(message) &&
+			 !device_may_wakeup(&data->udev->dev)) {
+			data->udev->do_remote_wakeup = 0;
 			data->udev->reset_resume = 1;
+		}
 	}
 
 	return 0;
-- 
2.17.1

