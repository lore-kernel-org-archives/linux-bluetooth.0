Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67871C43462
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 03:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42DED6146D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 03:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240195AbhDWDx0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 23:53:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41284 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbhDWDxY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 23:53:24 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13N3qdBrB021907, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13N3qdBrB021907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 11:52:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 11:52:39 +0800
Received: from localhost.localdomain (172.21.132.99) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 11:52:37 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <apusaka@chromium.org>, <tientzu@chromium.org>,
        <max.chou@realtek.com>, <alex_lu@realsil.com.cn>,
        <kidman@realtek.com>
Subject: [PATCH v3 2/2] Bluetooth: hci_h5: Add flag for keep power during suspend/resume
Date:   Fri, 23 Apr 2021 11:52:29 +0800
Message-ID: <20210423035229.27513-3-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423035229.27513-1-hildawu@realtek.com>
References: <20210423035229.27513-1-hildawu@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.99]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjMgpFekyCAwMToxMjowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 03:40:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hildawu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 03:44:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 03:40:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: hildawu@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 03:44:00
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: hildawu <hildawu@realtek.com>

RTL8822C and RTL8852A devices support BT wakeup Host. Add a flag
for these specific devices did not power off during suspend and resume.
By this change, if the Host support that received BT device signal then
it can wake Host up.

Signed-off-by: hildawu <hildawu@realtek.com>
---
Changed in v3:
- Reworked to use UART flag, refer to Maintainer's suggestion.
- Split into two patches for different purpose.

Changes in v2:
- Add the missing struct member
- Modify title length
---
---
 drivers/bluetooth/hci_h5.c    | 34 ++++++++++++++++++++++++----------
 drivers/bluetooth/hci_ldisc.c |  3 ++-
 drivers/bluetooth/hci_uart.h  |  1 +
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 27e96681d583..9cacc4cdc928 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -911,6 +911,15 @@ static int h5_btrtl_setup(struct h5 *h5)
 	 */
 	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
 
+	switch (btrtl_dev->project_id) {
+	case CHIP_ID_8822C:
+	case CHIP_ID_8852A:
+		set_bit(HCI_UART_WAKEUP_ENABLE, &h5->hu->hdev_flags);
+		break;
+	default:
+		break;
+	}
+
 out_free:
 	btrtl_free(btrtl_dev);
 
@@ -945,8 +954,11 @@ static void h5_btrtl_close(struct h5 *h5)
 static int h5_btrtl_suspend(struct h5 *h5)
 {
 	serdev_device_set_flow_control(h5->hu->serdev, false);
-	gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
-	gpiod_set_value_cansleep(h5->enable_gpio, 0);
+
+	if (!test_bit(HCI_UART_WAKEUP_ENABLE, &h5->hu->hdev_flags)) {
+		gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
+		gpiod_set_value_cansleep(h5->enable_gpio, 0);
+	}
 	return 0;
 }
 
@@ -972,17 +984,19 @@ static void h5_btrtl_reprobe_worker(struct work_struct *work)
 
 static int h5_btrtl_resume(struct h5 *h5)
 {
-	struct h5_btrtl_reprobe *reprobe;
+	if (!test_bit(HCI_UART_WAKEUP_ENABLE, &h5->hu->hdev_flags)) {
+		struct h5_btrtl_reprobe *reprobe;
 
-	reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
-	if (!reprobe)
-		return -ENOMEM;
+		reprobe = kzalloc(sizeof(*reprobe), GFP_KERNEL);
+		if (!reprobe)
+			return -ENOMEM;
 
-	__module_get(THIS_MODULE);
+		__module_get(THIS_MODULE);
 
-	INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
-	reprobe->dev = get_device(&h5->hu->serdev->dev);
-	queue_work(system_long_wq, &reprobe->work);
+		INIT_WORK(&reprobe->work, h5_btrtl_reprobe_worker);
+		reprobe->dev = get_device(&h5->hu->serdev->dev);
+		queue_work(system_long_wq, &reprobe->work);
+	}
 	return 0;
 }
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 637c5b8c2aa1..3a1038e9dc6a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -719,7 +719,8 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 				    BIT(HCI_UART_CREATE_AMP) |
 				    BIT(HCI_UART_INIT_PENDING) |
 				    BIT(HCI_UART_EXT_CONFIG) |
-				    BIT(HCI_UART_VND_DETECT);
+				    BIT(HCI_UART_VND_DETECT) |
+				    BIT(HCI_UART_WAKEUP_ENABLE);
 
 	if (flags & ~valid_flags)
 		return -EINVAL;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 4e039d7a16f8..25f5e5c7544c 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -41,6 +41,7 @@
 #define HCI_UART_INIT_PENDING	3
 #define HCI_UART_EXT_CONFIG	4
 #define HCI_UART_VND_DETECT	5
+#define HCI_UART_WAKEUP_ENABLE	6
 
 struct hci_uart;
 struct serdev_device;
-- 
2.17.1

