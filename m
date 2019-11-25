Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4024DC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B472071A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKYSjD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:39:03 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48288 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfKYSjD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 13:39:03 -0500
Received: from marcel-macbook.fritz.box (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 09236CECEF;
        Mon, 25 Nov 2019 19:48:10 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH 4/4] Bluetooth: hci_bcm: Support pcm params in dts
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANFp7mXLdmLchTKENP5-jxAWfOWNv6T+L+XR0_ALX+EF3pFB2g@mail.gmail.com>
Date:   Mon, 25 Nov 2019 19:39:01 +0100
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CBF4676C-215E-4533-B1CA-7194FDD8DC9E@holtmann.org>
References: <20191123100111.219190-4-marcel@holtmann.org>
 <CANFp7mXLdmLchTKENP5-jxAWfOWNv6T+L+XR0_ALX+EF3pFB2g@mail.gmail.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

>> BCM chips may require configuration of PCM to operate correctly and
>> there is a vendor specific HCI command to do this. Add support in the
>> hci_bcm driver to parse this from devicetree and configure the chip.
>> 
>> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>> drivers/bluetooth/hci_bcm.c | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>> 
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index d48044276895..9cfb202bbeca 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -122,6 +122,7 @@ struct bcm_device {
>>        bool                    is_suspended;
>> #endif
>>        bool                    no_early_set_baudrate;
>> +       u8                      pcm_int_params[5];
>> };
>> 
>> /* generic bcm uart resources */
>> @@ -594,6 +595,16 @@ static int bcm_setup(struct hci_uart *hu)
>>                        host_set_baudrate(hu, speed);
>>        }
>> 
>> +       /* PCM parameters if provided */
>> +       if (bcm->dev && bcm->dev->pcm_int_params[0] != 0xff) {
>> +               struct bcm_set_pcm_int_params params;
>> +
>> +               btbcm_read_pcm_int_params(hu->hdev, &params);
> This seems redundant since we just overwrite it anyway.

this is here to have it show up in btmon.

> 
>> +
>> +               memcpy(&params, bcm->dev->pcm_int_params, 5);
>> +               btbcm_write_pcm_int_params(hu->hdev, &params);
>> +       }
>> +
>> finalize:
>>        release_firmware(fw);
>> 
>> @@ -1131,6 +1142,8 @@ static int bcm_acpi_probe(struct bcm_device *dev)
>> static int bcm_of_probe(struct bcm_device *bdev)
>> {
>>        device_property_read_u32(bdev->dev, "max-speed", &bdev->oper_speed);
>> +       device_property_read_u8_array(bdev->dev, "brcm,bt-pcm-int-params",
>> +                                     bdev->pcm_int_params, 5);
>>        return 0;
>> }
>> 
>> @@ -1146,6 +1159,9 @@ static int bcm_probe(struct platform_device *pdev)
>>        dev->dev = &pdev->dev;
>>        dev->irq = platform_get_irq(pdev, 0);
>> 
>> +       /* Initialize routing field to an unsued value */
> unused
>> +       dev->pcm_int_params[0] = 0xff;
>> +
>>        if (has_acpi_companion(&pdev->dev)) {
>>                ret = bcm_acpi_probe(dev);
>>                if (ret)
>> @@ -1406,6 +1422,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>        bcmdev->serdev_hu.serdev = serdev;
>>        serdev_device_set_drvdata(serdev, bcmdev);
>> 
>> +       /* Initialize routing field to an unsued value */
> unused

Good catch. I will fix this up.

Regards

Marcel

