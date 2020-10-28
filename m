Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343C8C56201
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1F224743
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgJ1V7T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:59:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39462 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgJ1V57 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:57:59 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 09S2axIW3006266, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 09S2axIW3006266
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Oct 2020 10:36:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.34) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 28 Oct 2020 10:36:59 +0800
Received: from localhost.localdomain (172.21.132.186) by
 RTEXMBS03.realtek.com.tw (172.21.6.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 28 Oct 2020 10:36:58 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <matthias.bgg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <kidman@realtek.com>,
        <hildawu@realtek.com>, <alex_lu@realsil.com.cn>,
        <abhishekpandit@chromium.org>, <josephsih@chromium.org>,
        <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btusb: Add more IDs to usb_device_id table for Realtek RTL8822CE
Date:   Wed, 28 Oct 2020 10:36:53 +0800
Message-ID: <20201028023653.2760-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.186]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMBS03.realtek.com.tw (172.21.6.34)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

Add more IDs to usb_device_id table for Realtek
RTL8822CE and also support the wideband speech capability.

Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btusb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1005b6e8ff74..4a1f877616d6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -425,8 +425,22 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
 
 	/* Additional Realtek 8822CE Bluetooth devices */
-	{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK },
-	{ USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x04ca, 0x4005), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x04c5, 0x161f), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0b05, 0x18ef), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3548), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3549), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3553), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3555), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x2ff8, 0x3051), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
-- 
2.17.1

