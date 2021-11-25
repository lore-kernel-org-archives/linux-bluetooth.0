Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73ACC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 08:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349514AbhKYI1T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:27:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53770 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236816AbhKYIZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 03:25:19 -0500
X-UUID: 49045217f8b14659bd3be9f39c3a9638-20211125
X-UUID: 49045217f8b14659bd3be9f39c3a9638-20211125
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1131555005; Thu, 25 Nov 2021 16:22:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 25 Nov 2021 16:22:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Nov 2021 16:22:04 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Bluetooth: btmtksdio: handle runtime pm only when sdio_func is available
Date:   Thu, 25 Nov 2021 16:22:03 +0800
Message-ID: <1637828523-31925-1-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <74A2D0D6-6A65-4832-BAFC-BCBA68F8DE78@holtmann.org--annotate>
References: <74A2D0D6-6A65-4832-BAFC-BCBA68F8DE78@holtmann.org--annotate>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

>>Hi Sean,
>
>> Runtime pm ops is not aware the sdio_func status that is probably
>> being disabled by btmtksdio_close. Thus, we are only able to access
>> the sdio_func for the runtime pm operations only when the sdio_func is
>> available.
>>
>> Fixes: 7f3c563c575e7 ("Bluetooth: btmtksdio: Add runtime PM support to
>> SDIO based Bluetooth")
>> Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
>> Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>> ---
>> drivers/bluetooth/btmtksdio.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btmtksdio.c
>> b/drivers/bluetooth/btmtksdio.c index 4f3412ad8fca..4c46c62e4623
>> 100644
>> --- a/drivers/bluetooth/btmtksdio.c
>> +++ b/drivers/bluetooth/btmtksdio.c
>> @@ -1037,6 +1037,9 @@ static int btmtksdio_runtime_suspend(struct device *dev)
>>	if (!bdev)
>>		return 0;
>>
>> +	if (!test_bit(HCI_RUNNING, &bdev->hdev->flags))
>> +		return 0;
>> +
>>	sdio_claim_host(bdev->func);
>>
>>	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err); @@
>> -1064,6 +1067,9 @@ static int btmtksdio_runtime_resume(struct device *dev)
>>	if (!bdev)
>>		return 0;
>>
>> +	if (!test_bit(HCI_RUNNING, &bdev->hdev->flags))
>> +		return 0;
>> +
>>	sdio_claim_host(bdev->func);
>>
>>	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);
>
>I dislike looking at HCI_RUNNING since that check should be removed from a driver. Do you really need it? I mean, a driver should now if it is running or not.

We don't really need it, instead we can use internal flags in the driver to know the status. I will do this in v2.

	Sean
>
>Regards
>
>Marcel
>
