Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E17C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B167224F9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Jan 2021 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAYImH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Jan 2021 03:42:07 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53020 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAYIln (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Jan 2021 03:41:43 -0500
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10P810gI4010597, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10P810gI4010597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 25 Jan 2021 16:01:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 16:00:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833]) by
 RTEXMBS04.realtek.com.tw ([fe80::ecca:80ca:53:e833%12]) with mapi id
 15.01.2106.006; Mon, 25 Jan 2021 16:00:59 +0800
From:   Hilda Wu <hildawu@realtek.com>
To:     Claire Chang <tientzu@chromium.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Max Chou <max.chou@realtek.com>
Subject: RE: [PATCH] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for btrtl
Thread-Topic: [PATCH] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY
 for btrtl
Thread-Index: AQHW7ljZ0ruzXjVhcUyIIArQ93ltkao34Wxg
Date:   Mon, 25 Jan 2021 08:00:59 +0000
Message-ID: <7df5d8b68525403ba1a252d0cd8eafe0@realtek.com>
References: <20210119114700.3662156-1-tientzu@chromium.org>
In-Reply-To: <20210119114700.3662156-1-tientzu@chromium.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.132.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Claire. Patch looks good to me.

Reviewed-by: Hilda Wu <hildawu@realtek.com>

-----Original Message-----
From: Claire Chang <tientzu@chromium.org> 
Sent: Tuesday, January 19, 2021 7:47 PM
To: marcel@holtmann.org; johan.hedberg@gmail.com; luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org; linux-kernel@vger.kernel.org; Max Chou <max.chou@realtek.com>; Hilda Wu <hildawu@realtek.com>; Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_h5: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for btrtl

Realtek Bluetooth controllers can do both LE scan and BR/EDR inquiry at once, need to set HCI_QUIRK_SIMULTANEOUS_DISCOVERY quirk.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_h5.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c index fb9817f97d45..27e96681d583 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -906,6 +906,11 @@ static int h5_btrtl_setup(struct h5 *h5)
 	/* Give the device some time before the hci-core sends it a reset */
 	usleep_range(10000, 20000);
 
+	/* Enable controller to do both LE scan and BR/EDR inquiry
+	 * simultaneously.
+	 */
+	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
+
 out_free:
 	btrtl_free(btrtl_dev);
 
--
2.30.0.284.gd98b1dd5eaa7-goog

